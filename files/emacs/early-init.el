;;; early-init.el --- For Emacs 27+

;;; Commentary:
;; Emacs 27+ loads this file before initializing certain graphical
;; elements and the package manager

;;; Code:

;; Increase the GC threshold for faster startup
(setq gc-cons-threshold (* 50 1000 1000))

;; Native compilation settings
(when (featurep 'native-compile)
  ;; Silences warnings by the compiler. They are super annoying when pop-ing up new windows.
  (setq native-comp-async-report-warnings-errors 'silent))

;; Clear out graphical elements
(horizontal-scroll-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Hide splash page
(setq inhibit-startup-message t)

;; Set default fonts
(set-face-attribute 'default nil :family "Rec Mono Duotone" :height 170)
(set-face-attribute 'fixed-pitch nil :family "Rec Mono Duotone")
(set-face-attribute 'variable-pitch nil :family "DejaVu Serif")

;; Disable package manger init since we use guix and Elpaca instead
(setq package-enable-at-startup nil)

(provide 'early-init)

;;; early-init.el ends here
