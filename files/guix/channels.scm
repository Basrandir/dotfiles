(cons* (channel
	(name 'rustup)
	(url "https://github.com/declantsien/guix-rustup")
	(introduction
	 (make-channel-introduction
	  "325d3e2859d482c16da21eb07f2c6ff9c6c72a80"
	  (openpgp-fingerprint
	   "F695 F39E C625 E081 33B5  759F 0FC6 8703 75EF E2F5"))))
       (channel
	(name 'nonguix)
	(url "https://gitlab.com/nonguix/nonguix")
	;; Enable signature verification:
	(introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       %default-channels)
