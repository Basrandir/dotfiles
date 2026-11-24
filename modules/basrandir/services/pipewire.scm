(define-module (basrandir services pipewire)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services xdg)
  #:use-module (gnu packages linux)
  #:use-module (gnu services configuration)
  #:use-module (guix records)
  #:use-module (guix gexp)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match)
  #:export (home-pulseaudio-rtp-sink-service-type
            home-pulseaudio-rtp-source-service-type
            %pulseaudio-rtp-multicast-address

            home-pipewire-configuration
            home-pipewire-service-type))

(define-configuration/no-serialization home-pipewire-configuration
  (pipewire
   (file-like pipewire)
   "The PipeWire package to use.")
  (wireplumber
   (file-like wireplumber)
   "The WirePlumber package to use.")
  (enable-pulseaudio?
   (boolean #t)
   "When true, enable PipeWire's PulseAudio emulation support, allowing
PulseAudio clients to use PipeWire transparently."))

(define (home-pipewire-shepherd-service config)
  (shepherd-service
   (documentation "PipeWire media processing.")
   (provision '(pipewire))
   (requirement '(dbus))
   (start #~(make-forkexec-constructor
             (list #$(file-append
                      (home-pipewire-configuration-pipewire config)
                      "/bin/pipewire"))))
   (stop #~(make-kill-destructor))))

(define (home-pipewire-pulseaudio-shepherd-service config)
  (shepherd-service
   (documentation "Drop-in PulseAudio replacement service for PipeWire.")
   (provision '(pipewire-pulseaudio))
   (requirement '(pipewire))
   (start #~(make-forkexec-constructor
             (list #$(file-append
                      (home-pipewire-configuration-pipewire config)
                      "/bin/pipewire-pulse"))))
   (stop #~(make-kill-destructor))))

(define (home-wireplumber-shepherd-service config)
  (shepherd-service
   (documentation "WirePlumber session management for PipeWire.")
   (provision '(wireplumber))
   (requirement '(pipewire))
   (start #~(make-forkexec-constructor
             (list #$(file-append
                      (home-pipewire-configuration-wireplumber config)
                      "/bin/wireplumber"))))
   (stop #~(make-kill-destructor))))

(define (home-pipewire-shepherd-services config)
  (cons* (home-pipewire-shepherd-service config)
         (home-wireplumber-shepherd-service config)
         (if (home-pipewire-configuration-enable-pulseaudio? config)
             (list (home-pipewire-pulseaudio-shepherd-service config))
             '())))

(define (home-pipewire-asoundrc config)
  (mixed-text-file
   "asoundrc"
   #~(string-append
      "<"
      #$(file-append
         (home-pipewire-configuration-pipewire config)
         "/share/alsa/alsa.conf.d/50-pipewire.conf")
      ">\n"
      "<"
      #$(file-append
         (home-pipewire-configuration-pipewire config)
         "/share/alsa/alsa.conf.d/99-pipewire-default.conf")
      ">\n"
      "pcm_type.pipewire {\n"
      "  lib \""
      #$(file-append
         (home-pipewire-configuration-pipewire config)
         "/lib/alsa-lib/libasound_module_pcm_pipewire.so")
      "\"\n}\n"
      "ctl_type.pipewire {\n"
      "  lib \""
      #$(file-append
         (home-pipewire-configuration-pipewire config)
         "/lib/alsa-lib/libasound_module_ctl_pipewire.so")
      "\"\n}\n")))

(define home-pipewire-disable-pulseaudio-auto-start
  (plain-file "client.conf" "autospawn = no"))

(define (home-pipewire-xdg-configuration config)
  (cons* `("alsa/asoundrc" ,(home-pipewire-asoundrc config))
         (if (home-pipewire-configuration-enable-pulseaudio? config)
             `(("pulse/client.conf"
                ,home-pipewire-disable-pulseaudio-auto-start))
             '())))

(define home-pipewire-service-type
  (service-type
   (name 'pipewire)
   (extensions
    (list (service-extension home-shepherd-service-type
                             home-pipewire-shepherd-services)
          (service-extension home-xdg-configuration-files-service-type
                             home-pipewire-xdg-configuration)))
   (description
    "Start essential PipeWire services.")
   (default-value (home-pipewire-configuration))))
