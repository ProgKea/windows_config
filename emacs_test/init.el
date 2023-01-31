;; Startup
;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Lower threshold to speed up garbage collection
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1000 1000))))

;;; Backups
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
      vc-make-backup-files t
      version-control t
      kept-old-versions 0
      kept-new-versions 10
      delete-old-versions t
      backup-by-copying t)

(require 'package)
(setq package-archives '(
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

(setq use-package-verbose t)
(setq package-native-compile t)
(setq comp-async-report-warnings-errors nil)
(setq comp-deferred-compilation t)
(setq use-package-always-ensure t)

;; Install and load `quelpa-use-package'.
(setq quelpa-update-melpa-p nil)
(package-install 'quelpa-use-package)
(require 'quelpa-use-package)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; ASYNC
;; Emacs look SIGNIFICANTLY less often which is a good thing.
;; asynchronous bytecode compilation and various other actions makes
(use-package async
  :defer t
  :init
  (dired-async-mode 1)
  (async-bytecomp-package-mode 1)
  :custom (async-bytecomp-allowed-packages '(all)))

(defalias 'yes-or-no-p 'y-or-n-p)

;;; setting variables
(setq whitespace-style (quote
                        (face tabs spaces trailing space-before-tab indentation empty space-after-tab space-mark tab-mark)))
(setq split-height-threshold 0)
(setq split-width-threshold nil)
(setq vc-follow-symlinks t)
(setq byte-compile-warnings nil)
(setq inhibit-startup-screen t)
(setq compilation-ask-about-save nil)
(setq scroll-margin 8)
(setq auto-save-default nil)
(setq warning-minimum-level :error)
(setq-default indent-tabs-mode nil)
(setq-default fast-but-imprecise-scrolling t)
(setq-default compilation-scroll-output t)
(setq-default dired-dwim-target t)
(setq ring-bell-function 'ignore)
(setq tags-revert-without-query t)
(setq revert-without-query t)
(setq buffer-save-without-query t)
(setq enable-recursive-minibuffers t)
(add-to-list 'write-file-functions #'delete-trailing-whitespace)

(define-minor-mode minor-mode-blackout-mode
  "Hides minor modes from the mode line."
  t)

(catch 'done
  (mapc (lambda (x)
          (when (and (consp x)
                     (equal (cadr x) '("" minor-mode-alist)))
            (let ((original (copy-sequence x)))
              (setcar x 'minor-mode-blackout-mode)
              (setcdr x (list "" original)))
            (throw 'done t)))
        mode-line-modes))

;;; activate some modes
(blink-cursor-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(electric-pair-mode 1)
(global-display-line-numbers-mode 1)
(global-auto-revert-mode 1)
(menu-bar--display-line-numbers-mode-relative)

;; use-package
(use-package evil
  :init
  (setq cursor-type 'box)
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'box)
  (setq evil-visual-state-cursor 'box)
  (setq evil-motion-state-cursor 'box)
  (setq evil-replace-state-cursor 'box)
  (setq evil-operator-state-cursor 'box)
  (setq evil-want-keybinding nil)
  (setq evil-want-minibuffer t)
  :config
  (global-set-key (kbd "C-u") #'evil-scroll-page-up)
  (evil-mode 1)
  (add-to-list 'evil-normal-state-modes #'shell-mode)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC"))

  ;; To make always escape escape
  (define-key key-translation-map (kbd "ESC") (kbd "C-g"))

  ;; keybindings
  (evil-define-key 'normal 'global (kbd "C-l") #'async-shell-command)
  (evil-define-key 'normal 'global (kbd "C-w 0") #'balance-windows)
  (evil-define-key 'normal 'global (kbd "<leader>r") #'query-replace)
  (evil-define-key 'normal 'global (kbd "<leader>R") #'query-replace-regexp)
  (evil-define-key 'visual 'global (kbd "<leader>s") #'replace-string)
  (evil-define-key 'visual 'global (kbd "<leader>S") #'replace-regexp)
  (evil-define-key 'visual 'global (kbd "gc") #'comment-or-uncomment-region)
  (evil-define-key 'normal 'global (kbd "<leader>t") #'dired-jump)
  (evil-define-key 'normal 'global (kbd "<leader>u") #'undo-tree-visualize)
  (evil-define-key 'normal 'global (kbd "<leader>g") #'magit)
  (evil-define-key 'normal 'global (kbd "Y") #'duplicate-line)
  (evil-define-key 'normal 'global (kbd "<escape>") #'abort-minibuffers)
  (evil-define-key 'normal 'global (kbd "C-n") #'next-error)
  (evil-define-key 'normal 'global (kbd "C-p") #'previous-error)
  (evil-define-key 'normal minibuffer-mode-map (kbd "C-k") #'previous-history-element)
  (evil-define-key 'normal minibuffer-mode-map (kbd "C-j") #'next-history-element)
  (evil-define-key 'insert minibuffer-mode-map (kbd "C-k") #'previous-history-element)
  (evil-define-key 'insert minibuffer-mode-map (kbd "C-j") #'next-history-element)
  (evil-define-key 'normal minibuffer-mode-map (kbd "<RET>") #'exit-minibuffer))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :init
  :config
  (require 'org-agenda)
  (define-key org-agenda-mode-map (kbd "<escape>") #'keyboard-quit)
  (define-key org-agenda-mode-map (kbd "C-n") #'org-agenda-later)
  (define-key org-agenda-mode-map (kbd "C-p") #'org-agenda-earlier)
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package sudo-edit)

(use-package evil-multiedit
  :after evil
  :config
  (evil-multiedit-mode 1)
  (evil-define-key 'insert evil-multiedit-mode-map (kbd "<escape>") #'(lambda () (interactive)
                                                                        (evil-normal-state)
                                                                        (evil-multiedit-abort)))
  (evil-define-key 'normal evil-multiedit-mode-map (kbd "<escape>") #'evil-multiedit-abort)
  (evil-define-key 'normal 'global "z" #'evil-multiedit-match-symbol-and-next)
  (evil-define-key 'normal evil-multiedit-mode-map "z" #'evil-multiedit-match-symbol-and-next)
  (evil-define-key 'normal 'global "Z" #'evil-multiedit-match-symbol-and-prev)
  (evil-define-key 'visual 'global "z" #'evil-multiedit-match-and-next)
  (evil-define-key 'visual 'global "Z" #'evil-multiedit-match-and-prev))

(use-package yasnippet
  :after evil
  :config
  (setq yas-triggers-in-field nil)
  (setq yas-snippet-dirs '("~/.emacs.snippets/"))
  (yas-global-mode 1))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package projectile
  :init
  (when (file-directory-p "~/documents")
    (setq projectile-project-search-path '("~/documents")))
  (when (file-directory-p "~/code")
    (setq projectile-project-search-path '("~/code")))
  (projectile-mode 1)
  (evil-define-key 'normal 'global (kbd "C-f") #'projectile-find-file)
  (evil-define-key 'normal 'global (kbd "C-s") #'projectile-switch-project)
  (evil-define-key 'normal 'global (kbd "C-x pa") #'projectile-add-known-project))

(use-package consult
  :after evil
  :config
  (evil-define-key 'normal 'global (kbd "C-x b") #'consult-buffer)
  (evil-define-key 'normal 'global (kbd "C-ö r") #'consult-ripgrep)
  (evil-define-key 'normal 'global (kbd "C-ö g") #'consult-grep)
  (evil-define-key 'normal 'global (kbd "gj") #'consult-line)
  (evil-define-key 'normal 'global (kbd "ge") #'consult-compile-error)
  (evil-define-key 'normal 'global (kbd "gl") #'consult-flymake))

(use-package which-key
  :config
  (which-key-mode 1))

(use-package vertico
  :after evil
  :init (vertico-mode 1)
  :config
  (evil-define-key 'normal vertico-map (kbd "j") #'vertico-next)
  (evil-define-key 'normal vertico-map (kbd "k") #'vertico-previous)
  (evil-define-key 'normal vertico-map (kbd "G") #'vertico-last)
  (evil-define-key 'normal vertico-map (kbd "gg") #'vertico-first)
  (evil-define-key 'normal vertico-map (kbd "C-u") #'vertico-scroll-down)
  (evil-define-key 'normal vertico-map (kbd "C-d") #'vertico-scroll-up)
  (evil-define-key 'insert vertico-map (kbd "C-n") #'vertico-next)
  (evil-define-key 'insert vertico-map (kbd "C-p") #'vertico-previous)
  (evil-define-key 'normal vertico-map (kbd "<tab>") #'vertico-insert))

(use-package undo-tree
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1)
  :custom
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))

(use-package eglot
  :defer 1
  :hook
  (eglot--managed-mode . (lambda () (flymake-mode -1)))
  :init
  (setq eldoc-echo-area-display-truncation-message t)
  (setq eldoc-echo-area-use-multiline-p nil)
  (setq eglot-ignored-server-capabilities '(:documentHighlightProvider :hoverProvider :colorProvider))
  :config
  (evil-define-key 'normal 'global (kbd "<down>") #'flymake-goto-next-error)
  (evil-define-key 'normal 'global (kbd "<up>") #'flymake-goto-prev-error)
  (evil-define-key 'normal 'global (kbd "<leader>r") #'eglot-rename)
  (evil-define-key 'normal 'global (kbd "gm") #'eglot-find-implementation)
  (evil-define-key 'normal 'global (kbd "<leader>f") #'eglot-format-buffer)
  (evil-define-key 'normal 'global (kbd "gr") #'xref-find-references)
  (evil-define-key 'normal 'global (kbd "gd") #'xref-find-definitions)
  (evil-define-key 'normal 'global (kbd "ga") #'eglot-code-actions)
  (evil-define-key 'normal 'global (kbd "gh") #'eldoc-doc-buffer))

(use-package corfu
  :after yasnippet
  :custom
  ;; (corfu-auto t)
  ;; (corfu-auto-prefix 1)
  (tab-always-indent 'complete)
  (corfu-auto-delay 0.2)
  (corfu-preselect-first nil)
  :init
  (global-corfu-mode)
  :config
  (evil-define-key 'insert corfu-map (kbd "C-e") #'corfu-quit)
  (evil-define-key 'insert corfu-map (kbd "<RET>") #'evil-ret)
  (evil-define-key 'insert 'global (kbd "C-<SPC>") #'complete-symbol)
  (evil-define-key 'insert corfu-map (kbd "TAB") #'(lambda () (interactive)
                                                     (indent-for-tab-command)
                                                     (yas-expand)))
  (evil-define-key 'insert corfu-map [tab] #'(lambda () (interactive)
                                               (indent-for-tab-command)
                                               (yas-expand))))

(use-package cape
  :defer 10
  :hook
  (eshell-mode . (lambda ()
                   (setq-local corfu-quit-at-boundary t
                               corfu-quit-no-match t
                               corfu-auto nil)
                   (corfu-mode)))
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (setq cape-dabbrev-min-length '1)
  :config
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package compile
  :ensure nil
  :init
  (setq compile-command "")
  :config
  (evil-define-key 'normal 'global (kbd "C-k") #'compile)
  (evil-define-key 'normal compilation-mode-map "r" #'recompile))

(use-package ansi-color
    :hook (compilation-filter . ansi-color-compilation-filter))

(use-package dired
  :ensure nil
  :init
  (add-to-list 'dired-guess-shell-alist-user '("\\.pdf\\'" "zathura"))
  (add-to-list 'dired-guess-shell-alist-user '("\\.png\\'" "sxiv"))
  (add-to-list 'dired-guess-shell-alist-user '("\\.jpe?g\\'" "sxiv"))
  :config
  (add-hook #'dired-mode-hook #'auto-revert-mode)
  (evil-define-key 'normal dired-mode-map (kbd "<SPC>") #'evil-send-leader)
  (evil-define-key 'normal dired-mode-map "r" #'revert-buffer)
  (add-hook #'eww-mode-hook #'(lambda () (display-line-numbers-mode -1))))

;;; languages
(use-package rainbow-mode)
(use-package lua-mode
  :hook
  (lua-mode . whitespace-mode))
(use-package glsl-mode)
(use-package rust-mode)
(use-package markdown-mode
  :hook
  (markdown-mode . whitespace-mode)
  :config
  (add-to-list #'auto-mode-alist '("\\.md$" . markdown-mode)))
(use-package go-mode)
(use-package haskell-mode
  :hook
  (haskell-mode . whitespace-mode)
  (haskell-mode . haskell-doc-mode)
  (haskell-mode . interactive-haskell-mode))
(use-package yaml-mode
  :hook
  (yaml-mode . whitespace-mode))
(use-package typescript-mode)
(use-package php-mode)
(use-package zig-mode
  :init
  (setq zig-format-on-save nil))
(use-package cc-mode
  :ensure nil
  :hook (c-mode . (lambda () (c-toggle-comment-style -1)))
  :init
  (setq-default c-basic-offset 4
                c-default-style '((java-mode . "java")
                                  (awk-mode . "awk")
                                  (other . "bsd"))))
(use-package python-mode
  :ensure nil
  :hook
  (python-mode . whitespace-mode))

(use-package org
  :ensure nil
  :init
  (custom-set-faces
    '(org-level-1 ((t (:inherit outline-1 :height 1.25))))
    '(org-level-2 ((t (:inherit outline-2 :height 1.1))))
    '(org-level-3 ((t (:inherit outline-3 :height 1.05))))
    '(org-ellipsis ((t (:inherit default :height 0.75))))
    )
  (setq org-log-done t)
  (setq org-ellipsis "▼")
  (setq org-image-actual-width nil)
  (evil-define-key 'normal org-mode-map (kbd "C-c p") #'org-tree-slide-mode)
  (org-babel-do-load-languages
   'org-babel-load-languages '(
                               (C . t)
                               (latex . t)
                               ))
  (setq org-agenda-files (list "~/documents/todo")))

(use-package org-tree-slide
  :hook (org-tree-slide-mode . (lambda () (display-line-numbers-mode -1)))
  :config
  (require 'org-tree-slide)
  (org-tree-slide-simple-profile))

(use-package org-bullets
  :hook
  (org-mode . (org-bullets-mode)))

;; Syntax highlighting when exporting org mode to html
(use-package htmlize)

(defun my-add-project ()
  "Add the current folder as a projectile project."
  (interactive)
  (shell-command "touch .projectile")
  (projectile-add-known-project default-directory))

(defun load-stb-theme ()
  "Load the minimal stb theme and set colors of hl-todo"
  (interactive)
  (use-package hl-todo
    :config
    (make-face-unbold (quote hl-todo))
    (global-hl-todo-mode)
    (setq hl-todo-keyword-faces '(("HOLD" . "#e4e4ef")
                                  ("TODO" . "#e4e4ef")
                                  ("NEXT" . "#e4e4ef")
                                  ("THEM" . "#e4e4ef")
                                  ("PROG" . "#e4e4ef")
                                  ("OKAY" . "#e4e4ef")
                                  ("DONT" . "#e4e4ef")
                                  ("FAIL" . "#e4e4ef")
                                  ("DONE" . "#e4e4ef")
                                  ("NOTE" . "#e4e4ef")
                                  ("KLUDGE" . "#e4e4ef")
                                  ("HACK" . "#e4e4ef")
                                  ("TEMP" . "#e4e4ef")
                                  ("FIXME" . "#e4e4ef")
                                  ("XXXX*" . "#e4e4ef"))))
  (load-theme 'stb t))

(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

;; (use-package zenburn-theme
;;   :config
;;   (load-theme 'zenburn t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9bb886cdc9d0a7dbf1302f1ff950d7d462c02ae7694fccde6ebb3bd50aa8e750" "f58898a9b3f1497fdc7ed806c20556f0471aaf2e6c886ed9e3d9c762922d4bc4" "0ecfd6661fa99fd51b0a231aa11586e8871d89ac219e1f4faa294d3a13a6ce92" "9f98c4fc25756414fb9b4ac51bc6da2dd760a6a2195eee7b9763f81474e79d7e" "cad5759bc080bf6be0730c061077b5d9038e6dd9fade0640930270ff7871c1de" "2aee649f0cc3c1201348ce86019dbaed8828bd6ca546c9ae08ebd80ea20e9abd" "d3755b5f20f67d7831696ec431d0a38bf074d37a4a1647eafc0aebb93cb15b93" "80a4a1c84800fd7c436240fc116e2fa46e5272e3795de6e2bac8a46198b1e57d" "24d7c6422ce62297e0d9332bc583209dd4e1b2704f4f6c61f5bdc3c44681b6a2" "6e4b9a565c968c66d152a9c1846d0bbf1c980035e889cc9ccd689e5ae8e5cf7e" "9308c3ad270254038b1f0d67682d5f3b207cb9add5320f6cc1eac6a15b9a40d7" "fb46652c32eb9402210a6cb6e94ae9ec42a3ec5985e37721602b598463465d57" "cb37a31e4ba2c79bd6876a375dc9611d9c9efaeb29214797776e1f3cde21261c" "c3957b559cf3606c9a40777c5712671db3c7538e5d5ea9f63eb0729afeac832b" "801a567c87755fe65d0484cb2bded31a4c5bb24fd1fe0ed11e6c02254017acb2" "dbade2e946597b9cda3e61978b5fcc14fa3afa2d3c4391d477bdaeff8f5638c5" "a1e0f6bbe7cf2890412b46bff6641b893f5cc52dec9198ab2315adf1a329cb85" "4780d7ce6e5491e2c1190082f7fe0f812707fc77455616ab6f8b38e796cbffa9" "cc0dbb53a10215b696d391a90de635ba1699072745bf653b53774706999208e3" "2dc03dfb67fbcb7d9c487522c29b7582da20766c9998aaad5e5b63b5c27eec3f" default))
 '(package-selected-packages
   '(org-tree-slide php-mode htmlize glsl-mode aggressive-indent-mode evil-org dired evil-multiedit tree-sitter-hl-mode prettier-js sudo-edit gruber-darker-theme tree-sitter-indent tree-sitter-langs tree-sitter pyvenv which-key rainbow-mode yasnippet unicode-escape undo-tree quelpa-use-package iedit hydra frame-local flymake-easy epc commenter ansible)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-ellipsis ((t (:inherit default :height 0.75))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.25))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.1))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.05))))
 '(org-level-4 ((t (:inherit outline-4))))
 '(org-level-5 ((t (:inherit outline-5)))))
