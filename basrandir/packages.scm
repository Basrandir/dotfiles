(define-module (basrandir packages)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages man)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages zig)
  #:use-module (guix build-system gnu)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages))

(define-public river
  (package
    (name "river")
    (version "0.2.4")
    (source (origin
	      (method git-fetch)
	      (uri (git-reference
		    (url "https://github.com/riverwm/river.git")
		    (commit (string-append "v" version))
		    (recursive? #t)))
	      (file-name (git-file-name name version))
	      (sha256
	       (base32
		"1nvhqs6wwisf8ama7y1y3q3nf2jm9sh5bn46z8kyds8cikm0x1vh"))))
    (build-system gnu-build-system)
    (inputs (list libevdev libxkbcommon pixman pkg-config scdoc wayland wayland-protocols wlroots zig))
    (arguments
     (list #:phases #~(modify-phases %standard-phases
			(delete 'configure)
			(replace 'build
			  (lambda* (#:key outputs #:allow-other-keys)
			    (let ((out (assoc-ref outputs "out")))
			      (setenv "ZIG_GLOBAL_CACHE_DIR" (string-append (getcwd) "/zig-cache"))
			      (invoke "zig" "build" "-Drelease-safe" "-Dxwayland" "--prefix" out "install"))))
			(add-after 'build 'create-desktop-file
			  (lambda* (#:key outputs #:allow-other-keys)
			    (let* ((out (assoc-ref outputs "out"))
				   (wayland-sessions (string-append out "/share/wayland-sessions")))
			      (mkdir-p wayland-sessions)
			      (copy-file "contrib/river.desktop" (string-append wayland-sessions "/river.desktop")))))
			(delete 'check)
			(delete 'install))))
    (home-page "https://github.com/riverwm/river")
    (synopsis "Dynamic tiling wayland compositor")
    (description "River is a dynamic tiling wayland compositor.")
    (license license:expat)))

(define-public xdg-desktop-portal
  (package
    (name "xdg-desktop-portal")
    (version "1.18.2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/flatpak/xdg-desktop-portal/releases/download/"
             version "/xdg-desktop-portal-" version ".tar.xz"))
       (sha256
        (base32
         "0h7l8l2y0f4rhl1zqlkc21r2y50b5wd1644sg88zvaknajf27b6z"))))
    (build-system meson-build-system)
    (native-inputs
     (list
      bubblewrap
      pkg-config
      `(,glib "bin")
      which
      gettext-minimal))
    (inputs
     (list
      gdk-pixbuf
      glib
      flatpak
      fontconfig
      json-glib
      libportal
      dbus
      geoclue
      pipewire
      fuse))
    (arguments
     `(#:configure-flags
       (list "-Dsystemd=disabled")
       #:tests? #f
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'po-chmod
           (lambda _
             ;; Make sure 'msgmerge' can modify the PO files.
             (for-each (lambda (po)
                         (chmod po #o666))
                       (find-files "po" "\\.po$"))))
         (add-after 'unpack 'set-home-directory
           (lambda _ (setenv "HOME" "/tmp"))))))
    (native-search-paths
     (list (search-path-specification
            (variable "XDG_DESKTOP_PORTAL_DIR")
            (separator #f)
            (files '("share/xdg-desktop-portal/portals")))))
    (home-page "https://github.com/flatpak/xdg-desktop-portal")
    (synopsis "Desktop integration portal for sandboxed apps")
    (description
     "xdg-desktop-portal is a @dfn{portal front-end service} for Flatpak and
possibly other desktop containment frameworks.  It works by exposing a series
of D-Bus interfaces known as portals under a well-known
name (@code{org.freedesktop.portal.Desktop}) and object
path (@code{/org/freedesktop/portal/desktop}).

The portal interfaces include APIs for file access, opening URIs, printing
and others.")
    (license license:lgpl2.1+)))
