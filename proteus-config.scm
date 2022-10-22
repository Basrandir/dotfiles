;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.

(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 
 (host-name "proteus")
 (timezone "America/Toronto")
 (keyboard-layout (keyboard-layout "us" "altgr-intl"))
 (locale "en_CA.utf8")

 ;; Use the UEFI variant of GRUB with the EFI System
 ;; Partition mounted on /boot/efi.
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets '("/boot/efi"))
	      (keyboard-layout keyboard-layout)))
 
 (swap-devices (list (swap-space
                      (target (uuid
                               "3dd9c567-ff89-4999-99e5-abed78766dc4")))))
 
 ;; Assume the target root file system is labelled "my-root",
 ;; and the EFI System Partition has UUID 1234-ABCD.
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

 (users (cons (user-account
               (name "bassam")
               (comment "Bassam Saeed")
               (group "users")
	       (home-directory "/home/bassam")
               (supplementary-groups '("wheel" "netdev"
                                       "audio" "video")))
              %base-user-accounts))
 
 ;; Add a bunch of window managers; we can choose one at
 ;; the log-in screen with F1.
 (packages (append (list
		    (specification->package "bspwm")
                    (specification->package "sxhkd")
                    (specification->package "xsetroot")
		    (specification->package "openssh")
                    (specification->package "gnupg")
                    (specification->package "pinentry")
                    (specification->package "nss-certs"))
                   %base-packages))
 
 ;; Use the "desktop" services, which include the X11
 ;; log-in service, networking with NetworkManager, and more.
 (services
  (append (list (service cups-service-type)
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
EndSection")))))
	  
	  (modify-services %desktop-services
			   (guix-service-type config => (guix-configuration
							 (inherit config)
							 (substitute-urls
							  (append (list "https://substitutes.nonguix.org")
								  %default-substitute-urls))
							 (authorized-keys
							  (append (list (local-file "./signing-key.pub"))
								  %default-authorized-guix-keys)))))))

 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
