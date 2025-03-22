;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ███████ ███    ███  █████   ██████ ███████ ██ ;; 
;; ██      ████  ████ ██   ██ ██      ██      ██ ;;
;; █████   ██ ████ ██ ███████ ██      ███████ ██ ;;
;; ██      ██  ██  ██ ██   ██ ██           ██    ;;
;; ███████ ██      ██ ██   ██  ██████ ███████ ██ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Never thought I would use Emacs of all things ;;
;; yet here I am, honestly I like it.            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Fix issue with Emacs not being able to access *ELPA packages.
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Install Straight package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; UI Config
(scroll-bar-mode -1)
(tool-bar-mode -1)
;(tooltip-mode -1)
(set-fringe-mode 10)
;(menu-bar-mode -1)
(setq visible-bell t)
(straight-use-package 'catppuccin-theme)
(load-theme 'catppuccin :no-confirm)

;; Install command-log-mode

(use-package command-log-mode)

;; Use Ivy completion system
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))
(ivy-mode 1)

;; Install Counsel
(use-package counsel
  :after ivy
  :config
  (counsel-mode 1))


;; Make ESC key actually let me escape
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Add Doom Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Customize Doom Modeline
(setq doom-modeline-hud nil)

;; Enable line numbers
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Enable rainbow delimiters (makes nesting more bearable AAAAAAAAAAA TYPESCRIPT)
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Install WhichKey
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))

;; Install all the icons
(use-package all-the-icons)

;; Enable Evil!!
(use-package evil)
(evil-mode 1)

;; RSS/Elfeed section
(use-package elfeed)
(global-set-key (kbd "C-x w") 'elfeed)
(setq elfeed-feeds
      '("https://feed.alternativeto.net/news/all"))

;; Enable Projectile + Counsel Projectile
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects")
    (setq projectile-project-search-path '("~/Projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; Install Magit
(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Install Orgmode
(use-package org)

;; Install lsp-mode for LSP
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

;; Install Elpy for Python
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; Use Dirvish for better Dired and get  ICONS!! 
(use-package dirvish)
(setq dirvish-attributes
      (append
       ;; The order of these attributes is insignificant, they are always
       ;; displayed in the same position.
       '(vc-state subtree-state nerd-icons collapse)
       ;; Other attributes are displayed in the order they appear in this list.
       '(git-msg file-modes file-time file-size)))

;; Enable JTSX
(use-package jtsx)

;; Install Dired Sidebar and autoenable it
(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))
(use-package nix-drv-mode
  :ensure nix-mode
  :mode "\\.drv\\'")
(use-package nix-shell
  :ensure nix-mode
  :commands (nix-shell-unpack nix-shell-configure nix-shell-build))
(use-package nix-repl
  :ensure nix-mode
  :commands (nix-repl))

;; Install JSON support
(use-package json-mode)

;; Enable indentation-based code-folding with YAFOLDING!
(use-package yafolding)
(defvar yafolding-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<C-S-return>") #'yafolding-hide-parent-element)
    (define-key map (kbd "<C-M-return>") #'yafolding-toggle-all)
    (define-key map (kbd "<C-return>") #'yafolding-toggle-element)
    map))

;; Install Rust-Mode for Rust support :D
(use-package rust-mode)
(add-hook 'rust-mode-hook	                   ;; Force TAB to be spaces.
	  (lambda () (setq indent-tabs-mode nil)))
(add-hook 'rust-mode-hook
          (lambda () (prettify-symbols-mode)))     ;; Auto-prettifies Rust code
(setq rust-format-on-save t)                       ;; on save + formats it
