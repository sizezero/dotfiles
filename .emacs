
;; M-x eval-buffer to reload

(setq debug-on-error t)

(defun buffer-menu-files-only ()
  (interactive)
  (buffer-menu 'FilesOnly)
  )

(setq make-backup-files nil)

;; magical syntax-coloring code
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; browse url

;(add-hook 'dired-mode-hook
;	  (lambda ()
;	    (local-set-key "f" 'browse-url-of-dired-file)))

(setq c-basic-offset 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)

;;; cperl-mode is preferred to perl-mode
;;; "Brevity is the soul of wit" <foo at acm.org>
(defalias 'perl-mode 'cperl-mode)

;; default cperl indentation seems to be 2
(setq cperl-indent-level 4
      cperl-close-paren-offset -4
      cperl-continued-statement-offset 4
      cperl-indent-parens-as-block t
      cperl-tab-always-indent t)

;; indentation
       	
;(setq default-tab-width 8)
;(show-paren-mode 1)

;(require 'cc-mode)
;(setq-default c-basic-offset 2)

;(add-hook 'java-mode-hook 
;	  (function (lambda ()
;		      (c-set-style "k&r")
;		      (setq c-basic-offset 2)
;		      )))


;(add-hook 'perl-mode-hook 
;	  (function (lambda ()
;		      ;;(c-set-style "k&r")
;		      (setq perl-indent-level 2
;			    perl-continued-statement-offset 2)
;		      )))

;; compiler spawning stuff

(setq compile-command "make ")

;; my buffer menus

(defun buffer-menu-number (num)
  (interactive)
  (goto-line (+ 2 num))
  (goto-line num)
  (Buffer-menu-this-window)
  )

(defun buffer-menu-number-one   () (interactive) (buffer-menu-number 1))
(defun buffer-menu-number-two   () (interactive) (buffer-menu-number 2))
(defun buffer-menu-number-three () (interactive) (buffer-menu-number 3))
(defun buffer-menu-number-four  () (interactive) (buffer-menu-number 4))
(defun buffer-menu-number-five  () (interactive) (buffer-menu-number 5))
(defun buffer-menu-number-six   () (interactive) (buffer-menu-number 6))
(defun buffer-menu-number-seven () (interactive) (buffer-menu-number 7))
(defun buffer-menu-number-eight () (interactive) (buffer-menu-number 8))
(defun buffer-menu-number-nine  () (interactive) (buffer-menu-number 9))
(defun buffer-menu-number-ten   () (interactive) (buffer-menu-number 10))

(defun my-buffer-menu-hook ()
  (define-key Buffer-menu-mode-map "1" 'buffer-menu-number-one)
  (define-key Buffer-menu-mode-map "2" 'buffer-menu-number-two)
  (define-key Buffer-menu-mode-map "3" 'buffer-menu-number-three)
  (define-key Buffer-menu-mode-map "4" 'buffer-menu-number-four)
  (define-key Buffer-menu-mode-map "5" 'buffer-menu-number-five)
  (define-key Buffer-menu-mode-map "6" 'buffer-menu-number-six)
  (define-key Buffer-menu-mode-map "7" 'buffer-menu-number-seven)
  (define-key Buffer-menu-mode-map "8" 'buffer-menu-number-eight)
  (define-key Buffer-menu-mode-map "9" 'buffer-menu-number-nine)
  (define-key Buffer-menu-mode-map "0" 'buffer-menu-number-ten)
  )

(add-hook 'buffer-menu-mode-hook 'my-buffer-menu-hook)

;; Save the current buffer if necessary, and run "compile".

;(defun save-and-compile ()
;  (switch-to-buffer "makefile")
;  (compile))

;(fset 'compile-makefile
;      [?\C-x ?b ?m ?a ?k ?e ?f ?i ?l ?e return ?\M-x ?c ?o ?m ?p ?i ?l ?e])

;(fset 'indent-buffer
;   [?\M-< ?\C-  ?\M-> ?\C-\M-\\])

;(defun another-save-and-compile () "switch to makefile and compile"
;  (interactive)
;  (switch-to-buffer "makefile")
;  (setq compile-command 
;	(read-from-minibuffer "Compile command: "
;			      compile-command nil nil
;			      '(compile-history . 1)))
;  (save-some-buffers 'DontPrompt)
;  (compile compile-command))

;(setq compile-command2 ())
;(defun simple-compile () "compile the current file"
;  (interactive)
;  (setq compile-command2
;	(read-from-minibuffer "Compile command: "
;			      compile-command2 nil nil
;			      '(compile-history2 . 1)))
;  (save-some-buffers 'DontPrompt)
;  (compile compile-command2)
;)

;; auto-scroll the compilation buffer

(setq compilation-scroll-output 1)

;; opposite of bury-buffer

(defun previous-buffer () "Go to the last buffer in the buffer list"  
  (interactive)
  (switch-to-buffer (car (reverse (buffer-list)))))

(defun switch-to-shell-buffer () "switch to shell"
  (interactive)
  (switch-to-buffer "*shell*")
  )

;; macros

;; some handy keys

;;(global-set-key "\C-c\C-d" 'gdb)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [f1] 'buffer-menu)
(global-set-key [f2] 'buffer-menu-files-only)
(global-set-key [f4] 'goto-line)
(global-set-key [f5] 'next-error)
(global-set-key [S-f5] 'previous-error)
(global-set-key [f6] 'buffer-menu)
(global-set-key [f7] 'buffer-menu-files-only)
;(global-set-key [f7] 'another-save-and-compile)
;(global-set-key [S-f7] 'simple-compile)
;(global-set-key [f8] 'switch-to-shell-buffer)

;; We never use C-z to suspend emacs so use it for the more intuitive
;; "undo command"
(global-set-key "\C-z" 'undo)

;(when (not running-xemacs)
  (global-set-key [C-home] 'beginning-of-buffer)
  (global-set-key [C-end] 'end-of-buffer)
  (global-set-key [M-up] 'View-scroll-line-backward)
  (global-set-key [M-down] 'View-scroll-line-forward)
  (global-set-key [M-C-q] 'fill-region-as-paragraph)
;  )

; Make menu bar cut/copy/paste work for the X desktop.  Why the hell
; would this not be the default?
(menu-bar-enable-clipboard)
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; allow use with emacsclient
;(autoload 'server-edit "server" nil t)
;(server-start)

;(desktop-load-default)
;(desktop-read)
;(shell)

(setq grep-find-command "find . -type f -not -path '*/.svn/*' -not -path '*/tags/*' -not -path '*/.metadata/*' -print0 | xargs -0 -e grep -n -i -e")

; load "emacs speaks statistics" package
(load "/usr/share/emacs/site-lisp/emacs-ess/ess-site.el")

; load groovy mode
(load "/home/kleemann/.emacs.d/groovy-mode.el")
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;(custom-set-variables
; '(load-home-init-file t t))
;(custom-set-faces)

;(put 'upcase-region 'disabled nil)
;(setq isearch-toggle-case-fold t)

;(setq load-path `("~/emacsstuff/" . ,load-path))
;(load-library "python-mode")
;(setq auto-mode-alist
;       (cons '("\\.py$" . python-mode) auto-mode-alist))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(inhibit-startup-screen t)
 '(org-latex-to-pdf-process (quote ("/usr/local/apps/texlive/2009/bin/x86_64-linux/pdflatex -interaction nonstopmode %s" "/usr/local/apps/texlive/2009/bin/x86_64-linux/pdflatex -interaction nonstopmode %s"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
