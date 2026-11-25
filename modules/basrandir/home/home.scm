(define-module (basrandir home)
  #:use-module (basrandir home packages)
  #:use-module (basrandir services pipewire)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services xdg)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages rust)
  #:use-module (gnu services)
  #:use-module (guix gexp))

(home-environment
 (packages (append
	    base-home-packages
	    emacs-packages))
 (services
  (list (service home-dbus-service-type)
	(service home-pipewire-service-type)
	(service home-gpg-agent-service-type
		 (home-gpg-agent-configuration
		  (pinentry-program
		   (file-append pinentry-gnome3 "/bin/pinentry-gnome3"))
		  (ssh-support? #t)))
	(service home-bash-service-type
                 (home-bash-configuration
                  (guix-defaults? #t)
		  (environment-variables
		   '(("QT_QPA_PLATFORMTHEME" . "qt5ct")
		     ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share")
		     ("MOZ_ENABLE_WAYLAND" . "1")
		     ("XDG_CURRENT_DESKTOP" . "niri")
		     ("RTC_USE_PIPEWIRE" . "true")
		     ("PATH" . "$PATH:$HOME/bin:$HOME/scripts:$HOME/.local/bin")))))
        (service home-fish-service-type
		 (home-fish-configuration
		  (aliases
		   '(("ll" . "ls -l")
		     ("mvi" . "mpv --config-dir=$HOME/.config/mvi")))
		  (config
		   (list (local-file "../../../files/fish/config.fish")))))
	(simple-service 'scripts-config
			home-files-service-type
			(list `("scripts"
				,(local-file "../../../files/scripts"
					     #:recursive? #t))))
	(simple-service 'sxhkd-config
			home-files-service-type
			(list `(".config/sxhkd/sxhkdrc"
				,(local-file "../../../files/sxhkd/sxhkdrc"))))
	;; BSPWM and River configs need to be executable. Need to find
	;; a way to accomplish that using Guix (home)
	;; (simple-service 'bspwm-config
	;; 		home-files-service-type
	;; 		(list `(".config/bspwm/bspwmrc"
	;; 			,(local-file "../../../files/bspwm/bspwmrc"))))
	;; (simple-service 'river-config
	;; 		home-files-service-type
	;; 		(list `(".config/river/init"
	;; 			,(local-file "../../../files/river/init"))))
	(service home-xdg-user-directories-service-type
		 (home-xdg-user-directories-configuration
		  (download "$HOME/downloads")
		  (videos "$HOME/media/videos")
		  (music "$HOME/media/music")
		  (pictures "$HOME/media/images")
		  (documents "$HOME/doc")
		  (publicshare "$HOME")
		  (templates "$HOME")
		  (desktop "$HOME")))
	(service home-redshift-service-type
		 (home-redshift-configuration
		  (location-provider 'manual)
		  (latitude 43.59)
		  (longitude -79.64)))
	(simple-service 'alacritty-config
			home-files-service-type
			(list `(".config/alacritty/alacritty.toml"
				,(local-file "../../../files/alacritty/alacritty.toml"))))
	(simple-service 'rofi-config
			home-files-service-type
			(list `(".config/rofi/config.rasi"
				,(local-file "../../../files/rofi/config.rasi"))
			      `(".local/share/rofi/themes/rounded-template.rasi"
				,(local-file "../../../files/rofi/rounded-template.rasi"))))
	(simple-service 'gtk-config
			home-files-service-type
			(list `(".themes"
				,(local-file "../../../files/gtk"
					     #:recursive? #t))))
	(simple-service 'isync-config
			home-files-service-type
			(list `(".mbsyncrc"
				,(local-file "../../../files/isync/mbsyncrc"))))
	(service home-shepherd-service-type
		 (home-shepherd-configuration
		  (services (append (list ;; I thought this isn't needed?
				     (shepherd-service
				      (documentation "Emacs server.")
				      (provision '(emacs-server))
				      (start #~(make-forkexec-constructor
						(list #$(file-append emacs-next-pgtk "/bin/emacs")
						      "--fg-daemon=server")))
				      (stop #~(make-kill-destructor))))))))
	(simple-service 'podman-configs
			home-xdg-configuration-files-service-type
			`(("containers/registries.conf"
			   ,(plain-file
			     "registries.conf"
			     "unqualified-search-registries = ['docker.io', \
'registry.fedoraproject.org', \
'registry.access.redhat.com', \
'registry.centos.org']"))
			  ("containers/storage.conf"
			   ,(plain-file
			     "storage.conf"
			     "[storage]\ndriver = \"overlay\""))
			  ("containers/policy.json"
			   ,(plain-file
			     "policy.json"
			     "{\"default\": [{\"type\": \"insecureAcceptAnything\"}]}"))))
	(simple-service 'emacs-config
			home-files-service-type
                        (list `(".config/emacs/init.el"
				,(local-file "../../../files/emacs/init.el"))
                              `(".config/emacs/early-init.el"
				,(local-file "../../../files/emacs/early-init.el"))
			      `(".config/emacs/templates"
				,(local-file "../../../files/emacs/templates"))
			      `(".config/emacs/elfeed.org"
				,(local-file "../../../files/emacs/elfeed.org"))
			      `(".config/emacs/modules"
				,(local-file "../../../files/emacs/modules"
					     #:recursive? #t)))))))
