;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules
 (gnu home)
 (gnu home services)
 (gnu home services desktop)
 (gnu home services shepherd)
 (gnu home services shells)
 (gnu home services xdg)
 (gnu packages)
 (gnu packages emacs)
 (gnu packages rust)
 (gnu packages version-control)
 (gnu packages wm)
 (gnu services)
 (guix gexp))

(define base-packages
  (append (list
	   git `(,git "send-email")
	   rust `(,rust "cargo") `(,rust "rustfmt"))
	  (map specification->package
	       (list
		"alacritty"
		"direnv"
		"firefox"
		"font-fantasque-sans"
		"font-google-noto"
		"font-iosevka"
		"guile"
		"imagemagick"
		"kdenlive"
		"lxappearance"
		"mgba"
		"mpv"
		"okular"
		"password-store"
		"pavucontrol"
		"pinentry-rofi"
		"polybar"
		"pqiv"
		"pulseaudio"
		"qt5ct"
		"quodlibet"
		"ripgrep"
		"rofi"
		"rofi-pass"
		"rsync"
		"sshfs"
		"telegram-desktop"
		"ungoogled-chromium"
		"unicode-emoji"
		))))

(define emacs-packages
  (map specification->package
       (list
	;; Emacs
	"emacs-next-pgtk"
	;; Emacs Extensions
	"emacs-ace-window"
	"emacs-all-the-icons"
	"emacs-autothemer"
	"emacs-avy"
	"emacs-consult"
	"emacs-corfu"
	"emacs-dap-mode"
	"emacs-diredfl"
	"emacs-embark"
	"emacs-envrc"
	"emacs-geiser"
	"emacs-geiser-guile"
	"emacs-guix"
	"emacs-lsp-mode"
	"emacs-lsp-ui"
	"emacs-lsp-java"
	"emacs-magit"
	"emacs-marginalia"
	"emacs-orderless"
	"emacs-org-appear"
	"emacs-org-roam"
	"emacs-org-modern"
	"emacs-password-store"
	"emacs-rust-mode"
	"emacs-svg-tag-mode"
	"emacs-use-package"
	"emacs-vertico"
	"emacs-vterm"
	"emacs-webfeeder")))

(home-environment
 (packages (append
	    base-packages
	    emacs-packages))
 (services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (guix-defaults? #t)
		  (environment-variables
		   '(("QT_QPA_PLATFORMTHEME" . "qt5ct")))))
        (service home-fish-service-type
		 (home-fish-configuration
		  (aliases
		   '(("ll" . "ls -l")
		     ("mvi" . "mpv --config-dir=$HOME/.config/mvi")))
		  (config
		   (list (local-file "files/fish/config.fish")))))
	(simple-service 'fish-config
			home-files-service-type
			(list `(".config/fish/conf.d/catppuccin.fish"
				,(local-file "files/fish/catppuccin.fish"))))
	(simple-service 'polybar-config
		       home-files-service-type
		       (list `(".config/polybar/config.ini"
			       ,(local-file "files/polybar/config.ini"))))
	(simple-service 'sxhkd-config
			home-files-service-type
			(list `(".config/sxhkd/sxhkdrc"
				,(local-file "files/sxhkd/sxhkdrc"))))
	;; (simple-service 'bspwm-config
	;; 		home-files-service-type
	;; 		(list `(".config/bspwm/bspwmrc"
	;; 			,(local-file "files/bspwm/bspwmrc"))))
	(service home-xdg-user-directories-service-type
		 (home-xdg-user-directories-configuration
		  (download "$HOME/Downloads")
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
			(list `(".config/alacritty/alacritty.yml"
				,(local-file "files/alacritty/alacritty.yml"))))
	(simple-service 'rofi-config
			home-files-service-type
			(list `(".config/rofi/config.rasi"
				,(local-file "files/rofi/config.rasi"))
			      `(".local/share/rofi/themes/catppuccin.rasi"
				,(local-file "files/rofi/catppuccin.rasi"))))
	(simple-service 'gtk-config
			home-files-service-type
			(list `(".themes"
				,(local-file "files/gtk"
					     #:recursive? #t))))
	(service home-shepherd-service-type
		 (home-shepherd-configuration
		  (services (append (list ;; I thought this isn't needed?
				     (shepherd-service
				      (documentation "Emacs server.")
				      (provision '(emacs-server))
				      (start #~(make-forkexec-constructor
						(list #$(file-append emacs "/bin/emacs" "--daemon"))))
				      (stop #~(make-kill-destructor))))))))
	(simple-service 'emacs-config
			home-files-service-type
                        (list `(".config/emacs/init.el"
				,(local-file "files/emacs/init.el"))
                              `(".config/emacs/early-init.el"
				,(local-file "files/emacs/early-init.el"))
			      `(".config/emacs/modules"
				,(local-file "files/emacs/modules"
					     #:recursive? #t)))))))
