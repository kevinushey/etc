;;; -*- lexical-binding: t -*-
(require 'cl)

;; cram it, magit
(setq magit-last-seen-setup-instructions "1.4.0")

;; disable all of the GUI junk
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; lol emacs
(setq inhibit-default-init t)

;; don't warn about symlinks
(setq vc-follow-symlinks t)

;; list the packages you want
;; I originally wanted this in alphabetical order, but order matters
;; since we don't resolve dependency ordering. *sad face*
(setq package-list '(ag
                      ace-jump-mode
                      auto-complete
                      autopair
                      clang-format
                      company
                      company-irony
                      ess
                      evil
                      evil-leader
                      evil-surround
                      expand-region
                      flx
                      flx-ido
                      flycheck
                      go-autocomplete
                      go-mode
                      company-go
                      grizzl
                      helm
                      ido-vertical-mode
                      iedit
                      imenu-anywhere
                      irony
                      js2-mode
                      key-chord
                      magit
                      markdown-mode
                      powerline
                      powerline-evil
                      projectile
                      rainbow-mode
                      rainbow-delimiters
                      rtags
                      smex
                      tern
                      tern-auto-complete
                      web-mode
                      yasnippet)
      )

;; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; re-initialize
(package-initialize)

(defadvice desktop-restore-file-buffer
    (around my-desktop-restore-file-buffer-advice)
  "Be non-interactive while starting a daemon."
  (if (and (daemonp)
           (not server-process))
      (let ((noninteractive t))
        ad-do-it)
    ad-do-it))
(ad-activate 'desktop-restore-file-buffer)

;; because powerline doesn't work with srgb (on Mac)...
(setq ns-use-srgb-colorspace nil)

;; who am i? used for C-x a; updated to ChangeLog
(setq user-mail-address (getenv "EMAIL"))
(setq user-full-name (getenv "NAME"))

;; font
;; (set-face-attribute 'default nil :font "Droid Sans Mono")
;; (set-frame-font "Droid Sans Mono" nil t)

;; basics
(setq-default indent-tabs-mode nil)
;; (add-hook 'before-save-hook 'delete-trailing-whitespace) ;; too intrusive
(setq show-paren-delay 0)
(show-paren-mode)

;; dim other windows
(add-hook 'after-init-hook (lambda ()
                             (when (fboundp 'auto-dim-other-buffers-mode)
                               (auto-dim-other-buffers-mode t))))

;; autosave things
(require 'saveplace)
(setq-default save-place t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((setq js2-basic-offset 3)
     (eval progn
           (c-set-offset
            (quote innamespace)
            (quote 0))
           (c-set-offset
            (quote inline-open)
            (quote 0)))
     (indicate-empty-lines . t))))
 '(speedbar-show-unknown-files t))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; packages in ~/.emacs.d
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path)
  )

