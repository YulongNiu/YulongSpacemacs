;;; packages.el --- yulong layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: YulongNiu <yulong.niu@aol.com>
;; URL: https://github.com/YulongNiu/YulongSpacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installednew layer or configured by this layer should be
;; added to `yulong-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `yulong/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `yulong/pre-init-PACKAGE' and/or
;;   `yulong/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:
(defun yulong/post-init-company-c-headers ()
  (use-package company-c-headers
    :defer t
    :init (progn
            (setq company-c-headers-path-system
                  (quote
                   ("/usr/include/"
                    "/usr/local/include/"
                    "/usr/include/c++/6.2.1/"
                    "/usr/include/c++/6.2.1/x86_64-redhat-linux/"
                    "/usr/include/c++/6.2.1/backward/"
                    "/usr/lib/gcc/x86_64-redhat-linux/6.2.1/include"))))))

(defun yulong/post-init-ess ()
  (use-package ess
    :defer t
    :init (progn
            (setq ess-roxy-template-alist
                  (quote
                   (("description" . ".. content for \\description{} (no empty lines) ..")
                    ("details" . ".. content for \\details{} ..")
                    ("title" . "")
                    ("param" . "")
                    ("return" . "")
                    ("examples" . "")
                    ("author" . "Yulong Niu \\email{niuylscu@@gmail.com}"))))
            (setq ess-roxy-str "##'")
            (setq ess-user-full-name "Yulong Niu"))
    (defun ess-rmarkdown ()
      (interactive)
      "Compile R markdown (.Rmd). Should work for any output type."
      "http://roughtheory.com/posts/ess-rmarkdown.html"
      ;; Check if attached R-session
      (condition-case nil
          (ess-get-process)
        (error
         (ess-switch-process)))
      (let* ((rmd-buf (current-buffer)))
        (save-excursion
          (let* ((sprocess (ess-get-process ess-current-process-name))
                 (sbuffer (process-buffer sprocess))
                 (buf-coding (symbol-name buffer-file-coding-system))
                 (R-cmd
                  (format "library (rmarkdown); rmarkdown::render (\"%s\", output_dir = \"/tmp\"); browseURL(paste0(\"/tmp/\", unlist(strsplit(tail(unlist(strsplit(\"%s\", split = \"/\", fixed = TRUE)), n = 1), split = \".\", fixed = TRUE))[1], \".html\"));"
                          buffer-file-name buffer-file-name)))
            (message "Running rmarkdown on %s" buffer-file-name)
            (ess-execute R-cmd 'buffer nil nil)
            (switch-to-buffer rmd-buf)
            (ess-show-buffer (buffer-name sbuffer) nil)))))
))

(defconst yulong-packages
  '(
      ;; package names go here
      company-c-headers
      ess
      )
  "The list of Lisp packages required by the yulong layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

;;; packages.el ends here
