(define-module (basrandir systems proteus)
  #:use-module (basrandir systems base)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems))

(use-service-modules xorg)
(use-package-modules xorg)

(define proteus-packages
  (cons* (map specification->package
	     '("light"))
	 base-system-packages))

(define proteus-services
  (cons* (service cups-service-type)
	 (bluetooth-service #:auto-enable? #t)
	 (udev-rules-service 'light light)
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
	 
	 (modify-services %desktop-services
			  (guix-service-type config => (guix-configuration
							(inherit config)
							(substitute-urls
							 (append (list "https://substitutes.nonguix.org")
								 %default-substitute-urls))
							(authorized-keys
							 (append (list (local-file "./signing-key.pub"))
								 %default-authorized-guix-keys)))))
	 base-system-services))

(operating-system
 (inherit base-operating-system)
 (host-name "proteus")
 
 (swap-devices (list (swap-space
                      (target (uuid
                               "3dd9c567-ff89-4999-99e5-abed78766dc4")))))
 
 (file-systems (append
                (list (file-system
                       (device (uuid "0c71d2d1-83a2-4b6b-a2c5-cfcfc996d232" 'ext4))
                       (mount-point "/")
                       (type "ext4"))
                      (file-system
                       (device (uuid "B134-3679" 'fat32))
                       (mount-point "/boot/efi")
                       (type "vfat")))
                %base-file-systems))
 
 (packages proteus-packages)
 (services proteus-services))
