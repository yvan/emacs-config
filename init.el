;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(magit . "melpa-stable") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; Define he following variables to remove the compile-log warnings
;; when defining ido-ubiquitous
;; (defvar ido-cur-item nil)
;; (defvar ido-default-item nil)
;; (defvar ido-cur-list nil)
;; (defvar predicate nil)
;; (defvar inherit-input-method nil)

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-completing-read+

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; add integration for janet
(load "janet-mode.el")
(load "ijanet.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("e6fb5f638e4fd2fa68325c95c382fc830f94439c508cc80ed0e462c5533497a7" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f"))))
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/project/orgm/cheat.org")))
 '(package-selected-packages
   (quote
    (haskell-mode railscasts-reloaded-theme spacemacs-theme ledger-mode org org-syncq py-autopep8 python-mode tagedit smex slime rainbow-delimiters projectile paredit magit ido-completing-read+ dracula-theme)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set magit C-x g binding
(global-set-key (kbd "C-x g") 'magit-status)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; org mode config
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROG" "WAITING" "DONE")))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; prevent minibuffer from becoming multiline
(setq resize-mini-windows nil)

;; stop splash screen
(setq inhibit-splash-screen t)

;; remove menu tool and scroll bar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; add line numbers to all open windows
(global-linum-mode)

;; set default browser to eww
(setq browse-url-browser-function 'eww-browse-url)

;; make default text size slightly smaller
(set-face-attribute 'default nil :height 130)

;; highight matching parens
(show-paren-mode 1)

;; set language to utf-8 by default
(set-language-environment "UTF-8")

;; turn off bell ringing
(setq ring-bell-function 'ignore)

;; backup setting
(setq
 backup-by-copying t
 backup-directory-alist
 '(("." . "~/saves"))
 auto-save-file-name-transforms
 `((".*" ,temporary-file-directory t))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

;; interactive do mode
(require 'ido)
(ido-mode t)

;; swap C-o anc C-x o
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-x o") 'open-line)

;; janet reply key bindings
(global-set-key (kbd "C-c C-p") 'ijanet)
(global-set-key (kbd "C-c C-b") 'ijanet-eval-buffer)
(global-set-key (kbd "C-c C-l") 'ijanet-eval-line)
(global-set-key (kbd "C-c C-r") 'ijanet-eval-region)

;; rebind some common functions for dealin w/ windows
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-0") 'delete-window)

;; rebind enter to do enter and indent
(global-set-key (kbd "<RET>") 'newline-and-indent)

;; setup slime
(load (expand-file-name "~/.roswell/lisp/quicklisp/slime-helper.el"))
(setf slime-lisp-implementations
      `((sbcl ("ros" "-Q" "-l" "~/.sbclrc" "-L" "sbcl" "run"))))
(setf slime-default-lisp 'sbcl)
(setq slime-net-coding-system 'utf-8-unix)

;; run our custom lisp function on startup
(defun lisp-hook-fn ()
  (interactive)
  ;; Start slime mode
  (slime-mode)
  ;; Some useful key-bindings
  (local-set-key [tab] 'slime-complete-symbol)
  (local-set-key (kbd "M-q") 'slime-reindent-defun)
  ;; We set the indent function. common-lisp-indent-function 
  ;; will indent our code the right way
  (set (make-local-variable lisp-indent-function) 'common-lisp-indent-function)
  ;; We tell slime to not load failed compiled code
  (setq slime-load-failed-fasl 'never))
(add-hook 'lisp-mode-hook 'lisp-hook-fn)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)

;; add key bindings to change ibuffer behavior to allow my new C-o
(defun ibuffer-hook-fn ()
  (interactive)
  (local-set-key (kbd "C-o") 'other-window)
  (local-set-key (kbd "C-x o") 'open-line))
(add-hook 'ibuffer-mode-hook 'ibuffer-hook-fn)
