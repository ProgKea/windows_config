;; This is my minimal config for working on windows

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
  (evil-define-key 'normal 'global (kbd "C-k") #'compile)
  (evil-define-key 'normal 'global (kbd "C-l") #'async-shell-command)

  (evil-define-key 'normal 'global (kbd "gl") #'recenter-top-bottom)

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

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package projectile
  :init
  (projectile-mode 1)
  (evil-define-key 'normal 'global (kbd "C-f") #'projectile-find-file)
  (evil-define-key 'normal 'global (kbd "C-s") #'projectile-switch-project)
  (evil-define-key 'normal 'global (kbd "C-x pa") #'projectile-add-known-project))

(use-package consult
  :after evil)

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

(use-package corfu
  :after yasnippet
  :custom
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
  (evil-define-key 'normal compilation-mode-map "r" #'recompile))

(use-package dired
  :ensure nil
  :config
  (add-hook #'dired-mode-hook #'auto-revert-mode)
  (evil-define-key 'normal dired-mode-map (kbd "<SPC>") #'evil-send-leader)
  (evil-define-key 'normal dired-mode-map "r" #'revert-buffer)
  (add-hook #'eww-mode-hook #'(lambda () (display-line-numbers-mode -1))))

(use-package rainbow-mode)
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

(defun my-add-project ()
  "Add the current folder as a projectile project."
  (interactive)
  (shell-command "touch .projectile")
  (projectile-add-known-project default-directory))

;; (use-package gruber-darker-theme
;;   :config
;;   (load-theme 'gruber-darker t))

(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))

(set-frame-font "Consolas-14" nil t)
