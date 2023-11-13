(define-module (basrandir systems base)
  #:use-module (basrandir packages)
  #:use-module (srfi srfi-1)
  #:use-module (gnu)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (gnu system nss)
  #:use-module (gnu system setuid)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)

  #:export (base-system-packages
	    base-system-services))

(use-service-modules desktop nix xorg) ;;shepherd sound xorg)
;; (use-package-modules bootloaders certs xorg)

(define base-system-packages
  (append (map specification->package
	       '("openssh"
		 "gnupg"
		 "pinentry"
		 "river"
		 "nix"
		 "nss-certs"))
	  %base-packages))

(define base-system-services
  (cons* (service nix-service-type)
	 (service bluetooth-service-type
		  (bluetooth-configuration
		   (auto-enable? #t)))
         (modify-services %desktop-services
			  (gdm-service-type config => (gdm-configuration
						       (inherit config)
						       (wayland? #t))))))

(define-public base-operating-system
  (operating-system
    (timezone "America/Toronto")
    (locale "en_US.utf8")
    (host-name "polaris") ;; Required, will be overriden

    ;; Use non-free Linux and firmware
    (kernel linux)
    (firmware (list linux-firmware))
    (initrd microcode-initrd)

    (bootloader (bootloader-configuration
		 (bootloader grub-efi-bootloader)
		 (targets '("/boot/efi"))))

    ;; Required, will be overriden
    (file-systems (cons*
                   (file-system
                     (mount-point "/")
                     (device "none")
                     (type "tmpfs")
                     (check? #f))
                   %base-file-systems))

    (users (cons (user-account
		  (name "bassam")
		  (comment "Bassam Saeed")
		  (group "users")
		  (supplementary-groups '("wheel" "netdev" "lp"
					  "audio" "video")))
		 %base-user-accounts))

    (packages base-system-packages)
    (services base-system-services)

    ;; Allow resolution of '.local' host names with mDNS
    (name-service-switch %mdns-host-lookup-nss)))
