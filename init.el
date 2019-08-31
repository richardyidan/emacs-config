;; What needs to be changed when migrating to a different machine
;; helm also needs to be configures accordingly

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; Install 'use-package' if necessary
(unless(package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; exec-path-from-shell
(use-package exec-path-from-shell
  :init
  (when(memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; sr-speedbar
(use-package sr-speedbar)
(setq sr-speedbar-auto-refresh nil) ;; for auto-refresh
(setq speedbar-show-unknown-files t) ;; show all files
(setq sr-speedbar-right-side nil) ;; put on left side

;; save on compilation without asking me
(setq compilation-ask-about-save nil)

;; python elpy
(use-package elpy
  :config
  (elpy-enable))
;; general settings for python
(setq python-indent-guess-indent-offset nil)
(setq python-indent-offset 4)


(progn
  ;; make indentation commands use space only (never tab character)
  (setq-default indent-tabs-mode nil)
  ;; emacs 23.1, 24.2, default to t
  ;; if indent-tabs-mode is t, it means it may use tab, resulting mixed space and tab
  )

;; auto insert closing bracket
(electric-pair-mode 1)

;; make typing delete/overwrites selected text
(delete-selection-mode 1)

;; turn on bracket match highlight
(show-paren-mode 1)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; line numbers
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;; make cursor not blinke
(blink-cursor-mode 0)

;; quickly open init file
(defun open-init()
  "Open init.el."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; set font and font size
(set-frame-font "Menlo 16")

;; auto-aved files
(setq backup-directory-alist `(("." . "~/.saves")))

;; theme
(use-package dracula-theme)

;; helm
(use-package helm)
(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
;; (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(setq helm-split-window-in-side-p t) ; set helm to open in the same window
(helm-mode 1)

;; Insert new line below current line
;; and move cursor to new line
;; it will also indent newline
(global-set-key (kbd "<C-return>") (lambda ()
                                     (interactive)
                                     (end-of-line)
                                     (newline-and-indent)))
;; Insert new line above current line
;; and move cursor to previous line (newly inserted line)
;; it will also indent newline
(global-set-key (kbd "<M-return>") (lambda ()
                                     (interactive)
                                     (beginning-of-line)
                                     (newline-and-indent)
                                     (previous-line)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet-snippets use-package sr-speedbar solarized-theme js2-mode impatient-mode helm gruvbox-theme exec-path-from-shell elpy dracula-theme company-irony-c-headers company-irony company-c-headers clang-format auto-complete-c-headers))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
