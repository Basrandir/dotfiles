;;; module-blog.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package ox-publish
  :straight nil
  :config
  (setq bassamsaeed.ca/base-directory "~/src/bassamsaeed.ca/")
  (setq bassamsaeed.ca/header-file (concat bassamsaeed.ca/base-directory "partials/header.html"))
  (setq bassamsaeed.ca/footer-file (concat bassamsaeed.ca/base-directory "partials/footer.html"))

  (defun bassamsaeed.ca/header (_plist)
    "Header"
    (with-temp-buffer
      (insert-file-contents bassamsaeed.ca/header-file)
      (buffer-string)))
  
  (defun  bassamsaeed.ca/footer (_plist)
    "Footer"
    (with-temp-buffer
      (insert-file-contents bassamsaeed.ca/footer-file)
      (buffer-string)))

  (defun bassamsaeed.ca/filter-index-links (link backend info)
    "Convert index.html links to just their root directory"
    (if (org-export-derived-backend-p backend 'html)
	(replace-regexp-in-string "/index.html" "/" link)))

  (defun bassamsaeed.ca/org-sitemap-format (title list)
    "Remove subtitle in posts index page"
    (let ((filtered-list (cl-remove-if (lambda (x)
					 (and (sequencep x) (null (car x))))
				       list)))
      (concat "#+TITLE: " title "\n"
	      "#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"/css/main.css\">\n"
	      "#+HTML_HEAD: <link rel=\"alternate\" type=\"application/rss+xml\" href=\"/posts.rss\">\n"
	      "#+HTML_HEAD: <link rel=\"alternate\" type=\"application/atom+xml\" href=\"/posts.atom\">\n"
	      "#+HTML_HEAD: <style>.subtitle{display: none;}</style>\n"
	      (org-list-to-org filtered-list))))
  
  (defun bassamsaeed.ca/org-sitemap-format-entry (entry style project)
    ""
    (format "%s /[[file:%s][%s]]/"
	    (format-time-string "%b %d, %Y" (org-publish-find-date entry project))
	    entry
	    (org-publish-find-title entry project)))

  (defun bassamsaeed.ca/org-html-publish-to-html (plist filename pub-dir)
    "Wrapper function around org-html-publish-to-html to include Date in Title"
    (let ((project (cons 'rw plist)))
      (plist-put plist :subtitle
		 (format-time-string "%b %d, %Y" (org-publish-find-date filename project)))
      (org-html-publish-to-html plist filename pub-dir)))

  (defun bassamsaeed.ca/publish ()
    (interactive)
    (setq webfeeder-default-author "Bassam Saeed <bassam.saeed@gmail.com>")
    (webfeeder-build
     "posts.atom"
     (concat bassamsaeed.ca/base-directory "public")
     "https://www.bassamsaeed.ca"
     (delete "posts/index.html"
	     (mapcar (lambda (f) (replace-regexp-in-string ".*/public/" "" f))
		     (directory-files-recursively
		      (concat bassamsaeed.ca/base-directory "public/posts") "index.html")))
     :title "Bassam Saeed's Blog"
     :description "Personal Development Blog")
    (webfeeder-build
     "posts.xml"
     (concat bassamsaeed.ca/base-directory "public")
     "https://www.bassamsaeed.ca"
     (delete "posts/index.html"
	     (mapcar (lambda (f) (replace-regexp-in-string ".*/public/" "" f))
		     (directory-files-recursively
		      (concat bassamsaeed.ca/base-directory "public/posts") "index.html")))
     :title "Bassam Saeed's Blog"
     :description "Personal Development Blog"
     :builder 'webfeeder-make-rss))
  
  (setq org-publish-project-alist
	`(("posts"
	   :base-directory ,(concat bassamsaeed.ca/base-directory "posts/")
	   :publishing-directory ,(concat bassamsaeed.ca/base-directory "public/posts")
	   :base-extension "org"
	   :publishing-function bassamsaeed.ca/org-html-publish-to-html
	   :recursive t
	   :html-head
	   ,(concat
	     "<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/main.css\">\n"
	     "<link rel=\"alternate\" type=\"application/rss+xml\" href=\"/posts.rss\">\n"
	     "<link rel=\"alternate\" type=\"application/atom+xml\" href=\"/posts.atom\">\n")
	   :html-head-include-default-style nil
	   :html-head-include-scripts nil
	   :html-preamble bassamsaeed.ca/header
	   :html-postamble bassamsaeed.ca/footer
	   :section-numbers nil
	   :with-toc nil
	   :auto-sitemap t
	   :sitemap-filename "index.org"
	   :sitemap-title "Posts"
	   :sitemap-style list
	   :sitemap-format-entry bassamsaeed.ca/org-sitemap-format-entry
	   :sitemap-function bassamsaeed.ca/org-sitemap-format
	   :sitemap-sort-files anti-chronologically)
	  
	  ("assets"
	   :base-directory ,(concat bassamsaeed.ca/base-directory "assets/")
	   :publishing-directory ,(concat bassamsaeed.ca/base-directory "public/")
	   :recursive t
	   :base-extension "css\\|svg\\|woff2"
	   :publishing-function org-publish-attachment)

	  ("static"
	   :base-directory ,(concat bassamsaeed.ca/base-directory "static/")
	   :publishing-directory ,(concat bassamsaeed.ca/base-directory "public/")
	   :base-extension "org"
	   :publishing-function org-html-publish-to-html
	   :recursive t
	   :html-head
	   ,(concat
	     "<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/main.css\">\n"
	     "<link rel=\"alternate\" type=\"application/rss+xml\" href=\"/posts.rss\">\n"
	     "<link rel=\"alternate\" type=\"application/atom+xml\" href=\"/posts.atom\">\n")
	   :html-head-include-default-style nil
	   :html-head-include-scripts nil
	   :html-preamble bassamsaeed.ca/header
	   :html-postamble bassamsaeed.ca/footer
	   :section-numbers nil
	   :with-toc nil)
	  
	  ("website" :components ("posts" "assets" "static"))))
  
  (add-to-list 'org-export-filter-link-functions
	       'bassamsaeed.ca/filter-index-links))

(provide 'module-blog)

;;; module-blog.el ends here
