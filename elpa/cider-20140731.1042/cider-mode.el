;;; cider-mode.el --- Minor mode for REPL interactions -*- lexical-binding: t -*-

;; Copyright © 2012-2014 Tim King, Phil Hagelberg
;; Copyright © 2013-2014 Bozhidar Batsov, Hugo Duncan, Steve Purcell
;;
;; Author: Tim King <kingtim@gmail.com>
;;         Phil Hagelberg <technomancy@gmail.com>
;;         Bozhidar Batsov <bozhidar@batsov.com>
;;         Hugo Duncan <hugo@hugoduncan.org>
;;         Steve Purcell <steve@sanityinc.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Minor mode for REPL interactions.

;;; Code:

(require 'cider-interaction)

(defvar cider-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "M-.") 'cider-jump)
    (define-key map (kbd "M-,") 'cider-jump-back)
    (define-key map (kbd "C-c M-.") 'cider-jump-to-resource)
    (define-key map (kbd "M-TAB") 'complete-symbol)
    (define-key map (kbd "C-c C-d a") 'cider-apropos)
    (define-key map (kbd "C-c C-d A") 'cider-apropos-documentation)
    (define-key map (kbd "C-c C-d g") 'cider-grimoire)
    (define-key map (kbd "C-c C-d j") 'cider-javadoc)
    (define-key map (kbd "C-c C-d d") 'cider-doc)
    (define-key map (kbd "C-M-x")   'cider-eval-defun-at-point)
    (define-key map (kbd "C-c C-c") 'cider-eval-defun-at-point)
    (define-key map (kbd "C-x C-e") 'cider-eval-last-sexp)
    (define-key map (kbd "C-c C-e") 'cider-eval-last-sexp)
    (define-key map (kbd "C-c C-w") 'cider-eval-last-sexp-and-replace)
    (define-key map (kbd "C-c M-e") 'cider-eval-last-sexp-to-repl)
    (define-key map (kbd "C-c M-p") 'cider-insert-last-sexp-in-repl)
    (define-key map (kbd "C-c C-p") 'cider-pprint-eval-last-sexp)
    (define-key map (kbd "C-c C-f") 'cider-pprint-eval-defun-at-point)
    (define-key map (kbd "C-c C-r") 'cider-eval-region)
    (define-key map (kbd "C-c C-n") 'cider-eval-ns-form)
    (define-key map (kbd "C-c M-:") 'cider-read-and-eval)
    (define-key map (kbd "C-c C-m") 'cider-macroexpand-1)
    (define-key map (kbd "C-c M-m") 'cider-macroexpand-all)
    (define-key map (kbd "C-c M-n") 'cider-repl-set-ns)
    (define-key map (kbd "C-c M-i") 'cider-inspect)
    (define-key map (kbd "C-c M-t") 'cider-toggle-trace)
    (define-key map (kbd "C-c C-z") 'cider-switch-to-repl-buffer)
    (define-key map (kbd "C-c M-o") 'cider-find-and-clear-repl-buffer)
    (define-key map (kbd "C-c C-k") 'cider-load-current-buffer)
    (define-key map (kbd "C-c C-l") 'cider-load-file)
    (define-key map (kbd "C-c C-b") 'cider-interrupt)
    (define-key map (kbd "C-c ,")   'cider-test-run-tests)
    (define-key map (kbd "C-c C-,") 'cider-test-rerun-tests)
    (define-key map (kbd "C-c M-,") 'cider-test-run-test)
    (define-key map (kbd "C-c C-t") 'cider-test-show-report)
    (define-key map (kbd "C-c M-s") 'cider-selector)
    (define-key map (kbd "C-c M-r") 'cider-rotate-connection)
    (define-key map (kbd "C-c M-d") 'cider-display-current-connection-info)
    (define-key map (kbd "C-c C-x") 'cider-refresh)
    (define-key map (kbd "C-c C-q") 'cider-quit)
    (easy-menu-define cider-mode-menu map
      "Menu for CIDER mode"
      '("CIDER"
        ["Complete symbol" complete-symbol]
        "--"
        ["Eval top-level sexp at point" cider-eval-defun-at-point]
        ["Eval last sexp" cider-eval-last-sexp]
        ["Eval last sexp in popup buffer" cider-pprint-eval-last-sexp]
        ["Eval last sexp to REPL buffer" cider-eval-last-sexp-to-repl]
        ["Eval last sexp and replace it with its result" cider-eval-last-sexp-and-replace]
        ["Eval region" cider-eval-region]
        ["Eval ns form" cider-eval-ns-form]
        ["Insert last sexp in REPL" cider-insert-last-sexp-in-repl]
        "--"
        ["Load current buffer" cider-load-current-buffer]
        ["Load file" cider-load-file]
        "--"
        ["Macroexpand-1 last expression" cider-macroexpand-1]
        ["Macroexpand-all last expression" cider-macroexpand-all]
        "--"
        ["Jump to source" cider-jump]
        ["Jump to resource" cider-jump-to-resource]
        ["Jump back" cider-jump-back]
        "--"
        ["Search functions/vars" cider-apropos]
        ["Search documentation" cider-apropos-documentation]
        "--"
        ["Display documentation" cider-doc]
        ["Display JavaDoc" cider-javadoc]
        ["Display Grimoire documentation" cider-grimoire]
        ["Inspect" cider-inspect]
        "--"
        ["Run test" cider-test-run-test]
        ["Run all tests" cider-test-run-tests]
        ["Rerun failed/erring tests" cider-test-rerun-tests]
        ["Show test report" cider-test-show-report]
        "--"
        ["Set ns" cider-repl-set-ns]
        ["Switch to REPL" cider-switch-to-repl-buffer]
        ["Switch to Relevant REPL" cider-switch-to-relevant-repl-buffer]
        ["Toggle REPL Pretty Print" cider-repl-toggle-pretty-printing]
        ["Clear REPL" cider-find-and-clear-repl-buffer]
        ["Refresh loaded code" cider-refresh]
        ["Interrupt" cider-interrupt]
        ["Quit" cider-quit]
        ["Restart" cider-restart]
        "--"
        ["Display current nREPL connection" cider-display-current-connection-info]
        ["Rotate current nREPL connection" cider-rotate-connection]
        "--"
        ["Version info" cider-version]))
    map))

;;;###autoload
(define-minor-mode cider-mode
  "Minor mode for REPL interaction from a Clojure buffer.

\\{cider-mode-map}"
  nil
  " cider"
  cider-mode-map
  (make-local-variable 'completion-at-point-functions)
  (add-to-list 'completion-at-point-functions
               'cider-complete-at-point))

(provide 'cider-mode)

;;; cider-mode.el ends here
