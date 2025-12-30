(define-module (basrandir packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages man)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages zig)
  #:use-module (guix build-system cargo)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages))

;; (define-public rust-smithay-0.5
;;   (package
;;     (name "rust-smithay")
;;     (version "0.5.1")
;;     (source
;;      (origin
;;        (method url-fetch)
;;        (uri (crate-uri "smithay" version))
;;        (file-name (string-append name "-" version ".tar.gz"))
;;        (sha256
;;         (base32 "12adp98v51qwz0qpi188zfr31app04z22sr81i3r5wqvi0mshyj9"))))
;;     (build-system cargo-build-system)
;;     (arguments
;;      `(#:cargo-inputs (("rust-appendlist" ,rust-appendlist-1)
;;                        ("rust-ash" ,rust-ash-0.38)
;;                        ("rust-bitflags" ,rust-bitflags-2)
;;                        ("rust-calloop" ,rust-calloop-0.14)
;;                        ("rust-cc" ,rust-cc-1)
;;                        ("rust-cgmath" ,rust-cgmath-0.18)
;;                        ("rust-cursor-icon" ,rust-cursor-icon-1)
;;                        ("rust-downcast-rs" ,rust-downcast-rs-1)
;;                        ("rust-drm" ,rust-drm-0.14)
;;                        ("rust-drm-ffi" ,rust-drm-ffi-0.9)
;;                        ("rust-drm-fourcc" ,rust-drm-fourcc-2)
;;                        ("rust-encoding-rs" ,rust-encoding-rs-0.8)
;;                        ("rust-errno" ,rust-errno-0.3)
;;                        ("rust-gbm" ,rust-gbm-0.18)
;;                        ("rust-gl-generator" ,rust-gl-generator-0.14)
;;                        ("rust-glow" ,rust-glow-0.16)
;;                        ("rust-indexmap" ,rust-indexmap-2)
;;                        ("rust-input" ,rust-input-0.9)
;;                        ("rust-libc" ,rust-libc-0.2)
;;                        ("rust-libloading" ,rust-libloading-0.8)
;;                        ("rust-libseat" ,rust-libseat-0.2)
;;                        ("rust-pixman" ,rust-pixman-0.2)
;;                        ("rust-pkg-config" ,rust-pkg-config-0.3)
;;                        ("rust-profiling" ,rust-profiling-1)
;;                        ("rust-rand" ,rust-rand-0.8)
;;                        ("rust-rustix" ,rust-rustix-0.38)
;;                        ("rust-scopeguard" ,rust-scopeguard-1)
;;                        ("rust-smallvec" ,rust-smallvec-1)
;;                        ("rust-tempfile" ,rust-tempfile-3)
;;                        ("rust-thiserror" ,rust-thiserror-1)
;;                        ("rust-tracing" ,rust-tracing-0.1)
;;                        ("rust-udev" ,rust-udev-0.9)
;;                        ("rust-wayland-backend" ,rust-wayland-backend-0.3)
;;                        ("rust-wayland-client" ,rust-wayland-client-0.31)
;;                        ("rust-wayland-cursor" ,rust-wayland-cursor-0.31)
;;                        ("rust-wayland-egl" ,rust-wayland-egl-0.32)
;;                        ("rust-wayland-protocols" ,rust-wayland-protocols-0.32)
;;                        ("rust-wayland-protocols-misc" ,rust-wayland-protocols-misc-0.3)
;;                        ("rust-wayland-protocols-wlr" ,rust-wayland-protocols-wlr-0.3)
;;                        ("rust-wayland-server" ,rust-wayland-server-0.31)
;;                        ("rust-wayland-sys" ,rust-wayland-sys-0.31)
;;                        ("rust-winit" ,rust-winit-0.30)
;;                        ("rust-x11rb" ,rust-x11rb-0.13)
;;                        ("rust-xkbcommon" ,rust-xkbcommon-0.8))
;;        #:cargo-development-inputs (("rust-clap" ,rust-clap-4)
;;                                    ("rust-criterion" ,rust-criterion-0.5)
;;                                    ("rust-image" ,rust-image-0.25)
;;                                    ("rust-tracing-subscriber" ,rust-tracing-subscriber-0.3))))
;;     (home-page "https://smithay.github.io/")
;;     (synopsis "Smithay is a library for writing wayland compositors")
;;     (description
;;      "This package provides Smithay is a library for writing wayland compositors.")
;;     (license license:expat)))

(define-public niri
  (package
    (name "niri")
    (version "25.02")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/YaLTeR/niri.git")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0vzskaalcz6pcml687n54adjddzgf5r07gggc4fhfsa08h1wfd4r")))) ; Replace with actual hash
    (build-system cargo-build-system)
    (native-inputs
     `(("pkg-config" ,pkg-config)
       ("rust" ,rust "cargo")))
    (inputs
     `(("libinput" ,libinput)
       ("libxkbcommon" ,libxkbcommon)
       ("wayland" ,wayland)
       ("udev" ,eudev)
       ("libseat" ,libseat)
       ("pango" ,pango)
       ("pipewire" ,pipewire)
       ("dbus" ,dbus)))
    (synopsis "Scrollable-tiling Wayland compositor")
    (description
     "Niri is a scrollable-tiling Wayland compositor with dynamic workspace management
      and advanced input handling. Features include:
      - Infinite horizontal strip window layout
      - Per-monitor workspaces
      - Smithay-based compositor foundation
      - Systemd integration
      - D-Bus support
      - Screencasting via xdg-desktop-portal-gnome")
    (home-page "https://github.com/YaLTeR/niri")
    (license license:gpl3+)))

niri
  
