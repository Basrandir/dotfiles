;;; module-ai.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package ellama
  :elpaca (ellama :host github :repo "s-kostyaev/ellama")
  :init
  (setopt ellama-language "English")
  (require 'llm-ollama)
  (setopt ellama-provider
	  (make-llm-ollama
	   :host "ollama.containers.saeed.house"
	   :port 80
	   :chat-model "codellama"
	   :embedding-model "codellama")))

(provide 'module-ai)

;;; module-ai.el ends here