;; Magit
(require 'magit)

;; Silver Searcher
(require 'ag)
(setq ag-highlight-search t)

(require 'ido-vertical-mode)
(ido-vertical-mode)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; less aggressive garbage collector
(setq gc-cons-threshold 20000000)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; a customized wombat theme -- a bit more like Tomorrow Night
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'wombat t)

;; imenu-anywhere
(require 'imenu-anywhere)
(require 'helm)
(global-set-key (kbd "s-.") 'helm-imenu-anywhere)

;; rainbow mode -- color colors like black, white, red, #ABCDEF...
(require 'rainbow-mode)
(define-globalized-minor-mode my-global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))
(my-global-rainbow-mode 1)

;; rainbow delimiters -- colorize parens
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'ess-mode-hook #'rainbow-delimiters-mode)

(custom-set-faces
 '(rainbow-delimiters-depth-1-face ((t (:weight bold :foreground "#70c0b1"))))
 '(rainbow-delimiters-depth-2-face ((t (:weight bold :foreground "#e7c545"))))
 '(rainbow-delimiters-depth-3-face ((t (:weight bold :foreground "#b9ca4a"))))
 '(rainbow-delimiters-depth-4-face ((t (:weight bold :foreground "#d54e53"))))
 '(rainbow-delimiters-depth-5-face ((t (:weight bold :foreground "#c397d8"))))
 '(rainbow-delimiters-depth-6-face ((t (:weight bold :foreground "#70c0b1"))))
 '(rainbow-delimiters-depth-7-face ((t (:weight bold :foreground "#e7c545"))))
 '(rainbow-delimiters-depth-8-face ((t (:weight bold :foreground "#b9ca4a"))))
 '(rainbow-delimiters-depth-9-face ((t (:weight bold :foreground "#d54e53"))))
 '(rainbow-delimiters-unmatched-face ((t (:weight bold :foreground "red"))))

 '(show-paren-match ((((class color) (background light)) (:background "azure2")))))

;; automatically generate matching characters for (, {, ", etc...
(require 'autopair)
(autopair-global-mode 1)
;; (require 'smartparens)
;; (smartparens-global-mode 1)

;; syntax coloring
(global-font-lock-mode 1)

;; line numbers
(require 'linum)
(global-linum-mode 1)

;; column number in the 'powerline' bar
(column-number-mode 1)

;; backtab should unindent
(global-set-key (kbd "<S-tab>") 'evil-shift-left-line)

;; I don't like the bell
(setq ring-bell-function 'ignore)

;; use powerline
(require 'powerline)
(require 'powerline-evil)
(powerline-evil-center-color-theme)

;; when would I not want to indent after hitting enter?
(define-key global-map (kbd "RET") 'newline-and-indent)

;; some project management packages
(require 'projectile)
(require 'grizzl)
(setq projectile-enable-caching t)
(projectile-global-mode)

(add-hook 'find-file-hook
          (lambda ()
            (let ((dir (projectile-root-bottom-up (buffer-file-name))))
              (if (not (equal dir nil))
                  (projectile-add-known-project dir)))))

;; let left, right wrap around
(setq-default evil-cross-lines t)

(require 'clang-format)
(add-hook 'c-mode-hook (lambda ()
                         (setq clang-format-style "Chromium"
                               )))

(add-hook 'c++-mode-hook (lambda ()
                           (setq clang-format-style "Chromium"
                                 )))

;; Evil leader key
(require 'evil-leader)
(global-evil-leader-mode)

(defun my-comment-dwim ()
  (interactive)
  (comment-dwim nil)
  (if (equal evil-state 'normal)
      (progn
	(evil-append-line nil)
	(insert " ")
	)
    )
  )

;; Some utility bindings for evil
(define-key evil-visual-state-map (kbd "DEL") 'evil-delete)

;; bind 'v', 'V' to expand / contract region when used within
;; visual mode
(define-key evil-visual-state-map (kbd "v")
  (lambda ()
    (interactive)
    (er/expand-region 1)))

(define-key evil-visual-state-map (kbd "V")
  (lambda ()
    (interactive)
    (er/expand-region -1)))

;; use '<', '>' to indent / outdent
(define-key evil-visual-state-map (kbd "<")
  (lambda ()
    (interactive)
    (evil-shift-left (region-beginning) (region-end))
    (evil-normal-state)
    (evil-visual-restore)))

(define-key evil-visual-state-map (kbd ">")
  (lambda ()
    (interactive)
    (evil-shift-right (region-beginning) (region-end))
    (evil-normal-state)
    (evil-visual-restore)))

;; flips between vertical and horizontal split
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

;; sets up a 4-panel layout
(defun four-panel-layout ()
  (interactive)
  (delete-other-windows)
  (split-window-below)
  (split-window-right)
  (evil-window-down 1)
  (split-window-right)
  (evil-window-up 1)
  )

(defun transpose-windows ()         ; Stephen Gildea
  "*Swap the positions of this window and the next one."
  (interactive)
  (let ((other-window (next-window (selected-window) 'no-minibuf)))
    (let ((other-window-buffer (window-buffer other-window))
          (other-window-hscroll (window-hscroll other-window))
          (other-window-point (window-point other-window))
          (other-window-start (window-start other-window)))
      (set-window-buffer other-window (current-buffer))
      (set-window-hscroll other-window (window-hscroll (selected-window)))
      (set-window-point other-window (point))
      (set-window-start other-window (window-start (selected-window)))
      (set-window-buffer (selected-window) other-window-buffer)
      (set-window-hscroll (selected-window) other-window-hscroll)
      (set-window-point (selected-window) other-window-point)
      (set-window-start (selected-window) other-window-start))
    (select-window other-window)))

(defun Rcpp-source-cpp ()
  (interactive)
  (shell-command
   (concat "R --vanilla -e \"Rcpp::sourceCpp('" (buffer-file-name) "')\" &")
   )
  )

(add-hook 'shell-mode-hook (lambda ()
                             (insert "source ~/.bash_profile")
                             (comint-send-input)
                             ))

(defun shell-in-new-buffer ()
  (interactive)
  (split-window-below)
  (evil-window-down 1)
  (shell)
  )

;; font sizes
(set-face-attribute 'default nil :height (+ (face-attribute 'default :height) 40))

(global-set-key (kbd "s-=")
                (lambda ()
                  (interactive)
                  (let ((old-face-attribute (face-attribute 'default :height)))
                    (set-face-attribute 'default nil :height (+ old-face-attribute 10)))))

(global-set-key (kbd "s--")
                (lambda ()
                  (interactive)
                  (let ((old-face-attribute (face-attribute 'default :height)))
                    (set-face-attribute 'default nil :height (- old-face-attribute 10)))))

(defun R-cmd-install ()
  (interactive)
  (shell-command
   (concat "R CMD INSTALL --preclean " (projectile-project-root))
   )
  )

;; key-chord mode is used so 'jk' can go from
;; insert to normal state
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

(defun evil-join-comma ()
  (interactive)
  (save-excursion
    (when (eq (region-beginning) (point))
      (exchange-point-and-mark)
      )
    (previous-line)
    (replace-regexp "$" ", " nil (region-beginning) (region-end))
    (evil-visual-restore)
    (when (eq (region-beginning) (point))
      (exchange-point-and-mark)
      )
    (previous-line)
    )
  )

;; space is now your leader
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key

  ;; shell
  "ss" 'shell-in-new-buffer

  ;; projectile navigation
  "ad" 'ag-project-dired
  "af" 'ag-project

  ;; help
  "hk" 'describe-key
  "hb" 'describe-bindings
  "hf" 'describe-function
  "hv" 'describe-variable
  "hm" 'describe-mode

  ;; projectile
  "pd" 'projectile-find-dir
  "pf" 'projectile-find-file
  "pl" 'projectile-find-file-in-directory
  "ps" 'projectile-switch-project
  "pa" 'projectile-ag
  "pn" 'projectile-add-known-project ;; you would not believe how long it took to find this
  "pg" 'projectile-grep
  "ph" 'helm-projectile

  ;; ace-jump
  "jj" 'evil-ace-jump-char-mode
  "jl" 'evil-ace-jump-line-mode
  "jw" 'evil-ace-jump-word-mode

  ;; window stuff
  "ws" 'evil-window-split
  "ww" 'evil-window-next
  "wq" 'evil-window-delete
  "wv" 'evil-window-vsplit
  "wc" 'evil-window-delete
  "wd" 'evil-window-delete ;; because c = close, d = delete, whatever ok
  "wf" 'toggle-window-split ;; f for flip
  "wt" 'transpose-windows
  "w4" 'four-panel-layout

  "w <up>" 'evil-window-up
  "wk" 'evil-window-up
  "w <down>" 'evil-window-down
  "wj" 'evil-window-down
  "w <left>" 'evil-window-left
  "wh" 'evil-window-left
  "w <right>" 'evil-window-right
  "wl" 'evil-window-right

  "w <S-up>" 'evil-window-move-very-top
  "w <S-k>" 'evil-window-move-very-top
  "w <S-left>" 'evil-window-move-far-left
  "w <S-h>" 'evil-window-move-far-left
  "w <S-right>" 'evil-window-move-far-right
  "w <S-l>" 'evil-window-move-far-right
  "w <S-down>" 'evil-window-move-very-bottom
  "w <S-j>" 'evil-window-move-very-bottom

  "wo" 'delete-other-windows

  ;; R, Rcpp
  "rs" 'Rcpp-source-cpp
  "rci" 'R-cmd-install

  ;; go
  "ga" 'go-import-add
  "gi" 'go-install
  "gt" 'go-test
  "gd" 'godoc-at-point
  "gf" 'godef-jump-other-window

  ;; magit
  "ms" 'magit-status

  ;; misc
  "xf" 'dired
  ";" 'my-comment-dwim
  ":" 'eval-expression
  "." 'evil-shift-right-line
  "," 'evil-shift-left-line
  "'" 'iedit-mode
  "\"" 'iedit-dwim
  "cb" 'irony-cdb-menu
  "=" (lambda ()
	(interactive)
	(indent-region (point-min) (point-max)))
  "cf" 'clang-format-region

  "ar" 'align-regexp

  )

(defun iedit-dwim (arg)
  (interactive "P")
  (if arg
      (iedit-mode)
    (save-excursion
      (save-restriction
        (widen)
        (if iedit-mode
            (iedit-done)
          (narrow-to-defun)
          (iedit-start (current-word) (point-min) (point-max)))))))

;; Apparently I need this for C-u
;; TODO: Why doesn't this work anymore?
;; (setq evil-want-C-u-scroll t)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))

;; evil mode!
(require 'evil)
(setq evil-move-cursor-back nil)

;; evil-surround!
(require 'evil-surround)
(global-evil-surround-mode 1)

;; define my own text objects
;; see: http://stackoverflow.com/questions/18102004/emacs-evil-mode-how-to-create-a-new-text-object-to-select-words-with-any-non-sp

;; text object -- up to either whitespace character or paren
(let ((start-regex "[[:space:]\\(\\)]")
      (end-regex "[[:space:]\\(\\)]\\|$"))
  (progn
     (evil-define-text-object inner-name (count &optional beg end type)
       (evil-select-paren start-regex end-regex beg end type count nil))
     (define-key evil-inner-text-objects-map "k" 'inner-name)

     (evil-define-text-object outer-name (count &optional beg end type)
       (evil-select-paren start-regex end-regex beg end type count t))
     (define-key evil-outer-text-objects-map "k" 'outer-name)))
  
;; having space, ret work nicely within evil
(defun my-move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))

(my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
(my-move-key evil-motion-state-map evil-normal-state-map " ")

;;; C-c as general purpose escape key sequence.
(defun my-esc (prompt)
  "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
  (cond
   ;; If we're in one of the Evil states that defines [escape] key, return [escape] so as
   ;; Key Lookup will use it.
   ((or (evil-insert-state-p) (evil-normal-state-p) (evil-replace-state-p) (evil-visual-state-p)) [escape])
   ;; This is the best way I could infer for now to have C-c work during evil-read-key.
   ;; Note: As long as I return [escape] in normal-state, I don't need this.
   ;;((eq overriding-terminal-local-map evil-read-key-map) (keyboard-quit) (kbd ""))
   (t (kbd "C-g"))))

(define-key key-translation-map (kbd "C-c") 'my-esc)
;; Works around the fact that Evil uses read-event directly when in operator state, which
;; doesn't use the key-translation-map.
(define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)
;; Not sure what behavior this changes, but might as well set it, seeing the Elisp manual's
;; documentation of it.
(if (display-graphic-p)
    (progn
      (set-quit-char "C-c")
      ))

;; evil gives us vim keybindings
(evil-mode 1)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; acejump
(require 'ace-jump-mode)
(global-set-key (kbd "C-,") 'ace-jump-mode)

;; company-mode
(require 'company)
(add-hook 'c-mode-common-hook (lambda ()
                                (company-mode)
                                (local-set-key (kbd "C-SPC") 'company-complete)
                                ))

(require 'auto-complete-config)
(defun my-acc-mode-setup ()
  (setq ac-sources
        (append
         '(
           ac-source-yasnippet
           ac-source-filename
           )
         ac-sources)))

(setq
 ac-candidate-limit nil
 ac-delay 0.3
 ac-ignore-case 'smart
 ac-menu-height 10
 ac-quick-help-delay 0.3
 ac-use-quick-help t
 )
(ac-config-default)

(setq ac-sources (append ac-sources 'ac-source-filename))
(setq ac-disable-faces nil)

(require 'go-mode)

;; default colors stink
(require 'color)

(let ((bg (face-attribute 'default :background)))
  (custom-set-faces
   `(company-tooltip ((t :background "lightgray" :foreground "black")))
   `(company-tooltip-selection ((t :background "steelblue" :foreground "white")))
   `(company-tooltip-mouse ((t :background "blue" :foreground "white")))
   `(company-tooltip-common ((t :background "lightgray" :foreground "black")))
   `(company-tooltip-common-selection ((t t :background "lightgray" :foreground "black")))
   ; `(company-tooltip-annotation ((t :background "" :foreground "")))
   `(company-scrollbar-fg ((t :background "black")))
   `(company-scrollbar-bg ((t :background "gray")))
   `(company-preview ((t :background nil :foreround "darkgray")))
   `(company-preview-common ((t :background nil :foreground "darkgray")))
   ; `(company-preview-search ((t :background "" :foreground ""))) 
   )
  )

(add-hook 'lisp-mode-hook (lambda ()
                            (company-mode)
                            (local-set-key (kbd "C-SPC") 'company-complete)))

;; company-irony
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(add-hook 'c++-mode-hook (lambda ()
                           (irony-mode)
                           (irony-cdb--try-load-clang-complete)))
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)

;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

;; ;; getting R, Rcpp into the mix
;; (add-hook
;;  'c++-mode-hook
;;  (lambda ()
;;    (setq ac-clang-flags
;;          '(
;;            "-std=c++11"
;;            "-g"
;;            "-O3"
;;            "-I/usr/local/llvm/include"
;;            "-I/Library/Frameworks/R.framework/Resources/include"
;;            "-I/Users/kevinushey/git/Rcpp/inst/include"
;;            "-I/Users/kevinushey/git/RcppArmadillo/inst/include"
;;            ))
;;    ))
;; (add-hook
;;  'c-mode-hook
;;  (lambda ()
;;    (setq ac-clang-flags
;;          '(
;;            "-std=gnu99"
;;            "-g"
;;            "-O3"
;;            "-I/usr/local/llvm/include"
;;            "-I/Library/Frameworks/R.framework/Resources/include"
;;            ))
;;    ))

;; navigating buffers
(global-set-key (kbd "<M-s-left>") 'previous-buffer)
(global-set-key (kbd "<M-s-right>") 'next-buffer)

;; navigating windows
(global-set-key (kbd "<M-s-up>") 'previous-multiframe-window)
(global-set-key (kbd "<M-s-down>") 'other-window)

;; changing window sizes
(global-set-key (kbd "<S-s-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<S-s-right>") 'enlarge-window-horizontally)
(global-set-key (kbd "<S-s-down>") 'shrink-window)
(global-set-key (kbd "<S-s-up>") 'enlarge-window)

;; C, C++

;; Highlight numbers, as per
;; http://stackoverflow.com/questions/8860050/emacs-c-mode-how-do-you-syntax-highlight-hex-numbers
(setq c-number-regex
      '(
        ;; Valid hex number (will highlight invalid suffix though)
        ("\\b0x[[:xdigit:]]+[uUlL]*\\b" . font-lock-string-face)

        ;; Invalid hex number
        ("\\b0x\\(\\w\\|\\.\\)+\\b" . font-lock-warning-face)

        ;; Valid floating point number.
        ("\\(\\b[0-9]+\\|\\)\\(\\.\\)\\([0-9]+\\(e[-]?[0-9]+\\)?\\([lL]?\\|[dD]?[fF]?\\)\\)\\b" (1 font-lock-string-face) (3 font-lock-string-face))

        ;; Invalid floating point number.  Must be before valid decimal.
        ("\\b[0-9].*?\\..+?\\b" . font-lock-warning-face)

        ;; Valid decimal number.  Must be before octal regexes otherwise 0 and 0l
        ;; will be highlighted as errors.  Will highlight invalid suffix though.
        ("\\b\\(\\(0\\|[1-9][0-9]*\\)[uUlL]*\\)\\b" 1 font-lock-string-face)

        ;; Valid octal number
        ("\\b0[0-7]+[uUlL]*\\b" . font-lock-string-face)

        ;; Floating point number with no digits after the period.  This must be
        ;; after the invalid numbers, otherwise it will "steal" some invalid
        ;; numbers and highlight them as valid.
        ("\\b\\([0-9]+\\)\\." (1 font-lock-string-face))

        ;; Invalid number.  Must be last so it only highlights anything not
        ;; matched above.
        ("\\b[0-9]\\(\\w\\|\\.\\)+?\\b" . font-lock-warning-face)
        ))

(setq c-operators-regex
      '(
        ("\\(\\$\\|\\@\\|\\!\\|\\%\\|\\^\\|\\&\\|\\*\\|\(\\|\)\\|\{\\|\}\\|\\[\\|\\]\\|\\-\\|\\+\\|\=\\|\\/\\|\<\\|\>\\|:\\|~\\)" 1 font-lock-builtin-face)
        )
      )

(add-hook
 'c-mode-common-hook
 (lambda ()
   (font-lock-add-keywords nil c-number-regex)
   (font-lock-add-keywords nil c-operators-regex)
   )
 )

;; getting indentation right
(defun my-c-common-hook ()
  (progn
    (c-add-style
     "mine"
     '("java"
       (c-basic-offset . 4)
       (c-hanging-braces-alist
        ((substatement-open)
         (statement-block-intro . +)
         (block-close . c-snug-do-while)
         (extern-lang-open after)
         (inexpr-class-open after)
         (inexpr-class-close before)))
       (c-offsets-alist
        (substatement-open . 0))
       ))
    (setq c-default-style "mine")
    (c-set-style "mine")
    ))

;; Getting argument continuation right -- don't do vertical
;; alignment unless there has been at least one argument passed
;; / declared in a function on the same line
(c-set-offset 'arglist-intro '+)
(c-set-offset 'arglist-cont 0)
(c-set-offset 'arglist-close 0)
(c-set-offset 'substatement-open 0)

;; Don't indent within extern "C" { ... } blocks
(c-set-offset 'inextern-lang 0)

;; Indent header files in C++ mode by default
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Don't indent namespaces
(c-set-offset 'innamespace 0)

;; indenting C++ templates right
(defun c++-template-args-cont (langelem)
  "Control indentation of template parameters handling the special case of '>'.
Possible Values:
0   : The first non-ws character is '>'. Line it up under 'template'.
nil : Otherwise, return nil and run next lineup function."
  (save-excursion
    (beginning-of-line)
    (if (re-search-forward "^[\t ]*>" (line-end-position) t)
        0)))

(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-offset 'template-args-cont
                          '(c++-template-args-cont c-lineup-template-args +))))

;; rtags
(require 'rtags)

;; yasnippet for snippet completion
(require 'yasnippet) ;; not yasnippet-bundle
(yas-reload-all)

(add-hook 'prog-mode-hook
          (lambda ()
            (yas-minor-mode)))

(defun in-R-package-dir ()
  (file-exists-p
   (concat (projectile-project-root) "DESCRIPTION")
   )
  )


(defun get-R-flycheck-include-dirs ()
  (let ((root-dir (projectile-project-root)))
    (list
     (concat root-dir "src")
     (concat root-dir "inst/include")
     "/Library/Frameworks/R.framework/Resources/include"
     (expand-file-name "~/git/Rcpp/inst/include")
     (expand-file-name "~/git/RcppArmadillo/inst/include")

     )
    )
  )

(require 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)
(add-hook 'c++-mode-hook
          (lambda ()
            (flycheck-set-checker-executable
             'c/c++-clang
             "/usr/local/llvm/bin/clang++")
            (setq flycheck-clang-language-standard "c++11")
            (setq flycheck-clang-warnings '("all")) ; too many errors with extra
            (setq flycheck-clang-include-path
                  (get-R-flycheck-include-dirs))
            ))

(add-hook 'c-mode-hook
          (lambda ()
            (flycheck-set-checker-executable
             'c/c++-clang
             "/usr/local/llvm/bin/clang")
            (when (in-R-package-dir)
              (setq flycheck-clang-language-standard "gnu99")
              (setq flycheck-clang-warnings '("all"))
              (setq flycheck-clang-include-path
                    (list
                     (concat (projectile-project-root) "src")
                     (concat (projectile-project-root) "inst/include")
                     "/Library/Frameworks/R.framework/Resources/include"
                     "/usr/local/include"
                     )
                    )
              )
            )
          )

;; add irony-mode for autocompletion
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/irony-mode/elisp/"))
;; (setenv "LD_LIBRARY_PATH" "/usr/local/llvm/lib")
;; (require 'irony)
;;
;; ;; enable ac plugin
;; (irony-enable 'ac)
;;
;; ;; define a function that enables irony-mode for C, C++ modes
;; (defun my:irony-enable ()
;;   (yas/minor-mode-on)
;;   (auto-complete-mode 1)
;;   (when (member major-mode irony-known-modes)
;;     (irony-mode 1)))
;;
;; (add-hook
;;  'c++-mode-hook
;;  (lambda ()
;;    (my:irony-enable)
;;    (setq irony-compile-flags
;;          (list
;;           "-std=c++11"
;;           "-I/usr/local/include"
;;           "-I/Library/Frameworks/R.framework/Resources/include"
;;           (expand-file-name "~/git/Rcpp/inst/include")
;;           (expand-file-name "~/git/RcppArmadillo/inst/include")
;;           ))
;;    )
;;  )
;;
;; (add-hook
;;  'c-mode-hook
;;  (lambda ()
;;    (my:irony-enable)
;;    (setq irony-compile-flags
;;          (list
;;           "-std=gnu99"
;;           "-I/usr/local/include"
;;           "-I/Library/Frameworks/R.framework/Resources/include"
;;           ))
;;    )
;;  )

;; ESS
(require 'ess)
(require 'ess-site)
(setq ess-ac-R-argument-suffix " = ")
(setq ess-use-auto-complete t)
(add-hook 'ess-mode-hook
          (lambda ()
            (local-set-key (kbd "<s-return>") 'ess-eval-region-or-line-and-step)
            (show-paren-mode t)
            (setq ess-indent-level 2)
            (setq ess-first-continued-statement-offset 2)
            (setq ess-continued-statement-offset 0)
            (setq ess-arg-function-offset 2)
            (setq ess-arg-function-offset-new-line 2)
            (setq ess-dont-vertically-align-closing-paren t)
            ))
(ess-toggle-underscore nil)

;; Generate a regex that handles highlighting for operators
;; this doesn't work perfectly due to inconsistent escaping
;; the stuff you see below was hand-generated
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
(add-hook 'ess-mode-hook
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

;; rmd mode
(defun rmd-mode ()
  "ESS Markdown mode for rmd files"
  (interactive)
  (setq load-path
        (append (list "~/.emacs.d/polymode/" "~/.emacs.d/polymode/modes/")
                load-path))
  (require 'poly-R)
  (require 'poly-markdown)
  (poly-markdown+r-mode))

;; ipython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")

(setq py-python-command-args
      '("--qui=wx" "--pylab=wx" "-colors" "Linux")
      )
(setq py-force-py-shell-name-p t)
(setq py-switch-buffers-on-execute-p nil)
(setq py-smart-indentation t)

;; python
(add-hook 'python-mode-hook (lambda ()
                              (local-set-key (kbd "<s-return>") 'py-execute-region)
                              (local-set-key (kbd "<C-return>") 'py-execute-line)
                              ))

;; go
(require 'auto-complete-config)
(require 'go-autocomplete)
(add-hook 'go-mode-hook (lambda ()
                          (auto-complete-mode)
                          (local-set-key (kbd "C-SPC") 'ac-complete)))
(defun go-format-post-process ()
  (shell-command
   (concat "R --vanilla --slave -e \"source('~/go-format.R'); format('" (buffer-file-name) "');\"")))

(setq gofmt-command "goimports")
(add-hook
 'before-save-hook
 (lambda ()
   (when (eq major-mode 'go-mode)
     (progn
       (gofmt-before-save)
       (go-install)
       )
     )
   )
 )

;; (add-hook
;;  'after-save-hook
;;  (lambda ()
;;    (when (eq major-mode 'go-mode)
;;      (progn
;;        (go-format-post-process)
;;        (revert-buffer :ignore-auto :noconfirm)))))

(add-hook 'go-mode-hook
          (lambda ()
            (setq-default)
            (setq tab-width 2)
            (setq standard-indent 2)
            (setq indent-tabs-mode nil)))

(defun current-project-directory ()
  (interactive)
  (let ((project-directory (file-name-directory (buffer-file-name))))
    (while (and
            (not (member ".git" (directory-files project-directory)))
            (not (eq project-directory "/")))
      (setq project-directory (file-truename (concat project-directory "../")))
      )
    project-directory
    )
  )

(defun set-project-gopath ()
  (interactive)
  (setenv "GOPATH" (concat (current-project-directory) ":" (concat (current-project-directory) "_vendor/")))
  )

(defun make-project ()
  (interactive)
  (let ((current-working-directory (shell-command "pwd")))
    (shell-command (concat "cd " (current-project-directory)))
    (shell-command ("make &"))
    (shell-command (concat "cd " (current-working-directory)))
    )
  )

(defun go-install ()
  (interactive)
  (shell-command "go install")
  )

(defun go-test ()
  (interactive)
  (let ((old-go-path (getenv "GOPATH")))
    (progn
      (setenv "GOPATH" (current-project-directory))
      (shell-command "go test")
      (setenv "GOPATH" old-go-path))
    )
  )

(defun godef-jump-click ()
  (interactive)
  (godef-jump-other-window (posn-point (event-end last-input-event)))
  )

(add-hook
 'go-mode-hook
 (lambda ()
   (local-set-key
    (kbd "<s-mouse-1>")
    'godef-jump-click)
   (set-project-gopath)))

;;; JavaScript
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

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

(add-hook
 'js2-mode-hook
 (lambda ()
   (defadvice js2-indent-line (around js2-indent-line-around)
     "Don't indent if we're within a 'define' function."
     ad-do-it
     (let ((parse-status (save-excursion
                           (parse-partial-sexp (point-min) (point-at-bol))))
           positions)
       (push (current-column) positions)
       (require-def-deindent positions 0)))
   (ad-activate 'js2-indent-line)
   (setq electric-indent-chars nil)
   (flymake-mode t)
   (tern-mode t)))

(require 'tern)
(require 'tern-auto-complete)

(add-hook 'js-mode-hook (lambda ()
                          (tern-mode t)))

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;; web mode for HTML
(require 'web-mode)

(add-hook 'html-mode-hook (lambda()
                            (web-mode)
                            (setq web-mode-script-padding 0)
                            (setq web-mode-style-padding 0)
                            ))

;; disable flycheck in lisp mode. the only lisp file i ever edit is my
;; .emacs and it just fills it up with noise i don't care about
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (flycheck-mode -1)))

