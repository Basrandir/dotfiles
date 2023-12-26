(define-module (basrandir home)
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
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages wm)
  #:use-module (gnu services)
  #:use-module (guix gexp))

(define base-home-packages
  (append (list
	   git `(,git "send-email")
	   rust `(,rust "cargo") `(,rust "tools"))
	  (map specification->package
	       (list
		;; Wayland Desktop Environment
		"fuzzel"
		"waybar"
		"swaybg"
		"slurp"
		"grim"
		
		"alacritty"
		"anki"
		"binutils"
		"direnv"
		"fd"
		"ffmpegthumbnailer"
		"firefox"
		"font-google-noto"
		"font-google-noto-emoji"
		"font-google-noto-sans-cjk"
		"font-google-noto-serif-cjk"
		"font-recursive"
		"gcc-toolchain"
		"glibc"
		"guile"
		"hunspell-dict-en-us"
		"imagemagick"
		"isync"
		"kdenlive"
		"lxappearance"
		"mediainfo"
		"mgba"
		"mpv"
		"neovim"
		"notmuch"
		"obs"
		"okular"
		"pamixer"
		"password-store"
		"pavucontrol"
		"pinentry-emacs"
		"pinentry-gnome3"
		"polybar"
		"pqiv"
		"pulseaudio"
		"qt5ct"
		"quodlibet"
		"ripgrep"
		"rsync"
		"sshfs"
		"steam"
		"telegram-desktop"
		"ungoogled-chromium"
		"unicode-emoji"
		"unzip"
		"virt-manager"
		"xdg-utils"
		))))

(define emacs-packages
  (map specification->package
       (list
	;; Emacs
	;; "emacs-next-tree-sitter" ;; For Xorg
	"emacs-next-pgtk" ;; For Wayland
	;; Emacs Extensnions
	"emacs-ace-window"
	"emacs-apheleia"
	"emacs-autothemer"
	"emacs-avy"
	"emacs-consult"
	"emacs-corfu"
	"emacs-dap-mode"
	;;"emacs-denote"
	"emacs-diff-hl"
	"emacs-diredfl"
	"emacs-eat"
	"emacs-embark"
	"emacs-envrc"
	"emacs-hide-mode-line"
	"emacs-jinx"
	"emacs-kind-icon"
	"emacs-magit"
	"emacs-marginalia"
	"emacs-meow"
	"emacs-notmuch"
	"emacs-orderless"
	"emacs-org-appear"
	"emacs-org-modern"
	"emacs-password-store"
	"emacs-pdf-tools"
	"emacs-rainbow-mode"
	"emacs-rust-mode"
	"emacs-svg-tag-mode"
	"emacs-telega"
	"emacs-tempel"
	"emacs-tempel-collection"
	"emacs-eglot-tempel"
	"emacs-vertico"
	"emacs-vertico-posframe"
	"emacs-vterm"
	"emacs-webfeeder")))

(home-environment
 (packages (append
	    base-home-packages
	    emacs-packages))
 (services
  (list (service home-gpg-agent-service-type
		 (home-gpg-agent-configuration
		  (pinentry-program
		   (file-append pinentry-gnome3 "/bin/pinentry-gnome3"))
		  (ssh-support? #t)))
	(service home-bash-service-type
                 (home-bash-configuration
                  (guix-defaults? #t)
		  (environment-variables
		   '(("QT_QPA_PLATFORMTHEME" . "qt5ct")
		     ("MOZ_ENABLE_WAYLAND" . "1")
		     ("PATH" . "$PATH:$HOME/bin")))))
        (service home-fish-service-type
		 (home-fish-configuration
		  (aliases
		   '(("ll" . "ls -l")
		     ("mvi" . "mpv --config-dir=$HOME/.config/mvi")))
		  (config
		   (list (local-file "../files/fish/config.fish")))))
	;(simple-service 'fish-config
	;		home-files-service-type
	;		(list `(".config/fish/conf.d/angmar.fish"
	;			,(local-file "../files/fish/angmar.fish"))))
	(simple-service 'polybar-config
			home-files-service-type
			(list `(".config/polybar/config.ini"
				,(local-file "../files/polybar/config.ini"))))
	(simple-service 'waybar-config
			home-files-service-type
			(list `(".config/waybar"
				,(local-file "../files/waybar"
					     #:recursive? #t))))
	(simple-service 'sxhkd-config
			home-files-service-type
			(list `(".config/sxhkd/sxhkdrc"
				,(local-file "../files/sxhkd/sxhkdrc"))))
	;; BSPWM and River configs need to be executable. Need to find
	;; a way to accomplish that using Guix (home)
	;; (simple-service 'bspwm-config
	;; 		home-files-service-type
	;; 		(list `(".config/bspwm/bspwmrc"
	;; 			,(local-file "files/bspwm/bspwmrc"))))
	;; (simple-service 'river-config
	;; 		home-files-service-type
	;; 		(list `(".config/river/init"
	;; 			,(local-file "../files/river/init"))))
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
	;(simple-service 'isync-config
	;		home-files-service-type
	;		(list `(".mbsyncrc"
	;			,(local-file "../files/isync/mbsyncrc"))))
	(service home-shepherd-service-type
		 (home-shepherd-configuration
		  (services (append (list ;; I thought this isn't needed?
				     (shepherd-service
				      (documentation "Emacs server.")
				      (provision '(emacs-server))
				      (start #~(make-forkexec-constructor
						(list #$(file-append emacs-next-pgtk "/bin/emacs --fg-daemon=server"))))
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
