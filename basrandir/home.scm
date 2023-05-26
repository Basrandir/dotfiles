(define-module (basrandir home)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services xdg)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages wm)
  #:use-module (gnu services)
  #:use-module (guix gexp))

(define base-home-packages
  (append (list
	   git `(,git "send-email")
	   rust `(,rust "cargo") `(,rust "rustfmt"))
	  (map specification->package
	       (list
		"alacritty"
		"anki"
		"binutils"
		"direnv"
		"fd"
		"ffmpegthumbnailer"
		"firefox"
		"font-google-noto"
		"font-recursive"
		"gcc-toolchain"
		"glibc"
		"guile"
		"imagemagick"
		"kdenlive"
		"lxappearance"
		"mediainfo"
		"mgba"
		"mpv"
		"obs"
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
		"unzip"
		"xdg-utils"
		))))

(define emacs-packages
  (map specification->package
       (list
	;; Emacs
	"emacs-next-tree-sitter"
	;; Emacs Extensnions
	"emacs-ace-window"
	"emacs-apheleia"
	"emacs-autothemer"
	"emacs-avy"
	"emacs-consult"
	"emacs-corfu"
	"emacs-dap-mode"
	"emacs-diff-hl"
	"emacs-diredfl"
	"emacs-eat"
	"emacs-embark"
	"emacs-envrc"
	"emacs-hide-mode-line"
	"emacs-kind-icon"
	"emacs-magit"
	"emacs-marginalia"
	"emacs-meow"
	"emacs-orderless"
	"emacs-org-appear"
	"emacs-org-modern"
	"emacs-password-store"
	"emacs-pdf-tools"
	"emacs-rainbow-mode"
	"emacs-rust-mode"
	"emacs-svg-tag-mode"
	"emacs-tempel"
	"emacs-tempel-collection"
	"emacs-eglot-tempel"
	"emacs-vertico"
	"emacs-vterm"
	"emacs-webfeeder")))

(home-environment
 (packages (append
	    base-home-packages
	    emacs-packages))
 (services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (guix-defaults? #t)
		  (environment-variables
		   '(("QT_QPA_PLATFORMTHEME" . "qt5ct")
		     ("PATH" . "$PATH:$HOME/bin")))))
        (service home-fish-service-type
		 (home-fish-configuration
		  (aliases
		   '(("ll" . "ls -l")
		     ("mvi" . "mpv --config-dir=$HOME/.config/mvi")))
		  (config
		   (list (local-file "../files/fish/config.fish")))))
	(simple-service 'fish-config
			home-files-service-type
			(list `(".config/fish/conf.d/catppuccin.fish"
				,(local-file "../files/fish/catppuccin.fish"))))
	(simple-service 'polybar-config
		       home-files-service-type
		       (list `(".config/polybar/config.ini"
			       ,(local-file "../files/polybar/config.ini"))))
	(simple-service 'sxhkd-config
			home-files-service-type
			(list `(".config/sxhkd/sxhkdrc"
				,(local-file "../files/sxhkd/sxhkdrc"))))
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
				,(local-file "../files/alacritty/alacritty.yml"))))
	(simple-service 'rofi-config
			home-files-service-type
			(list `(".config/rofi/config.rasi"
				,(local-file "../files/rofi/config.rasi"))
			      `(".local/share/rofi/themes/catppuccin.rasi"
				,(local-file "../files/rofi/catppuccin.rasi"))))
	(simple-service 'gtk-config
			home-files-service-type
			(list `(".themes"
				,(local-file "../files/gtk"
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
				,(local-file "../files/emacs/init.el"))
                              `(".config/emacs/early-init.el"
				,(local-file "../files/emacs/early-init.el"))
			      `(".config/emacs/templates"
				,(local-file "../files/emacs/templates"))
			      `(".config/emacs/modules"
				,(local-file "../files/emacs/modules"
					     #:recursive? #t)))))))
