;; Configurations affecting the aesthetics of my emacs
;; ====================================================


;; Scrolls way too fast on my mac

(when (eq system-type 'darwin)
  (setq mouse-wheel-scroll-amount '(0.01)))


;; Parentheses setup

(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers ...

(show-paren-mode 1)
(setq show-paren-delay 0)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(paren-blinking "t" t)
 '(paren-matching t t))

;; How to show the matching offscreen paren (line shown in minibuffer)

(defadvice show-paren-function
  (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
  (interactive)
  (let* ((cb (char-before (point)))
	 (matching-text (and cb
			     (char-equal (char-syntax cb) ?\) )
			     (blink-matching-open))))
    (when matching-text (message matching-text))))


;; Tabs are evil?
;; Use spaces instead of tabs for indentation.

(setq indent-tabs-mode nil) 


;; Turn on syntax-highlighting.

(global-font-lock-mode t)
(load-library "font-lock")
(setq font-lock-maximum-decoration t)


;; Align regular expessions - useful for aligning inline comments

(global-set-key (kbd "C-x a r") 'align-regexp)


;; Some more interface changes

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(quack-pltish-comment-face ((((class color) (background dark)) (:slant italic)))) ;; Scheme specific
 '(border ((t (:width condensed))))
 '(fringe ((t (:width condensed)))))


;; Use linum for fancy line numbers

(require 'linum)
;; (setq linum-format "%d ")
(global-linum-mode 0)
;; (set-face-attribute 'linum nil :background "#2d2d2d")

;; Add this hook to modes where you don't want line numbers
;; Currently used for org-mode
(defun nolinum ()
  (global-linum-mode 0))


;; Fonts

;; (set-default-font "inconsolata-11")
;; (set-default-font "apple-monaco-11")
;; (set-default-font "dejavu-sans-mono-11")
;; (set-default-font "consolas-12")
;; (set-default-font "anonymous-pro-15")
;; (set-default-font "menlo-11")
;; (set-face-attribute 'default nil
;; 		    :family "Consolas" :height 160 :weight 'normal)
;; (set-face-attribute 'default nil
;; 		    :family "monaco" :height 185 :weight 'normal)
;; (set-face-attribute 'default nil :height 155)

;; Font size

;; (set-face-attribute 'default nil :height 120)


;; Transparency
;; Syntax:  (set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))

(set-frame-parameter (selected-frame) 'alpha '(100 83))
(add-to-list 'default-frame-alist '(alpha 100 83))


;; Things I need and don't need

(setq inhibit-startup-message 1)
(line-number-mode 1)
(column-number-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; (fringe-mode -1)
;; (set-fringe-mode '(1 . 0))


;; Color Themes

(when (and (>= emacs-major-version 24) (display-graphic-p))
  (add-to-list 'custom-theme-load-path "~/emacs/themes/")
  (add-to-list 'custom-theme-load-path "~/emacs/themes/soothe_theme/")
  ;; (load-theme 'misterioso t)
  ;; (load-theme 'zenburn t)
  ;; (load-theme 'wombat t)
  ;; (load-theme 'tango-dark t)
  ;; (load-theme 'tango-2 t)
  (load-theme 'monokai t)
  ;; (load-theme 'tomorrow t)
  ;; (load-theme 'tomorrow-night t)
  ;; (load-theme 'tomorrow-night-eighties t)
  ;; (load-theme 'soothe t)
  ;; (load-theme 'ample-zen t)
  ;; (load-theme 'gruber-darker t)
  ;; (load-theme 'assemblage t)
  ;; (load-theme 'bubbleberry t)
  ;; (load-theme 'clues t)
  ;; (load-theme 'deep-thought t)
  ;; (load-theme 'heroku t)
  ;; (load-theme 'jujube t)
  ;; (load-theme 'late-night t)
  ;; (load-theme 'nzenburn t)
  ;; (load-theme 'pastels-on-dark t)
  ;; (load-theme 'sea-before-storm t)
  ;; (load-theme 'subatomic-enhanced t)
  ;; (load-theme 'solarized-light t)
  ;; (load-theme 'twilight t)
  ;; (load-theme 'waher t)
  ;; (load-theme 'zen-and-art t)
  )


;; Fullscreen

;; For now, toggle-fullscreen is used only for Emacs v. 24.3._
;; UPDATE (August 20,2014):: Using 24.3 on the white Mac,
;; and the kbd for "M-RET" is ns-toggle-fullscreen for this version too (see below)

;; (defun toggle-fullscreen ()
;;   "Toggle full screen"
;;   (interactive)
;;   (when window-system
;;     (set-frame-parameter
;;      nil 'fullscreen
;;      (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

;; Fullscreen Keybindings

(when (eq emacs-major-version 24)
  (case emacs-minor-version
    (2 (global-set-key (kbd "M-RET") 'ns-toggle-fullscreen))
    (3 (global-set-key (kbd "M-RET") 'toggle-frame-fullscreen))))

(when (and (eq system-type 'darwin)
	   (equal user-login-name "pravnar"))
  (setq mac-command-modifier 'super)
  (global-set-key (kbd "<s-return>") 'toggle-frame-fullscreen))



;; Powerline

;; (require 'powerline)



;; Window management (windows in emacs terminology)

(when (not (eq system-type 'darwin))
  (global-set-key [M-left] 'windmove-left)          ; move to left window
  (global-set-key [M-right] 'windmove-right)        ; move to right window
  (global-set-key [M-up] 'windmove-up)              ; move to upper window
  (global-set-key [M-down] 'windmove-down))         ; move to downer window


;; exec-path-from-shell

;; https://github.com/purcell/exec-path-from-shell

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
