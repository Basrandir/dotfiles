;;; module-feed.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package elfeed
  :bind (("C-x w" . elfeed)
	 :map elfeed-search-mode-map
	 ("F" . elfeed-update)))

(use-package elfeed-org
  :after elfeed
  :custom
  (rmh-elfeed-org-files (list "~/.config/emacs/elfeed.org"))
  :config
  (elfeed-org))

;; For use with external feed readers like TinyRSS
(use-package elfeed-protocol
  :after elfeed)

(use-package elfeed-tube
  :ensure t
  :config
  (elfeed-tube-setup))

(use-package elfeed-tube-mpv
  :ensure t
  :bind (:map elfeed-show-mode-map
              ("C-c C-f" . elfeed-tube-mpv-follow-mode)
              ("C-c C-w" . elfeed-tube-mpv-where)))

(use-package mpv
  :init
  ;; Define the keymap that should be active only when mpv is connected.
  (defvar my-mpv-global-map
    (let ((map (make-sparse-keymap)))
      ;; Playback
      (define-key map (kbd "C-c m p") #'mpv-pause)
      (define-key map (kbd "C-c m k") #'mpv-kill)
      ;; Seeking
      (define-key map (kbd "C-c m f") #'mpv-seek-forward)
      (define-key map (kbd "C-c m b") #'mpv-seek-backward)
      ;; Speed / volume
      (define-key map (kbd "C-c m +") #'mpv-speed-increase)
      (define-key map (kbd "C-c m -") #'mpv-speed-decrease)
      (define-key map (kbd "C-c m ]") #'mpv-volume-increase)
      (define-key map (kbd "C-c m [") #'mpv-volume-decrease)
      ;; Playlist nav
      (define-key map (kbd "C-c m n") #'mpv-playlist-next)
      (define-key map (kbd "C-c m p") #'mpv-playlist-prev)
      map)
    "Keymap active globally only while mpv is connected.")

  (define-minor-mode my-mpv-global-mode
    "Global bindings for controlling mpv while it's connected."
    :global t
    :lighter " mpv▶"
    :keymap my-mpv-global-map)

  :config
  ;; Enable keymap when mpv starts/attaches; disable when it exits.
  (add-hook 'mpv-on-start-hook #'my-mpv-global-mode)
  (add-hook 'mpv-on-exit-hook  (lambda () (my-mpv-global-mode -1)))
  
  :bind (("C-c m p" . mpv-play)
	 ("C-c m y" . mpv-play-url)))


(provide 'module-feed)

;;; module-feed.el ends here
