(setq default-input-method 'russian-computer)
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs environment settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set font
(add-to-list 'default-frame-alist '(font . "-outline-Courier New-normal-r-normal-normal-16-138-120-120-c-*-iso8859-1"))
;; (add-to-list 'default-frame-alist '(font . "-outline-Courier New-normal-r-normal-normal-16-138-120-120-p-*-iso8859-1"))
;; Set preferred coding system
(prefer-coding-system 'cp1251)
;; Set encoding for diary file
;;(modify-coding-system-alist 'file "\\diary\\'" 'utf-8)
;; Set encoding for file names
(setq file-name-coding-system 'cp1251)
(setq next-line-add-newlines t)
(w32-register-hot-key [(meta tab)])

;; Save editing sessions
(require 'desktop)
(desktop-save-mode 1)

;; Display current time in modeline
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-format "%R %Y-%m-%d l.ll")

;; Set default frame size
(add-to-list 'default-frame-alist '(height . 32))
(add-to-list 'default-frame-alist '(width . 80))
(set-frame-position (selected-frame) 60 0)

;; Set calendar's start week day
(setq calendar-week-start-day 1)

;; Set european calendar style
(setq european-calendar-style 't)
(setq calendar-latitude 56.45)
(setq calendar-longitude 37.36)
(setq calendar-location-name "Москва")


;; Remove "save history" promt for Eshell
(setq eshell-save-history-on-exit t)

;; Inhibit startup message
(setq inhibit-splash-screen t)

(put 'narrow-to-region 'disabled nil)

;; Настройки с сайта 
(setq custom-file "~/.emacs.d/.emacs-custom.el")
(load custom-file)

(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywere t)

(define-key global-map (kbd "RET") 'newline-and-indent)


(defvar smart-use-extended-syntax nil
  "If t the smart symbol functionality will consider extended
syntax in finding matches, if such matches exist.")
 
(defvar smart-last-symbol-name ""
  "Contains the current symbol name.
 
This is only refreshed when `last-command' does not contain
either `smart-symbol-go-forward' or `smart-symbol-go-backward'")
 
(make-local-variable 'smart-use-extended-syntax)
 
(defvar smart-symbol-old-pt nil
  "Contains the location of the old point")
 
(defun smart-symbol-goto (name direction)
  "Jumps to the next NAME in DIRECTION in the current buffer.
 
DIRECTION must be either `forward' or `backward'; no other option
is valid."
 
  ;; if `last-command' did not contain
  ;; `smart-symbol-go-forward/backward' then we assume it's a
  ;; brand-new command and we re-set the search term.
  (unless (memq last-command '(smart-symbol-go-forward
                               smart-symbol-go-backward))
    (setq smart-last-symbol-name name))
  (setq smart-symbol-old-pt (point))
  (message (format "%s scan for symbol \"%s\""
                   (capitalize (symbol-name direction))
                   smart-last-symbol-name))
  (unless (catch 'done
            (while (funcall (cond
                             ((eq direction 'forward) ; forward
                              'search-forward)
                             ((eq direction 'backward) ; backward
                              'search-backward)
                             (t (error "Invalid direction"))) ; all others
                            smart-last-symbol-name nil t)
              (unless (memq (syntax-ppss-context
                             (syntax-ppss (point))) '(string comment))
                (throw 'done t))))
    (goto-char smart-symbol-old-pt)))
 
(defun smart-symbol-go-forward ()
  "Jumps forward to the next symbol at point"
  (interactive)
  (smart-symbol-goto (smart-symbol-at-pt 'end) 'forward))
 
(defun smart-symbol-go-backward ()
  "Jumps backward to the previous symbol at point"
  (interactive)
  (smart-symbol-goto (smart-symbol-at-pt 'beginning) 'backward))
 
(defun smart-symbol-at-pt (&optional dir)
  "Returns the symbol at point and moves point to DIR (either `beginning' or `end') of the symbol.
 
If `smart-use-extended-syntax' is t then that symbol is returned
instead."
  (with-syntax-table (make-syntax-table)
    (if smart-use-extended-syntax
        (modify-syntax-entry ?. "w"))
    (modify-syntax-entry ?_ "w")
    (modify-syntax-entry ?- "w")
    ;; grab the word and return it
    (let ((word (thing-at-point 'word))
          (bounds (bounds-of-thing-at-point 'word)))
      (if word
          (progn
            (cond
             ((eq dir 'beginning) (goto-char (car bounds)))
             ((eq dir 'end) (goto-char (cdr bounds)))
             (t (error "Invalid direction")))
            word)
        (error "No symbol found")))))
 
(global-set-key (kbd "M-n") 'smart-symbol-go-forward)
(global-set-key (kbd "M-p") 'smart-symbol-go-backward)

;;;;end of snippet







;; (require 'dired+)


;; following lines are always needed.  Choose your own keys.
;;(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; not needed since Emacs 22.2
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(setq org-default-notes-file "~/org/notes.org")
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)



;; use more repositories for elpa
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/"))) 

(server-start)

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'auto-complete-mode)

(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'auto-complete-mode)
;; (add-hook 'clojure-mode-hook 'ac-cider-compliment-setup)
;; (add-hook 'cider-repl-mode-hook 'ac-cider-compliment-repl-setup)

(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))
(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))
;; (add-hook 'nrepl-mode-hook 'paredit-mode)
;; (add-hook 'nrepl-mode-hook 'auto-complete-mode)
;; (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(define-key ctl-x-map   "d" 'diredp-dired-files)
(define-key ctl-x-4-map "d" 'diredp-dired-files-other-window)

(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes 
                 '("\\.zip\\'" ".zip" "unzip";; C:\\Program Files\\7-Zip\\7zFM.exe"
)))




