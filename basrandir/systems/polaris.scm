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
			      (uuid "9565cc80-88e4-4f07-80e9-06017c9a2ee0")))))
  
  ;; Assume the target root file system is labelled "my-root",
  ;; and the EFI System Partition has UUID 1234-ABCD.
  (file-systems (append
                 (list (file-system
			 (device (uuid "eb08e4ac-c876-4a5d-98d1-b57365d4be65"))
			 (mount-point "/")
			 (type "ext4"))
                       (file-system
			 (device (uuid "BF48-5B66" 'fat))
			 (mount-point "/boot/efi")
			 (type "vfat")))
                 %base-file-systems))

  (services polaris-services))
