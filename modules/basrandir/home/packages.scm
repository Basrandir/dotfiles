(define-module (basrandir home packages)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages version-control)
  #:export (base-home-packages
	    emacs-packages))

(define base-home-packages
  (append (list
	   git `(,git "send-email")
	   ;; rust `(,rust "cargo") `(,rust "tools")
	   glib `(,glib "bin"))
	  (map specification->package
	       (list
		;; Wayland Desktop Environment
		"fuzzel"
		"swaybg"
		"slurp"
		"grim"
		"swaynotificationcenter"

		"alacritty"
		"bibata-cursor-theme"
		"binutils"
		"curl"
		"darktable"
		"direnv"
		"distrobox"
		"element-desktop"
		"fd"
		"ffmpegthumbnailer"
		"firefox"
		"flatpak"
		"font-google-noto"
		"font-google-noto-emoji"
		"font-google-noto-sans-cjk"
		"font-google-noto-serif-cjk"
		"font-wqy-zenhei"	; CJK for Steam
		"gammastep"
		"gcc-toolchain"
		"glibc"
		"go"
		"gopls"
		"gtk-layer-shell"
		"guile"
		"hicolor-icon-theme"
		"hunspell-dict-en-us"
		"imagemagick"
		"isync"
		"kmonad"
		"llama-cpp"
		"lxappearance"
		"mediainfo"
		"mesa"
		"mgba"
		"mpv"
		"neovim"
		"notmuch"
		"obs"
		"pamixer"
		"password-store"
		"pavucontrol"
		"pinentry-emacs"
		"pinentry-gnome3"
		"podman"
		"polybar"
		"pqiv"
		"pulseaudio"
		"qt5ct"
		"qtwayland"
		"quodlibet"
		"recoll"
		"ripgrep"
		"rofi"
		"rsync"
		"sshfs"
		"steam"
		"steam-devices-udev-rules"
		"telegram-desktop"
		"unicode-emoji"
		"unzip"
		"virt-manager"
		"wl-clipboard"
		"xdg-desktop-portal-gtk"
		"xdg-desktop-portal-hyprland"
		"xdg-utils"
		"yt-dlp"
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
	"emacs-dashboard"
	"emacs-dap-mode"
	"emacs-denote"
	"emacs-denote-journal"
	"emacs-denote-sequence"
	"emacs-diff-hl"
	"emacs-diredfl"
	"emacs-dwim-shell-command"
	"emacs-eat"
	"emacs-ef-themes"
	;; Elfeed
	"emacs-elfeed"
	"emacs-elfeed-goodies"
	"emacs-elfeed-protocol"
	"emacs-elfeed-org"
	"emacs-embark"
	"emacs-envrc"
	"emacs-gleam-mode"
	"emacs-go-mode"
	"emacs-gptel"
	"emacs-gptel-quick"
	"emacs-guix"
	"emacs-hide-mode-line"
	"emacs-jinx"
	"emacs-kbd"
	"emacs-magit"
	"emacs-marginalia"
	"emacs-meow"
	"emacs-notmuch"
	"emacs-olivetti"
	"emacs-orderless"
	"emacs-org-appear"
	"emacs-org-timeblock"
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
