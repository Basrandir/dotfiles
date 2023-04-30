;;; module-completion.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun consult-emoji ()
  "Insert an emoji at point."
  (interactive)
  (let* ((emojis (with-temp-buffer))
	 (selected-emoji (consult--read
                          emojis
                          :prompt "Emoji: "
                          :category 'emoji
                          :sort nil
                          :history t)))
    (insert selected-emoji)))

(use-package consult
  :bind (
	 ("C-s" . consult-line)        ;; orig. isearch-forward
	 ("C-x b" . consult-buffer)    ;; org. switch-to-buffer
	 ("M-s d" . consult-find)
	 ("M-s f" . (lambda () (interactive) (consult-find "~")))
	 ("M-s r" . consult-ripgrep))
  :config
  ;; Exclude mnt directory from consult-find
  (setq consult-find-args "find . -not ( -wholename */.* -prune -o -name mnt -prune )")
  (consult-customize
   consult-find :preview-key 'any))

(use-package corfu
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :bind (:map corfu-map
	      ("M-p" . #'corfu-popupinfo-scroll-down)
	      ("M-n" . #'corfu-popupinfo-scroll-up)
	      ("M-d" . #'corfu-popupinfo-toggle))
  :custom
  (corfu-auto t)
  :config
  (defun corfu-enable-in-minibuffer ()
    "Enable Corfu in the minibuffer if `completion-at-point` is bound."
    (when (where-is-internal #'completion-at-point (list (current-local-map)))
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer))

;; (use-package kind-icon
;;   :after corfu
;;   :custom
;;   (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
;;   :config
;;   (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package embark
  :bind
  (("C-." . embark-act)
   ("M-." . embark-dwim)
   ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package marginalia
  :init (marginalia-mode))

(use-package orderless
  :custom ((completion-styles '(orderless))
	   (read-buffer-completion-ignore-case t)))

(use-package vertico
  :init
  (vertico-mode)
  (vertico-multiform-mode)
  :config
  (setq vertico-multiform-commands
	'((consult-line indexed buffer)))
  (setq vertico-multiform-categories
	'((imenu buffer)
	  (t reverse))))

(provide 'module-completion)

;;; module-completion.el ends here
