;;; early-init.el --- For Emacs 27+

;;; Commentary:
;; Emacs 27+ loads this file before initializing certain graphical
;; elements and the package manager

;;; Code:

;; Clear out graphical elements
(horizontal-scroll-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Set default fonts
(set-face-attribute 'default nil :family "Iosevka" :height 130)
(set-face-attribute 'fixed-pitch nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "B612" :width 'condensed)

;; Disable package manager init since we use straight.el instead
(setq package-enable-at-startup nil)

(provide 'early-init)

;;; early-init.el ends here
