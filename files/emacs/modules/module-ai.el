;;; module-ai.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
;; (use-package ellama
;;   :ensure (ellama :host github :repo "s-kostyaev/ellama")
;;   :init
;;   (setopt ellama-language "English")
;;   (require 'llm-ollama)
;;   (setopt ellama-provider
;; 	  (make-llm-ollama
;; 	   :host "ollama.containers.saeed.house"
;; 	   :port 80
;; 	   :chat-model "codellama"
;; 	   :embedding-model "codellama"))

;;   (setopt ellama-providers
;; 	  '(("llama2" . (make-llm-ollama
;; 			 :host "ollama.containers.saeed.house"
;; 			 :port 80
;; 			 :chat-model "llama2"
;; 			 :embedding-model "llama2"))
;; 	    ("codellama" . (make-llm-ollama
;; 			    :host "ollama.containers.saeed.house"
;; 			    :port 80
;; 			    :chat-model "codellama"
;; 			    :embedding-model "codellama"))
;; 	    ("deepseek-coder" . (make-llm-ollama
;; 				 :host "ollama.containers.saeed.house"
;; 				 :port 80
;; 				 :chat-model "deepseek-coder"
;; 				 :embedding-model "deepseek-coder"))
;; 	    ("openchat" . (make-llm-ollama
;; 			   :host "ollama.containers.saeed.house"
;; 			   :port 80
;; 			   :chat-model "openchat"
;; 			   :embedding-model "openchat"))
;; 	    ("openhermes" . (make-llm-ollama
;; 			     :host "ollama.containers.saeed.house"
;; 			     :port 80
;; 			     :chat-model "openhermes"
;; 			     :embedding-model "openhermes")))))

(use-package gptel
  :custom
  (gptel-default-mode #'org-mode)
  (gptel-model 'deepseek-r1:latest)
  :config
  (setq gptel-backend
	(gptel-make-ollama
	    "Ollama"
	  :host "ollama.containers.saeed.house"
	  :stream t
	  :models '(deepseek-r1:32b deepseek-r1:latest HammerAI/midnight-miqu-70b-v1.5))))

;; (use-package aidermacs
;;   :ensure (:host github :repo "MatthewZMD/aidermacs" :files ("*.el"))
;;   :config
;;   (setq aidermacs-default-model "o1-mini")
;;   ;; (setenv "ANTHROPIC_API_KEY" anthropic-api-key)
;;   (global-set-key (kbd "C-c a") 'aidermacs-transient-menu))
;; 					; See the Configuration section below
;; (setq aidermacs-auto-commits t)
;; (setq aidermacs-use-architect-mode t))

(provide 'module-ai)

;;; module-ai.el ends here
