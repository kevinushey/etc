;; -*- mode: emacs-lisp -*-

(defun system-is-mac ()
  (eq system-type 'darwin))

(defun dotspacemacs/irony-server-rpath-munge ()
  (when (system-is-mac)
    (let* ((irony-server-path (expand-file-name "~/.emacs.d/irony/bin/irony-server"))
           (rpath-from "@rpath/libclang.dylib")
           (rpath-to "/usr/local/opt/llvm/lib/libclang.dylib")
           (install-server-command
            (mapconcat
             'identity
             `(
               "install_name_tool"
               "-change"
               ,rpath-from
               ,rpath-to
               ,irony-server-path) " ")))
      (shell-command install-server-command))
    )
  )

;; Enable ycmd.

(setq
 ycmd-server-command
 '("python" ,(expand-file-name "~/.ycmd/ycmd")))

;; Ensure that 'usr/local/bin' is on the exec-path. This ensures that
;; e.g. 'ag' can be located on OS X.
(when (and
       (not (eq system-type 'windows-nt))
       (not (member "/usr/local/bin" exec-path)))
  (setq exec-path (append '("/usr/local/bin") exec-path)))

;; Make the current line highlighting a bit less prominent (so it doesn't
;; mask the current selection)
(set-face-background 'hl-line "#2F2F2F")

;; Tell smartparens to indent when inserting newline within '()'.
(add-hook
 'smartparens-mode-hook
 (lambda ()
   (sp-with-modes '(c-mode c++-mode js2-mode ess-mode)
     (sp-local-pair "(" ")" :post-handlers '(("||\n[i]" "RET"))))))

;; Workaround for yasnippet + smartparens incompatibility
(add-hook 'yas-before-expand-snippet-hook (lambda () (smartparens-mode -1)))
(add-hook 'yas-after-exit-snippet-hook (lambda () (smartparens-mode 1)))

;; Override theme settings that over-aggressively highlight the current line
(set-face-foreground 'highlight nil)
(set-face-underline-p 'highlight nil)

;; Don't use the default, terribly ugly, spacemacs coloring for highlight searches
(when (not (display-graphic-p))
  (set-face-attribute 'evil-search-highlight-persist-highlight-face nil :background "#424"))

;; Ensure that command and alt behave on OS X
(when (boundp 'mac-command-modifier)
  (setq mac-command-modifier 'super))

(when (boundp 'mac-option-modifier)
  (setq mac-option-modifier 'meta))

(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

;; Update change log, respecting current git changes. I swear this used to work
;; automagically before; who knows what changed.
(defun dotspacemacs/config/update-change-log ()
  (interactive)
  (let* ((root (projectile-project-root))
         (changelog-path (concat (file-name-as-directory root) "ChangeLog"))
         (date (shell-command-to-string "echo -n $(date +%Y-%m-%d)"))
         (name (user-full-name))
         (email (replace-regexp-in-string "\n" "" (shell-command-to-string "git config user.email")))
         (git-status (shell-command-to-string "git status --short --porcelain"))
         (changes
          (replace-regexp-in-string "\n" ": \n"
                                    (replace-regexp-in-string "^[[:space:]]*[^[:space:]]+" "        *" git-status)))
         (header (concat date "  " name "  <" email ">")))

    (find-file (concat (file-name-as-directory root) "ChangeLog"))
    (beginning-of-buffer)
    (insert header "\n\n" changes "\n\n")
    (goto-line 4)
    (backward-char 1)
    ))

;; Nicer linum formatting (I prefer a tiny bit of horizontal space after the
;; numbers)
(setq linum-format "%3d ")

;; Ensure /usr/local/bin is on the PATH. This is a manifestation of an OS X
;; bug / feature where the PATH is not properly inheritted by child processes.
(if (system-is-mac)
    (setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH"))))

;; Don't highlight empty lines or trailing whitespace.
(setq-default show-trailing-whitespace nil)
(setq-default spacemacs-show-trailing-whitespace nil)
(setq-default indicate-empty-lines nil)

;; Use a default separator that will display well with non-powerline fonts.
(setq powerline-default-separator 'arrow)

;; Remove projectile's C-c keybindings -- I prefer to just use the leader key
;; for these sorts of things
(setq projectile-keymap-prefix (kbd "C-S-P"))

;; Don't move the cursor back when exiting insert mode.
(setq evil-move-cursor-back nil)

;; Ensure line numbers always displayed
(global-linum-mode)

;; Make magit quiet
(setq magit-last-seen-setup-instructions "1.4.0")

;; Don't warn when following symlinks
(setq vc-follow-symlinks t)

;; Ensure that 'Ctrl + C' returns to Normal mode.
(defun dotspacemacs/config/smart-ctrl-c (prompt)
  (cond

   ;; Allow C-c to close a (company) autocompletion popup.
   ((and
     (boundp 'company-pseudo-tooltip-overlay)
     (not (eq company-pseudo-tooltip-overlay nil)))
    (progn
      (company-pseudo-tooltip-hide)
      (kbd "C-g")))

   ;; Allow C-c C-c to perform a commit.
   ((equal (file-name-base (or (buffer-file-name) "")) "COMMIT_EDITMSG")
    (kbd "C-c"))

   ;; Allow C-c to return to normal mode from various other modes.
   ((or (evil-insert-state-p)
        (evil-normal-state-p)
        (evil-replace-state-p)
        (evil-visual-state-p))
    [escape])

   ;; Otherwise, treat it as a generic quit.
   (t (kbd "C-g"))))

;; Place the binding in the 'key-translation-map' so that
;; it comes into effect before anyone else gets a chance to touch it.
(define-key key-translation-map (kbd "C-c")  'dotspacemacs/config/smart-ctrl-c)
(define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)

;; Allow <DEL> to delete the selection in visual mode.
(define-key evil-visual-state-map (kbd "DEL") 'evil-delete)

;; Shortcuts for selecting previous, next windows
(global-set-key (kbd "<M-s-left>") 'evil-prev-buffer)
(global-set-key (kbd "<M-s-right>") 'evil-next-buffer)

;; Use 'v', 'S-v' to expand/contract region in visual mode.
(define-key evil-visual-state-map (kbd "v")
  (lambda ()
    (interactive)
    (er/expand-region 1)))

(define-key evil-visual-state-map (kbd "V")
  (lambda ()
    (interactive)
    (er/expand-region -1)))

;; Use <S-=>, <S--> to increase, decrease the font size
(global-set-key
 (kbd "s-=")
 (lambda ()
   (interactive)
   (let ((old-face-attribute (face-attribute 'default :height)))
     (set-face-attribute 'default nil :height (+ old-face-attribute 10)))))

(global-set-key
 (kbd "s--")
 (lambda ()
   (interactive)
   (let ((old-face-attribute (face-attribute 'default :height)))
     (set-face-attribute 'default nil :height (- old-face-attribute 10)))))

;; Define a text object for replacing inbetween parens / whitespace.
(let ((start-regex "[[:space:]\\(\\)]")
      (end-regex "[[:space:]\\(\\)]\\|$"))
  (progn
    (eval
     `(evil-define-text-object inner-name (count &optional beg end type)
        (evil-select-paren ,start-regex ,end-regex beg end type count nil)))
    (define-key evil-inner-text-objects-map "k" 'inner-name)

    (eval
     `(evil-define-text-object outer-name (count &optional beg end type)
        (evil-select-paren ,start-regex ,end-regex beg end type count t)))
    (define-key evil-outer-text-objects-map "k" 'outer-name)))

;; Add some extra motions for navigating buffers, windows quickly
(evil-leader/set-key

  ;; Quickly select separate windows
  "<up>" 'evil-window-up
  "<down>" 'evil-window-down
  "<left>" 'evil-window-left
  "<right>" 'evil-window-right

  ;; Evaluate selection
  "<RET>" 'eval-region

  ;; change log
  "aa" 'dotspacemacs/config/update-change-log

  ;; Make 'golden-ratio' more accessible
  "we" 'golden-ratio

  ;; Git extensions
  "gd" #'(lambda () (interactive) (magit-diff "HEAD"))

  ;; Miscellaneous commands
  "xf" 'dired
  "hC" 'evil-ex-nohighlight
  )

  ;;; C / C++

;; Indentation rules
(setq-default c-default-style "java"
              c-indent-tabs-mode nil
              c-basic-offset 4)

(c-set-offset 'substatement-open '0)
(c-set-offset 'inline-open '+)
(c-set-offset 'block-open '+)
(c-set-offset 'brace-list-open '+)
(c-set-offset 'case-label '+)
(c-set-offset 'innamespace 0)

(defun c++-template-args-cont (el)
  (save-excursion
    (beginning-of-line)
    (if (re-search-forward "^[\t ]*>" (line-end-position) t)
        0)))

(c-set-offset 'template-args-cont '(c++-template-args-cont c-lineup-template-args +))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

  ;;; Magit

;; Make ':q', ':wq' perform commits in git commit mode.
(evil-define-command evil-quit-or-commit (&rest args)
  (if (eq major-mode "git-commit-mode")
      (git-commit-commit)
    (funcall 'evil-quit args)))

(evil-define-command evil-save-and-close-or-commit (&rest args)
  (if (eq major-mode "git-commit-mode")
      (git-commit-commit)
    (funcall 'evil-save-and-close args)))

(evil-ex-define-cmd "q[uit]" 'evil-quit-or-commit)
(evil-ex-define-cmd "wq" 'evil-save-and-close-or-commit)

  ;;; JavaScript

;; Patch for company-tern (allow for nil depth)
(eval-after-load
    'company-tern
  (lambda ()
    (defun company-tern-depth (candidate)
      (let ((depth (get-text-property 0 'depth candidate)))
        (if (eq depth nil) 100 depth)))))

(add-hook
 'js2-mode-hook
 (lambda ()

   ;; Delay error checking a bit more.
   (setq js2-idle-timer-delay 0.7)

   ;; Use local .jshintrc
   (setq flycheck-jshintrc "~/.emacs.d/.jshintrc")

   ;; Electric indent for '{', '}'
   (setq electric-indent-chars (list ?{ ?}))

   (flycheck-mode t)
   (tern-mode t)))

  ;;; Elisp
(add-hook
 'emacs-lisp-mode-hook
 (lambda()
   (local-set-key (kbd "<s-return>") 'eval-region)
   ))

  ;;; HTML

;; No indent within 'script', 'style'
(add-hook 'html-mode-hook (lambda()
                            (web-mode)
                            (setq web-mode-script-padding 0)
                            (setq web-mode-style-padding 0)
                            ))

;; ;;; ESS
;; 
;; ;; Prefer spaces around ' = ' for argument completions
;; (setq ess-ac-R-argument-suffix " = ")
;; 
;; ;; Enable auto complete
;; (setq ess-use-auto-complete t)
;; 
;; ;; Don't skip whitespace in electric pair mode (too aggressive)
;; (setq electric-pair-skip-whitespace nil)
;; 
;; (add-hook 'ess-mode-hook (lambda () (electric-pair-mode 1)))
;; 
;; ;; Set up indentation + other useful keybindings
;; (add-hook
;;  'ess-mode-hook
;;  (lambda ()
;;    (local-set-key (kbd "<s-return>") 'ess-eval-region-or-line-and-step)
;;    (ess-smart-equals-mode nil)
;;    (evil-local-set-key 'insert (kbd "=") 'self-insert-command)
;;    (setq electric-indent-inhibit t)
;;    (show-paren-mode t)))
;; 
;; ;; Nicer syntax highlighting
;; (defun R-operators-regex ()
;;   (interactive)
;; 
;;   (defvar R-operators "$@!%^&*(){}[]-+=/<>")
;;   (defvar R-operators-split (split-string R-operators "" t))
;;   (concat
;;    "\\("
;;    (mapconcat (lambda (x) (concat "\\\\" x)) R-operators-split "\\|")
;;    "\\)"
;;    )
;;   )
;; 
;; 
;; ;; Nicer syntax highlighting
;; (add-hook
;;  'ess-mode-hook
;;  (lambda()
;;    (font-lock-add-keywords
;;     nil
;;     '(
;; 
;;       ;; base keyword highlighting
;;       ("\\<\\(if\\|for\\|while\\|function\\|return\\)\\>[\n[:blank:]]*(" 1
;;        font-lock-keyword-face)
;; 
;;       ;; highlight function names (ie, words with a '(' following)
;;       ("\\<\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*(" 1
;;        font-lock-function-name-face)
;; 
;;       ;; highlight named arguments in a function call, e.g. foo(x=bar, y=baz)
;;       ("\\([(,]\\|[\n[:blank:]]*\\)\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*=[^=]"
;;        2 font-lock-reference-face)
;; 
;;       ;; highlight numbers
;;       ("\\(-?[0-9]*\\.?[0-9]*[eE]?-?[0-9]+[iL]?\\)" 1 font-lock-type-face)
;; 
;;       ;; crazy garbage to highlight operators
;;       ;; no I don't understand emacs regex escaping rules
;;       ("\\(\\$\\|\\@\\|\\!\\|\\%\\|\\^\\|\\&\\|\\*\\|\(\\|\)\\|\{\\|\}\\|\\[\\|\\]\\|\\-\\|\\+\\|\=\\|\\/\\|\<\\|\>\\|:\\|~\\)" 1 font-lock-builtin-face)
;; 
;;       ;; highlight S4 stuff
;;       ("\\(setMethod\\|setGeneric\\|setGroupGeneric\\|setClass\\|setRefClass\\|setReplaceMethod\\)" 1 font-lock-reference-face)
;; 
;;       ;; highlight packages called through ::, :::
;;       ("\\(\\w+\\):\\{2,3\\}" 1 font-lock-constant-face)
;; 
;;       ))
;;    ))
