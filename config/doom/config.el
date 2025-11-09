;; normal configuration
(setq user-full-name "Diogo Assunção"
      user-mail-address "up202408560@edu.fc.up.pt")

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'frappe)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "Inter" :size 18)
      )

(setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)

;; Org configuration
(setq org-directory "~/org/")

;; performance
(setq gc-cons-threshold (* 100 1024 1024))  ; 100MB
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024))))
(add-hook 'focus-out-hook #'garbage-collect)
(setq read-process-output-max (* 1024 1024)) ; 1MB
(setq large-file-warning-threshold (* 100 1024 1024)) ; Warn for 100MB+ files

(add-hook 'text-mode-hook
          (lambda ()
            (corfu-mode -1)))

(add-hook 'org-mode-hook
          (lambda ()
            (corfu-mode -1)))

(add-hook 'latex-mode-hook
          (lambda ()
            (corfu-mode -1)))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (corfu-mode -1)))

(defun my/toggle-corfu-with-auto ()
  "Toggle corfu-mode and auto-completion"
  (interactive)
  (if corfu-mode
      (progn
        (corfu-mode -1)
        (setq-local corfu-auto nil)
        (message "Corfu disabled"))
    (progn
      (setq-local corfu-auto t)
      (setq-local corfu-auto-delay 0)
      (setq-local corfu-auto-prefix 1)
      (corfu-mode 1)
      (corfu-mode 1)  ;; Call it twice to force initialization
      (run-with-timer 0.1 nil (lambda ()
                                (when (bound-and-true-p corfu-mode)
                                  (message "Corfu enabled and ready"))))
      )))

