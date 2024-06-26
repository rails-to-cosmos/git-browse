;;; git-browse.el --- Browse current file on corresponding Git management website  -*- lexical-binding:t; coding:utf-8 -*-

;; Copyright (C) 2024 Dmitry Akatov <dmitry.akatov@protonmail.com>
;; Author: Dmitry Akatov <dmitry.akatov@protonmail.com>
;; Maintainer: Dmitry Akatov <dmitry.akatov@protonmail.com>
;; Homepage: https://github.com/rails-to-cosmos/git-browse
;; Keywords: git tools vc
;; Package-Version: 1.0.0
;; Package-Requires: (
;;     (emacs "26.1")
;;; Code:

(require 'browse-url)
(require 'files)
(require 'simple)
(require 's)

(defun -git-browse-remote-to-url (remote)
  "Convert REMOTE url string to https url."
  (if (string-prefix-p "git@" remote)
      (-git-browse-ssh-to-url remote)
    (-git-browse-http-to-url remote)))

(defun -git-browse-ssh-to-url (remote)
  (s-replace-all '((".git" . "/-") ("git@" . "https://") (":" . "/")) remote))

(defun -git-browse-http-to-url (remote)
  (->> remote-url
       (replace-regexp-in-string "^\\(git\\|https?\\)://" "https://")
       (s-replace "\\.git$" "")))

(defun git-browse-current-line ()
  "Browse the current line in remote web ui."
  (interactive)
  (let* ((repo-root (locate-dominating-file default-directory ".git"))
         (relative-path (file-relative-name buffer-file-name repo-root))
         (remote-url (string-trim (shell-command-to-string "git config --get remote.origin.url")))
         (branch (string-trim (shell-command-to-string "git rev-parse --abbrev-ref HEAD")))
         (line (line-number-at-pos))
         (base-url (-git-browse-remote-to-url remote-url)))
    (browse-url (format "%s/blob/%s/%s#L%d" base-url branch relative-path line))))

(provide 'git-browse)
;;; git-browse.el ends here