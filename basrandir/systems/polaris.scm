(define-module (basrandir systems polaris)
  #:use-module (basrandir systems base)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems))

(use-service-modules xorg)
(use-package-modules xorg)

(define polaris-services
  (cons (set-xorg-configuration
         (xorg-configuration
          (extra-config
           '("Section \"Device\"
  Identifier \"AMD\"
  Driver     \"amdgpu\"
  Option     \"TearFree\" \"true\"
EndSection

Section \"InputClass\"
  Identifier \"touchpad\"
  Driver \"libinput\"
  MatchIsTouchpad \"on\"
  Option \"NaturalScrolling\"  \"true\"
EndSection"))))
        base-system-services))

(operating-system
  (inherit base-operating-system)
  (host-name "polaris")
  
  (swap-devices (list
                 (swap-space (target
			      (uuid "98d54898-5d10-420d-b9b2-51e0931818a2")))))
  
  ;; Assume the target root file system is labelled "my-root",
  ;; and the EFI System Partition has UUID 1234-ABCD.
  (file-systems (append
                 (list (file-system
			 (device (uuid "c5962eb1-c0bf-46fb-8a16-2b2d65249785"))
			 (mount-point "/")
			 (type "ext4"))
                       (file-system
			 (device (uuid "DC47-9D61" 'fat))
			 (mount-point "/boot/efi")
			 (type "vfat")))
                 %base-file-systems))

  (services polaris-services))