(after! org
  (custom-set-faces!
    '(org-level-8 :inherit outline-3 :height 1.0)
    '(org-level-7 :inherit outline-3 :height 1.0)
    '(org-level-6 :inherit outline-3 :height 1.1)
    '(org-level-5 :inherit outline-3 :height 1.2)
    '(org-level-4 :inherit outline-3 :height 1.3)
    '(org-level-3 :inherit outline-3 :height 1.4)
    '(org-level-2 :inherit outline-2 :height 1.5)
    '(org-level-1 :inherit outline-1 :height 1.6)
    '(org-document-title :height 1.8 :bold t :underline nil))

  (setq org-hide-emphasis-markers t)
  (setq org-hide-leading-stars t)
  (setq org-modern-table-vertical 1)
  (setq org-modern-table t)

  (defun my/org-mode-setup-padding ()
    "Add Horizontal Padding to Org Mode"
    (setq left-margin-width 3
          right-margin-width 3)
    (set-window-buffer (selected-window) (current-buffer)))

  (defun my/org-emphasize (marker)
    "Wrap region or insert MARKER (Org emphasis: *, /, _, =, +, ~)."
    (interactive "cEmphasis marker (* / _ = + ~): ")
    (if (use-region-p)
        (let ((beg (region-beginning))
              (end (region-end)))
          (save-excursion
            (goto-char end)
            (insert marker)
            (goto-char beg)
            (insert marker)))
      (insert marker marker)
      (backward-char 1)))

  (add-hook 'org-mode-hook #'my/org-mode-setup-padding)
  (add-hook 'org-mode-hook (lambda () (display-line-numbers-mode 0)))

  (map! :map org-mode-map
        :n "C-c e" #'my/org-emphasize
        :i "C-c e" #'my/org-emphasize)
  )


(after! corfu
  (setq corfu-cycle t)
  (setq corfu-auto t)
  (setq corfu-auto-delay 0)
  (setq corfu-auto-prefix 1)
  (setq corfu-preselect 'first)
  (setq corfu-separator ?\s)
  (setq corfu-quit-no-match 'separator)
  (setq corfu-preview-current t)
  (setq corfu-count 10)
  (setq corfu-quit-at-boundary t)
  (setq corfu-preselect-first t)

  (setq completion-cycle-threshold 3)
  (setq tab-always-indent 'complete)

  (setq corfu-popupinfo-delay '(0.5 . 0.5))
  (setq corfu-auto nil)
  (setq corfu-auto t)

  (add-hook 'minibuffer-setup-hook
            (lambda ()
              (setq-local corfu-auto nil)))

  (add-hook 'org-mode-hook
            (lambda ()
              (corfu-mode 1)
              (setq-local corfu-auto nil)))
  )

(use-package! corfu-popupinfo
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :config
  (setq corfu-popupinfo-delay '(0.1 . 0.1)))

;; evil-mode
(after! evil
  (defalias #'forward-evil-word #'forward-evil-symbol)
  (add-hook 'evil-command-line-mode-hook
            (lambda () (corfu-mode -1)))
  )

;; projectile
(after! projectile
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching nil)
  )

;; vterm
(after! vterm
  (setq vterm-timer-delay 0)

  (set-popup-rule! "^\\*doom:vterm"
    :size 0.5
    :width 0.5
    :side 'bottom
    :vslot -4
    :select t
    :quit t
    :ttl 0
    :modeline t)

  (setq +doom-dashboard-functions nil)
  (setq initial-buffer-choice
        (lambda ()
          (let ((buf (get-buffer-create "*vterm-startup*")))
            (with-current-buffer buf
              (unless (eq major-mode 'vterm-mode)
                (vterm-mode)))
            buf)))
  )

;;; Eglot Configuration
(use-package! eglot
  :hook ((elixir-mode go-mode) . eglot-ensure)
  :config

  (setq eglot-events-buffer-size 2000000)

  ;; (add-to-list 'eglot-server-programs
  ;;              '((elixir-mode elixir-ts-mode heex-ts-mode)
  ;;                . ("nextls" "--stdio")))

  (add-to-list 'eglot-server-programs
               '((elixir-mode elixir-ts-mode heex-ts-mode)
                 . ("lexical" "start")))

  (add-to-list 'eglot-server-programs
               '(go-mode . ("gopls")))

  (add-to-list 'eglot-server-programs
               '(yaml-mode "yaml-language-server" "--stdio"))

  ;; (setq eglot-events-buffer-size 0)
  (setq eldoc-idle-delay 0.1)
  (setq eglot-send-changes-idle-time 0.3)
  (setq eglot-connect-timeout 120)

  (setq eldoc-echo-area-use-multiline-p nil)
  (set-popup-rule! "^\\*eldoc\\*" :side 'bottom :size 0.3 :select t :quit t)

  (setq completion-category-defaults nil)
  (setq completion-category-overrides '((eglot (styles basic))))

  (setq-default eglot-workspace-configuration
                '((:gopls .
                   ((staticcheck . t)
                    (usePlaceholders . t)
                    (completeUnimported . t)
                    (matcher . "CaseInsensitive")
                    (deepCompletion . t)
                    (analyses . ((unusedparams . t)
                                 (shadow . t)))))

                  (:yaml . (:schemas (:https://raw.githubusercontent.com/compose-spec/compose-spec/main/schema/compose-spec.json
                                      ["docker-compose.yml" "docker-compose.*.yml"])))

                  ;; (:elixirLS .
                  ;;            ((:dialyzerEnabled . :json-false)
                  ;;             (:suggestSpecs . :json-false)
                  ;;             (:incrementalDialyzer . :json-false)
                  ;;             (:fetchDeps . :json-false)))
                  ))

  ;; Enable eglot and corfu for YAML
  (add-hook 'yaml-mode-hook #'eglot-ensure)
  (add-hook 'yaml-mode-hook #'corfu-mode)

  (map! :map eglot-mode-map
        :n "gd" #'xref-find-definitions
        :n "gD" #'xref-find-references
        :n "K"  #'eldoc-doc-buffer
        :n "gr" #'eglot-find-implementation
        :leader
        :desc "Rename" "cr" #'eglot-rename
        :desc "Code actions" "ca" #'eglot-code-actions
        :desc "Format buffer" "cf" #'eglot-format-buffer))

(after! apheleia
  (setf (alist-get 'goimports apheleia-formatters) '("goimports"))
  (setf (alist-get 'go-mode apheleia-mode-alist) 'goimports)

  (setf (alist-get 'elixir-mode apheleia-mode-alist) 'mix-format))

;; Key Maps
(map! :ni "C-ç" #'+vterm/toggle)

;;; tree maps
(after! evil
  ;; unbind C-b for treemacs
  (define-key evil-motion-state-map (kbd "C-b") nil)
  (define-key evil-normal-state-map (kbd "C-b") nil)

  ;; unbind C-d for multi-edit
  (define-key evil-motion-state-map (kbd "C-d") nil)
  (define-key evil-normal-state-map (kbd "C-d") nil)
  (define-key evil-visual-state-map (kbd "C-d") nil))

(map! :gnv "C-d"   #'evil-multiedit-match-symbol-and-next
      :gnv "C-S-d" #'evil-multiedit-match-symbol-and-prev
      :gnv "C-M-l" #'evil-multiedit-match-all)

(map! :g "C-b" #'+treemacs/toggle
      :g "C-S-b" #'treemacs-select-window)

(after! treemacs
  (map! :map treemacs-mode-map
        :nm "C-M-b" #'evil-window-prev
        :nm "C-b" #'+treemacs/toggle))

(map! :after lsp-mode
      :map lsp-mode-map
      :leader
      :prefix ("c" . "code")
      "a" #'lsp-execute-code-action
      "r" #'lsp-rename
      "f" #'lsp-format-buffer
      "d" #'lsp-describe-thing-at-point

      :prefix ("g" . "goto")
      "d" #'lsp-find-definition
      "r" #'lsp-find-references
      "i" #'lsp-find-implementation
      "t" #'lsp-find-type-definition

      :prefix ("w" . "workspace")
      "r" #'lsp-workspace-restart
      "s" #'lsp-workspace-shutdown)

(map! :after corfu
      :map corfu-map
      "C-SPC" #'completion-at-point)

(map! :i "C-SPC" #'completion-at-point)

(map! :leader
      :desc "Toggle corfu" "t c" #'my/toggle-corfu-with-auto)

(map! :leader
      :desc "Open dired" "-" #'dired-jump)
