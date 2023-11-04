(define-module (basrandir systems proteus)
  #:use-module (basrandir systems base)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems))

(use-service-modules cups desktop pm xorg)
(use-package-modules linux xorg)

(define proteus-packages
  (append (map specification->package
	       '("light"))
	  base-system-packages))

(define proteus-services
  (cons* (service cups-service-type)
	 (service bluetooth-service-type
                  (bluetooth-configuration
                   (auto-enable? #t)))
	 (udev-rules-service 'light light)
	 (service tlp-service-type
		  (tlp-configuration
		   (cpu-scaling-governor-on-ac (list "performance"))
		   (cpu-scaling-governor-on-bat (list "powersave"))
		   (sched-powersave-on-bat? #t)))
	 (set-xorg-configuration
          (xorg-configuration
           (extra-config '("Section \"Device\"
  Identifier \"Intel Graphics\"
  Driver     \"intel\"
  Option     \"TearFree\" \"true\"
EndSection

Section \"InputClass\"
  Identifier \"touchpad\"
  Driver \"libinput\"
  MatchIsTouchpad \"on\"
  Option \"Tapping\" \"on\"
  Option \"NaturalScrolling\"  \"true\"
EndSection"))))
	 
	 (modify-services base-system-services
			  (guix-service-type config => (guix-configuration
							(inherit config)
							(substitute-urls
							 (append (list "https://substitutes.nonguix.org")
								 %default-substitute-urls))
							(authorized-keys
							 (append (list (local-file "../../signing-key.pub"))
								 %default-authorized-guix-keys)))))
	 ))

(operating-system
 (inherit base-operating-system)
 (host-name "proteus")
 
 (swap-devices (list (swap-space
                      (target (uuid
                               "d1b13220-e253-4fa7-bc2b-38b8d37aef07")))))
 
 (file-systems (append
                (list (file-system
                       (device (uuid "3e28816d-9c31-465a-b126-0f632e200ed5" 'ext4))
                       (mount-point "/")
                       (type "ext4"))
                      (file-system
                       (device (uuid "B223-C489" 'fat32))
                       (mount-point "/boot/efi")
                       (type "vfat")))
                %base-file-systems))
 
 (packages proteus-packages)
 (services proteus-services))
