;;; stb-theme.el --- Theme

;; Copyright (C) 2023 , progkea

;; Author: progkea
;; Version: 0.1
;; Package-Requires: ((emacs "24"))
;; Created with ThemeCreator, https://github.com/mswift42/themecreator.


;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;; This file is not part of Emacs.

;;; Commentary:

;;; Code:

(deftheme stb
  "stb theme for emacs")

;; Please, install rainbow-mode.
;; Colors with +x are lighter. Colors with -x are darker.
(let ((stb-fg    "#e4e4ef")
      (stb-black "#000000")
      (stb-bg-1  "#101010")
      (stb-bg    "#181818")
      (stb-bg+1  "#282828")
      (stb-bg+2  "#453d41")
      (stb-bg+3  "#484848")
      (stb-bg+4  "#52494e")
      (stb-red-1 "#c73c3f")
      (stb-red   "#f43841")
      (stb-green "#73c936")
      (stb-brown "#cc8c3c")
      (stb-blue  "#96a6c8")
      (stb-red+1 "#ff4f58"))
  (custom-theme-set-variables
   'stb
   '(frame-brackground-mode (quote dark)))

  (custom-theme-set-faces
   'stb

   ;; Agda2
   `(agda2-highlight-datatype-face ((t (:foreground ,stb-fg))))
   `(agda2-highlight-primitive-type-face ((t (:foreground ,stb-fg))))
   `(agda2-highlight-function-face ((t (:foreground ,stb-fg))))
   `(agda2-highlight-keyword-face ((t ,(list :foreground stb-fg
                                            ))))
   `(agda2-highlight-inductive-constructor-face ((t (:foreground ,stb-bg+2))))
   `(agda2-highlight-number-face ((t (:foreground ,stb-fg))))

   ;; AUCTeX
   `(font-latex-bold-face ((t (:foreground ,stb-fg))))
   `(font-latex-italic-face ((t (:foreground ,stb-fg :italic t))))
   `(font-latex-math-face ((t (:foreground ,stb-bg+2))))
   `(font-latex-sectioning-5-face ((t ,(list :foreground stb-fg
                                            ))))
   `(font-latex-slide-title-face ((t (:foreground ,stb-fg))))
   `(font-latex-string-face ((t (:foreground ,stb-bg+3))))
   `(font-latex-warning-face ((t (:foreground ,stb-red))))

   ;; Basic Coloring (or Uncategorized)
   `(border ((t ,(list :background stb-bg-1
                       :foreground stb-bg+2))))
   `(cursor ((t (:background ,stb-fg))))
   `(default ((t ,(list :foreground stb-fg
                        :background stb-bg))))
   `(fringe ((t ,(list :background stb-bg-1
                       :foreground stb-bg+2))))
   `(vertical-border ((t ,(list :foreground stb-bg+2))))
   `(link ((t (:foreground ,stb-fg :underline t))))
   `(link-visited ((t (:foreground ,stb-fg :underline t))))
   `(match ((t (:background ,stb-bg+4))))
   `(shadow ((t (:foreground ,stb-bg+4))))
   `(minibuffer-prompt ((t (:foreground ,stb-fg))))
   `(region ((t (:background ,stb-bg+3 :foreground nil))))
   `(secondary-selection ((t ,(list :background stb-bg+3
                                    :foreground nil))))
   `(trailing-whitespace ((t ,(list :foreground stb-black
                                    :background stb-red))))
   `(tooltip ((t ,(list :background stb-bg+4
                        :foreground stb-fg))))

   ;; Calendar
   `(holiday-face ((t (:foreground ,stb-red))))

   ;; Custom
   `(custom-state ((t (:foreground ,stb-bg+2))))

   ;; Diff
   `(diff-removed ((t ,(list :foreground stb-red+1
                             :background nil))))
   `(diff-added ((t ,(list :foreground stb-bg+2
                           :background nil))))

   ;; Dired
   `(dired-directory ((t (:foreground ,stb-blue))))
   `(dired-ignored ((t ,(list :foreground stb-fg
                              :inherit 'unspecified))))

   ;; Ebrowse
   `(ebrowse-root-class ((t (:foreground ,stb-fg))))
   `(ebrowse-progress ((t (:background ,stb-fg))))

   ;; Egg
   `(egg-branch ((t (:foreground ,stb-fg))))
   `(egg-branch-mono ((t (:foreground ,stb-fg))))
   `(egg-diff-add ((t (:foreground ,stb-bg+2))))
   `(egg-diff-del ((t (:foreground ,stb-red))))
   `(egg-diff-file-header ((t (:foreground ,stb-fg))))
   `(egg-help-header-1 ((t (:foreground ,stb-fg))))
   `(egg-help-header-2 ((t (:foreground ,stb-fg))))
   `(egg-log-HEAD-name ((t (:box (:color ,stb-fg)))))
   `(egg-reflog-mono ((t (:foreground ,stb-fg))))
   `(egg-section-title ((t (:foreground ,stb-fg))))
   `(egg-text-base ((t (:foreground ,stb-fg))))
   `(egg-term ((t (:foreground ,stb-fg))))

   ;; ERC
   `(erc-notice-face ((t (:foreground ,stb-fg))))
   `(erc-timestamp-face ((t (:foreground ,stb-bg+2))))
   `(erc-input-face ((t (:foreground ,stb-red+1))))
   `(erc-my-nick-face ((t (:foreground ,stb-red+1))))

   ;; EShell
   `(eshell-ls-backup ((t (:foreground ,stb-fg))))
   `(eshell-ls-directory ((t (:foreground ,stb-fg))))
   `(eshell-ls-executable ((t (:foreground ,stb-bg+2))))
   `(eshell-ls-symlink ((t (:foreground ,stb-fg))))

   ;; Font Lock
   `(font-lock-builtin-face ((t (:foreground ,stb-fg))))
   `(font-lock-comment-face ((t (:foreground ,stb-bg+2))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,stb-bg+2))))
   `(font-lock-constant-face ((t (:foreground ,stb-fg))))
   `(font-lock-doc-face ((t (:foreground ,stb-bg+2))))
   `(font-lock-doc-string-face ((t (:foreground ,stb-bg+3))))
   `(font-lock-function-name-face ((t (:foreground ,stb-fg))))
   `(font-lock-keyword-face ((t (:foreground ,stb-fg))))
   `(font-lock-preprocessor-face ((t (:foreground ,stb-fg))))
   `(font-lock-reference-face ((t (:foreground ,stb-fg))))
   `(font-lock-string-face ((t (:foreground ,stb-bg+3))))
   `(font-lock-type-face ((t (:foreground ,stb-fg))))
   `(font-lock-variable-name-face ((t (:foreground ,stb-fg))))
   `(font-lock-warning-face ((t (:foreground ,stb-red))))

   ;; Flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,stb-red)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:foreground ,stb-red :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,stb-fg)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:forground ,stb-fg :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,stb-bg+2)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:forground ,stb-bg+2 :underline t))))

   ;; Flyspell
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,stb-red) :inherit unspecified))
      (t (:foreground ,stb-red :underline t))))
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,stb-fg) :inherit unspecified))
      (t (:foreground ,stb-fg :underline t))))

   ;; Helm
   `(helm-candidate-number ((t ,(list :background stb-bg+2
                                      :foreground stb-fg
                                     ))))
   `(helm-ff-directory ((t ,(list :foreground stb-fg
                                  :background stb-bg
                                 ))))
   `(helm-ff-executable ((t (:foreground ,stb-bg+2))))
   `(helm-ff-file ((t (:foreground ,stb-fg :inherit unspecified))))
   `(helm-ff-invalid-symlink ((t ,(list :foreground stb-bg
                                        :background stb-red))))
   `(helm-ff-symlink ((t (:foreground ,stb-fg))))
   `(helm-selection-line ((t (:background ,stb-bg+1))))
   `(helm-selection ((t (:background ,stb-bg+1 :underline nil))))
   `(helm-source-header ((t ,(list :foreground stb-fg
                                   :background stb-bg
                                   :box (list :line-width -1
                                              :style 'released-button)))))

   ;; Ido
   `(ido-first-match ((t (:foreground ,stb-fg :bold nil))))
   `(ido-only-match ((t (:foreground ,stb-bg+2))))
   `(ido-subdir ((t (:foreground ,stb-fg))))

   ;; Info
   `(info-xref ((t (:foreground ,stb-fg))))
   `(info-visited ((t (:foreground ,stb-fg))))

   ;; Jabber
   `(jabber-chat-prompt-foreign ((t ,(list :foreground stb-fg
                                           :bold nil))))
   `(jabber-chat-prompt-local ((t (:foreground ,stb-fg))))
   `(jabber-chat-prompt-system ((t (:foreground ,stb-bg+2))))
   `(jabber-rare-time-face ((t (:foreground ,stb-bg+2))))
   `(jabber-roster-user-online ((t (:foreground ,stb-bg+2))))
   `(jabber-activity-face ((t (:foreground ,stb-red))))
   `(jabber-activity-personal-face ((t (:foreground ,stb-fg))))

   ;; Line Highlighting
   `(highlight ((t (:background ,stb-bg+1 :foreground nil))))
   `(highlight-current-line-face ((t ,(list :background stb-bg+1
                                            :foreground nil))))

   ;; line numbers
   `(line-number ((t (:inherit default :foreground ,stb-bg+4))))
   `(line-number-current-line ((t (:inherit line-number :foreground ,stb-fg))))

   ;; Linum
   `(linum ((t `(list :foreground stb-fg
                      :background stb-bg))))

   ;; Magit
   `(magit-branch ((t (:foreground ,stb-fg))))
   `(magit-diff-hunk-header ((t (:background ,stb-bg+2))))
   `(magit-diff-file-header ((t (:background ,stb-bg+4))))
   `(magit-log-sha1 ((t (:foreground ,stb-red+1))))
   `(magit-log-author ((t (:foreground ,stb-bg+2))))
   `(magit-log-head-label-remote ((t ,(list :foreground stb-bg+2
                                            :background stb-bg+1))))
   `(magit-log-head-label-local ((t ,(list :foreground stb-fg
                                           :background stb-bg+1))))
   `(magit-log-head-label-tags ((t ,(list :foreground stb-fg
                                          :background stb-bg+1))))
   `(magit-log-head-label-head ((t ,(list :foreground stb-fg
                                          :background stb-bg+1))))
   `(magit-item-highlight ((t (:background ,stb-bg+1))))
   `(magit-tag ((t ,(list :foreground stb-fg
                          :background stb-bg))))
   `(magit-blame-heading ((t ,(list :background stb-bg+1
                                    :foreground stb-fg))))

   ;; Message
   `(message-header-name ((t (:foreground ,stb-bg+2))))

   ;; Mode Line
   `(mode-line ((t ,(list :background stb-bg+1
                          :foreground stb-fg))))
   `(mode-line-buffer-id ((t ,(list :background stb-bg+1
                                    :foreground stb-fg))))
   `(mode-line-inactive ((t ,(list :background stb-bg+1
                                   :foreground stb-fg))))

   ;; Neo Dir
   `(neo-dir-link-face ((t (:foreground ,stb-fg))))

   ;; Org Mode
   `(org-agenda-structure ((t (:foreground ,stb-fg))))
   `(org-column ((t (:background ,stb-bg-1))))
   `(org-column-title ((t (:background ,stb-bg-1 :underline t))))
   `(org-done ((t (:foreground ,stb-bg+2))))
   `(org-todo ((t (:foreground ,stb-red-1))))
   `(org-upcoming-deadline ((t (:foreground ,stb-fg))))

   ;; Search
   `(isearch ((t ,(list :foreground stb-black
                        :background stb-fg))))
   `(isearch-fail ((t ,(list :foreground stb-black
                             :background stb-red))))
   `(isearch-lazy-highlight-face ((t ,(list
                                       :foreground stb-fg
                                       :background stb-fg))))

   ;; Sh
   `(sh-quoted-exec ((t (:foreground ,stb-red+1))))

   ;; Show Paren
   `(show-paren-match-face ((t (:background ,stb-bg+4))))
   `(show-paren-mismatch-face ((t (:background ,stb-red-1))))

   ;; Slime
   `(slime-repl-inputed-output-face ((t (:foreground ,stb-red))))

   ;; Tuareg
   `(tuareg-font-lock-governing-face ((t (:foreground ,stb-fg))))

   ;; Speedbar
   `(speedbar-directory-face ((t ,(list :foreground stb-fg
                                        :weight 'bold))))
   `(speedbar-file-face ((t (:foreground ,stb-fg))))
   `(speedbar-highlight-face ((t (:background ,stb-bg+1))))
   `(speedbar-selected-face ((t (:foreground ,stb-red))))
   `(speedbar-tag-face ((t (:foreground ,stb-fg))))

   ;; Which Function
   `(which-func ((t (:foreground ,stb-fg))))

   ;; Whitespace
   `(whitespace-space ((t ,(list :background stb-bg
                                 :foreground stb-bg+1))))
   `(whitespace-tab ((t ,(list :background stb-bg
                               :foreground stb-bg+1))))
   `(whitespace-hspace ((t ,(list :background stb-bg
                                  :foreground stb-bg+2))))
   `(whitespace-line ((t ,(list :background stb-bg+2
                                :foreground stb-red+1))))
   `(whitespace-newline ((t ,(list :background stb-bg
                                   :foreground stb-bg+2))))
   `(whitespace-trailing ((t ,(list :background stb-red
                                    :foreground stb-red))))
   `(whitespace-empty ((t ,(list :background stb-fg
                                 :foreground stb-fg))))
   `(whitespace-indentation ((t ,(list :background stb-fg
                                       :foreground stb-red))))
   `(whitespace-space-after-tab ((t ,(list :background stb-fg
                                           :foreground stb-fg))))
   `(whitespace-space-before-tab ((t ,(list :background stb-bg+2
                                            :foreground stb-bg+2))))

   ;; tab-bar
   `(tab-bar ((t (:background ,stb-bg+1 :foreground ,stb-bg+4))))
   `(tab-bar-tab ((t (:background nil :foreground ,stb-fg))))
   `(tab-bar-tab-inactive ((t (:background nil))))

   ;; Compilation
   `(compilation-info ((t ,(list :foreground stb-green
                                 :inherit 'unspecified))))
   `(compilation-warning ((t ,(list :foreground stb-brown
                                    :bold t
                                    :inherit 'unspecified))))
   `(compilation-error ((t (:foreground ,stb-red+1))))
   `(compilation-mode-line-fail ((t ,(list :foreground stb-red
                                           :weight 'bold
                                           :inherit 'unspecified))))
   `(compilation-mode-line-exit ((t ,(list :foreground stb-green
                                           :weight 'bold
                                           :inherit 'unspecified))))

   ;;;;; company-mode
   `(company-tooltip ((t (:foreground ,stb-fg :background ,stb-bg+1))))
   `(company-tooltip-annotation ((t (:foreground ,stb-bg+2 :background ,stb-bg+1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,stb-bg+2 :background ,stb-bg-1))))
   `(company-tooltip-selection ((t (:foreground ,stb-fg :background ,stb-bg-1))))
   `(company-tooltip-mouse ((t (:background ,stb-bg-1))))
   `(company-tooltip-common ((t (:foreground ,stb-bg+2))))
   `(company-tooltip-common-selection ((t (:foreground ,stb-bg+2))))
   `(company-scrollbar-fg ((t (:background ,stb-bg-1))))
   `(company-scrollbar-bg ((t (:background ,stb-bg+2))))
   `(company-preview ((t (:background ,stb-bg+2))))
   `(company-preview-common ((t (:foreground ,stb-bg+2 :background ,stb-bg-1))))

   ;;;;; Proof General
   `(proof-locked-face ((t (:background ,stb-fg))))
   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'stb)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; stb-theme.el ends here
