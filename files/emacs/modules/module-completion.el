;;; module-completion.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package consult
  :bind (
	 ("C-s" . consult-line)
	 ("M-s d" . consult-find)
	 ("M-s r" . consult-ripgrep))
  :config
  (consult-customize
   consult-find :preview-key 'any))

(use-package corfu
  :init (global-corfu-mode)
  :custom
  (corfu-auto t)
  :config
  (defun corfu-enable-in-minibuffer ()
    "Enable Corfu in the minibuffer if `completion-at-point` is bound."
    (when (where-is-internal #'completion-at-point (list (current-local-map)))
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer))

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
