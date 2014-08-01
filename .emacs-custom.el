(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu t)
 '(ac-auto-start 1)
 '(ac-delay 0.01)
 '(ac-modes (quote (jabber-chat-mode octave-mode emacs-lisp-mode lisp-interaction-mode c-mode cc-mode c++-mode java-mode clojure-mode scala-mode scheme-mode ocaml-mode tuareg-mode perl-mode cperl-mode python-mode ruby-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode)))
 '(ac-use-fuzzy t)
 '(completion-auto-help (quote lazy))
 '(conkeror-file-path "d:\\Program Files (x86)\\conkeror\\application.ini")
 '(dired-listing-switches "-alh")
 '(doc-view-continuous t)
 '(doc-view-ghostscript-program (executable-find "gswin32c.exe"))
 '(ein:use-auto-complete t)
 '(ein:use-auto-complete-superpack t)
 '(gnus-nntp-server "nntp.ftc.ru")
 '(gnus-secondary-servers (quote ("")))
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ru")
 '(google-translate-enable-ido-completion t)
 '(ido-save-directory-list-file "~\\.emacs.d\\.ido.last")
 '(ido-use-filename-at-point (quote guess))
 '(indent-tabs-mode nil)
 '(isearch-allow-scroll t)
 '(jabber-account-list (quote (("evtushok@im.ftc.ru" (:password . "'njnjxnjvsltkfkb") (:network-server . "im.ftc.ru") (:port . 5223) (:connection-type . ssl)))))
 '(jabber-connection-ssl-program (quote openssl))
 '(jabber-history-enabled t)
 '(jabber-history-muc-enabled t)
 '(jabber-history-size-limit 10240000)
 '(jabber-muc-colorize-local t)
 '(jabber-use-global-history nil)
 '(jedi:complete-on-dot t)
 '(latex-run-command "pdflatex")
 '(ls-lisp-verbosity (quote (links)))
 '(next-screen-context-lines 5)
 '(org-agenda-files (quote ("~/org/notes.org" "d:/Dropbox/org/input.org" "d:/Dropbox/org/links.org")))
 '(org-agenda-include-diary t)
 '(org-capture-templates (quote (("n" "Связка" entry (file+headline "~/org/notes.org" "Связка") "* %c %?") ("r" "Действие" entry (file+headline "~/org/notes.org" "Действие") "* %c %?
  %a") ("k" "Книги" entry (file+headline "~/org/notes.org" "Книги") "* %c %?
  %a") ("p" "Мысли" entry (file+headline "~/org/notes.org" "Мысль") "* %?%c
  %c
  %a"))))
 '(org-enforce-todo-dependencies t)
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 2))))
 '(org-special-ctrl-a/e t)
 '(org-src-fontify-natively t)
 '(py-shell-switch-buffers-on-execute nil)
 '(python-python-command "ipython")
 '(quack-default-program "racket")
 '(scroll-conservatively 1)
 '(scroll-preserve-screen-position t)
 '(show-paren-mode t)
 '(show-paren-style (quote mixed))
 '(show-smartparens-global-mode t)
 '(sqlplus-command-highlighting-style (quote fringe-and-background))
 '(sqlplus-history-dir "~/.sqlplus/")
 '(sqlplus-html-output-encoding "windows-1251")
 '(sqlplus-html-output-sql (quote (quote elegant)))
 '(sqlplus-init-sequence-start-regexp "/\\* init \\*/")
 '(w3m-command-arguments (quote ("-o" "http_proxy=http://evtushok:'njnjxnjvsltkfkb@msk-proxy.ftc.ru:3128")))
 '(w3m-default-display-inline-images t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(jabber-chat-prompt-local ((t (:foreground "magenta" :weight bold))) t)
 '(jabber-roster-user-away ((t (:foreground "green" :slant italic :weight normal))) t)
 '(jabber-roster-user-online ((t (:slant normal :weight bold))) t)
 '(jabber-title-small ((t (:inherit variable-pitch :background "black" :foreground "yellow" :weight bold :height 1.0 :width semi-expanded))) t)
 '(show-paren-match ((t (:background "cornflower blue" :foreground "moccasin" :weight bold)))))
