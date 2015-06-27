;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (ie. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion :variables
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t)
     c-c++
     colors
     company-mode
     emacs-lisp
     ess
     git
     (git :variables
          git-gutter-use-fringe t)
     html
     javascript
     markdown
     ruby
     shell
     smex
     syntax-checking
     ycmd
     )

   ;; List of additional packages that will be installed wihout being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages
   '(
     key-chord
     )

   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()

   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."

  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default

   ;; Either `vim' or `emacs'. Evil is always enabled but if the variable
   ;; is `emacs' then the `holy-mode' is enabled at startup.
   dotspacemacs-editing-style 'vim

   ;; If non nil output loading progress in `*Messages*' buffer.
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed.
   dotspacemacs-startup-banner 'official

   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'."
   dotspacemacs-startup-lists '(recents projects)

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(wombat
                         monokai
                         solarized-light
                         solarized-dark
                         leuven
                         zenburn)

   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)

   ;; The leader key
   dotspacemacs-leader-key "SPC"

   ;; The leader key accessible in `emacs state' and `insert state'
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it.
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"

   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f) is replaced.
   dotspacemacs-use-ido nil

   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content.
   dotspacemacs-enable-paste-micro-state nil

   ;; Guide-key delay in seconds. The Guide-key is the popup buffer listing
   ;; the commands bound to the current keystrokes.
   dotspacemacs-guide-key-delay 0.4

   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil ;; to boost the loading time.
   dotspacemacs-loading-progress-bar t

   ;; If non nil the frame is fullscreen when Emacs starts up.
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX."
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-inactive-transparency 90

   ;; If non nil unicode symbols are displayed in the mode line.
   dotspacemacs-mode-line-unicode-symbols nil

   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen.
   dotspacemacs-smooth-scrolling t

   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   dotspacemacs-smartparens-strict-mode nil

   ;; Select a scope to highlight delimiters. Possible value is `all',
   ;; `current' or `nil'. Default is `all'
   dotspacemacs-highlight-delimiters 'all

   ;; If non nil advises quit functions to keep server open when quitting.
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")

   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now.
   dotspacemacs-default-package-repository nil

   )

  ;; User initialization goes here

  )

(defun dotspacemacs/config ()
  "Configuration function.
 This function is called at the very end of Spacemacs initialization after
layers configuration."

  ;;; General

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
  (setq show-trailing-whitespace nil)
  (setq indicate-empty-lines nil)

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

  ;; Don't want when following symlinks
  (setq vc-follow-symlinks t)

  ;; Ensure that 'Ctrl + C' returns to Normal mode.
  (defun dotspacemacs/config/smart-ctrl-c (prompt)
    (if (not (eq company-pseudo-tooltip-overlay nil))
        (progn
          (company-pseudo-tooltip-hide)
          (kbd "C-g"))
      (cond
       ((or
         (evil-insert-state-p)
         (evil-normal-state-p)
         (evil-replace-state-p)
         (evil-visual-state-p))
        [escape])
       (t (kbd "C-g")))))

  (define-key key-translation-map (kbd "C-c")  'dotspacemacs/config/smart-ctrl-c)
  (define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)
  (set-quit-char "C-c")

  ;; Allow <DEL> to delete the selection in visual mode.
  (define-key evil-visual-state-map (kbd "DEL") 'evil-delete)

  ;; Use 'v', 'S-v' to expand/contract region in visual mode.
  (define-key evil-visual-state-map (kbd "v")
    (lambda ()
      (interactive)
      (er/expand-region 1)))

  (define-key evil-visual-state-map (kbd "V")
    (lambda ()
      (interactive)
      (er/expand-region -1)))

  ;; Use 'jk' in insert mode to return to normal mode. Should probably put this
  ;; in a layer.
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-force-normal-state)

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

  ;; Don't indent within 'define' statements.
  (defun require-def-deindent (list index)
    (when (and (eq (nth 0 parse-status) 2)
               (save-excursion
                 (let ((tl-point (syntax-ppss-toplevel-pos parse-status)))
                   (goto-char tl-point)
                   (backward-word 1)
                   (equal "define" (buffer-substring (point) tl-point))))
               ;; only intercede if they are suggesting what the sexprs suggest
               (let ((suggested-column (js2-proper-indentation parse-status)))
                 (eq (nth index list) suggested-column))
               )
      (indent-line-to 0)
      't
      ))

  ;; Patch for company-tern (allow for nil depth)
  (eval-after-load
      'company-tern
    (lambda ()
      (defun company-tern-depth (candidate)
        (let ((depth (get-text-property 0 'depth candidate)))
          (if (eq depth nil) 0 depth)))))

  (add-hook
   'js2-mode-hook
   (lambda ()
     
     ;; Delay error checking a bit more.
     (setq js2-idle-timer-delay 1)

     ;; Don't indent within 'define' functions.
     (defadvice js2-indent-line (around js2-indent-line-around)
       ad-do-it
       (let ((parse-status (save-excursion
                             (parse-partial-sexp (point-min) (point-at-bol))))
             positions)
         (push (current-column) positions)
         (require-def-deindent positions 0)))
     (ad-activate 'js2-indent-line)

     ;; Only indent following '{', '}'.
     (setq electric-indent-chars (list ?{ ?}))

     (flycheck-mode t)
     (tern-mode t)))

  ;;; HTML

  ;; No indent within 'script', 'style'
  (add-hook 'html-mode-hook (lambda()
                              (web-mode)
                              (setq web-mode-script-padding 0)
                              (setq web-mode-style-padding 0)
                              ))

  ;;; ESS

  ;; Prefer spaces around ' = ' for argument completions
  (setq ess-ac-R-argument-suffix " = ")

  ;; Enable auto complete
  (setq ess-use-auto-complete t)

  ;; Don't skip whitespace in electric pair mode (too aggressive)
  (setq electric-pair-skip-whitespace nil)

  (add-hook 'ess-mode-hook (lambda () (electric-pair-mode 1)))

  ;; Set up indentation + other useful keybindings
  (add-hook
   'ess-mode-hook
   (lambda ()
     (local-set-key (kbd "<s-return>") 'ess-eval-region-or-line-and-step)
     (ess-smart-equals-mode nil)
     (evil-local-set-key 'insert (kbd "=") 'self-insert-command)
     (show-paren-mode t)))

  ;; Nicer syntax highlighting
  (defun R-operators-regex ()
    (interactive)

    (defvar R-operators "$@!%^&*(){}[]-+=/<>")
    (defvar R-operators-split (split-string R-operators "" t))
    (concat
     "\\("
     (mapconcat (lambda (x) (concat "\\\\" x)) R-operators-split "\\|")
     "\\)"
     )
    )


  ;; Nicer syntax highlighting
  (add-hook
   'ess-mode-hook
   (lambda()
     (font-lock-add-keywords
      nil
      '(

        ;; base keyword highlighting
        ("\\<\\(if\\|for\\|while\\|function\\|return\\)\\>[\n[:blank:]]*(" 1
         font-lock-keyword-face)

        ;; highlight function names (ie, words with a '(' following)
        ("\\<\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*(" 1
         font-lock-function-name-face)

        ;; highlight named arguments in a function call, e.g. foo(x=bar, y=baz)
        ("\\([(,]\\|[\n[:blank:]]*\\)\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*=[^=]"
         2 font-lock-reference-face)

        ;; highlight numbers
        ("\\(-?[0-9]*\\.?[0-9]*[eE]?-?[0-9]+[iL]?\\)" 1 font-lock-type-face)

        ;; crazy garbage to highlight operators
        ;; no I don't understand emacs regex escaping rules
        ("\\(\\$\\|\\@\\|\\!\\|\\%\\|\\^\\|\\&\\|\\*\\|\(\\|\)\\|\{\\|\}\\|\\[\\|\\]\\|\\-\\|\\+\\|\=\\|\\/\\|\<\\|\>\\|:\\|~\\)" 1 font-lock-builtin-face)

        ;; highlight S4 stuff
        ("\\(setMethod\\|setGeneric\\|setGroupGeneric\\|setClass\\|setRefClass\\|setReplaceMethod\\)" 1 font-lock-reference-face)

        ;; highlight packages called through ::, :::
        ("\\(\\w+\\):\\{2,3\\}" 1 font-lock-constant-face)

        ))
     ))

  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-case-fold-search nil)
 '(ahs-default-range (quote ahs-range-whole-buffer))
 '(ahs-idle-interval 0.25)
 '(ahs-idle-timer 0 t)
 '(ahs-inhibit-face-list nil)
 '(custom-safe-themes
   (quote
    ("0f0087ed1f27aaa8bd4c7e1910a02256facf075182e303adb33db23d1611864b" default)))
 '(ring-bell-function (quote ignore) t)
 '(safe-local-variable-values
   (quote
    ((c-indent-level . 4)
     (eval progn
           (c-set-offset
            (quote innamespace)
            (quote 0))
           (c-set-offset
            (quote inline-open)
            (quote 0)))
     (indicate-empty-lines . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
