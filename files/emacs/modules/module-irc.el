(use-package erc
  :config
  (defun bibliotik ()
    (interactive)
    (erc-tls :server "irc.p2p-network.net"
	     :port "6697"
	     :nick "soldat"
	     :user "soldat"))
  )
