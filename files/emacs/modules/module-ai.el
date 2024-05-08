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
	   :embedding-model "codellama"))

  (setopt ellama-providers
	  '(("llama2" . (make-llm-ollama
			 :host "ollama.containers.saeed.house"
			 :port 80
			 :chat-model "llama2"
			 :embedding-model "llama2"))
	    ("codellama" . (make-llm-ollama
			    :host "ollama.containers.saeed.house"
			    :port 80
			    :chat-model "codellama"
			    :embedding-model "codellama"))
	    ("deepseek-coder" . (make-llm-ollama
				 :host "ollama.containers.saeed.house"
				 :port 80
				 :chat-model "deepseek-coder"
				 :embedding-model "deepseek-coder"))
	    ("openchat" . (make-llm-ollama
			   :host "ollama.containers.saeed.house"
			   :port 80
			   :chat-model "openchat"
			   :embedding-model "openchat"))
	    ("openhermes" . (make-llm-ollama
			     :host "ollama.containers.saeed.house"
			     :port 80
			     :chat-model "openhermes"
			     :embedding-model "openhermes")))))

(provide 'module-ai)

;;; module-ai.el ends here
