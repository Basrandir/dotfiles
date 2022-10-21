;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.

(use-modules (gnu) (gnu system nss)
             (gnu packages gnupg)
             (gnu packages ssh)
             (gnu packages wm)
             (gnu packages xdisorg)
             (nongnu packages linux)
             (nongnu system linux-initrd))
(use-service-modules desktop shepherd sound xorg)
(use-package-modules bootloaders certs xorg)

(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 
 (host-name "polaris")
 (timezone "America/Toronto")
 (locale "en_US.utf8")

 ;; Use the UEFI variant of GRUB with the EFI System
 ;; Partition mounted on /boot/efi.
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets '("/boot/efi"))))

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

 (users (cons (user-account
               (name "bassam")
               (comment "Bassam Saeed")
               (group "users")
               (supplementary-groups '("wheel" "netdev"
                                       "audio" "video")))
              %base-user-accounts))
 
 ;; Add a bunch of window managers; we can choose one at
 ;; the log-in screen with F1.
 (packages (append (list
                    ;; window manager
		    bspwm sxhkd xsetroot
		    openssh
		    gnupg pinentry
                    ;; for HTTPS access
                    nss-certs)
                   %base-packages))
 
 ;; Use the "desktop" services, which include the X11
 ;; log-in service, networking with NetworkManager, and more.
 (services (append (list
		    (set-xorg-configuration
                          (xorg-configuration
                           (extra-config '("Section \"Device\"
                                              Identifier \"AMD\"
                                              Driver     \"amdgpu\"
                                              Option     \"TearFree\" \"true\"
                                            EndSection

					   Section \"InputClass\"
                                              Identifier \"touchpad\"
                                              Driver \"libinput\"
                                              MatchIsTouchpad \"on\"
                                              Option \"NaturalScrolling\"  \"true\"
                                            EndSection")))))
                   %desktop-services))
 
 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
