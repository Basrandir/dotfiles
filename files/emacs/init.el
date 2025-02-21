;;; init.el --- For Emacs 28. -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
;; Profile emacs startup
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (message "Emacs loaded in %s."
		     (format "%.2f seconds"
			     (float-time
			      (time-subtract after-init-time before-init-time))))))

;; Initialize Elpaca
(setq elpaca-core-date '(20241026))

(defvar elpaca-installer-version 0.9)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Integrate elpaca with use-package
(elpaca elpaca-use-package
  (elpaca-use-package-mode))
(elpaca-wait)

;; Add custom modules folder to load path
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

;; Require Modules
(require 'module-ai)
(require 'module-completion)
(require 'module-defaults)
(require 'module-dired)
(require 'module-feed)
(require 'module-ide)
(require 'module-meow)
(require 'module-org)
(require 'module-pkm)
(require 'module-shell)
(require 'module-templates)
(require 'module-ui)

(use-package jinx
  :bind (("M-$" . jinx-correct)
	 ("C-M-$" . jinx-languages)))

;; Make GC pauses faster.
(setq gc-cons-threshold (* 2 1000 1000))

(provide 'init)

;;; init.el ends here
