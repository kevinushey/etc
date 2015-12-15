;; Shamelessly copied from: https://github.com/nikki93/spacemacs-private/blob/master/irony-mode/packages.el
(setq irony-packages
      '(
        irony
        company-irony
        flycheck-irony
        ))

;; List of packages to exclude.
(setq irony-excluded-packages '(auto-complete-clang))

(defun irony/irony-mode-hooks ()
  (define-key irony-mode-map [remap completion-at-point] 'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol] 'irony-completion-at-point-async)
  (irony-cdb-autosetup-compile-options))

(defun irony/init-irony ()
  (use-package irony
    :defer t
    :init
    (progn
      (add-hook 'c++-mode-hook 'irony-mode)
      (add-hook 'c-mode-hook 'irony-mode)
      (add-hook 'objc-mode-hook 'irony-mode)
      (add-hook 'irony-mode-hook 'irony/irony-mode-hooks))))

(defun irony/init-company-irony ()
  (use-package company-irony
    :defer t
    :init
    (progn
      (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))
      (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
      (add-hook 'irony-mode-hook 'company-mode))))

(defun irony/init-flycheck-irony ()
  (use-package flycheck-irony
    :defer t
    :init
    (progn
      (eval-after-load 'flycheck '(add-to-list 'flycheck-checkers 'irony))
      (add-hook 'irony-mode-hook 'flycheck-mode))))
