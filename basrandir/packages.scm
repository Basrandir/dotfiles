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
