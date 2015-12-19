;;; packages.el --- yulong Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq yulong-packages
    '(
      ;; package names go here
      company-c-headers
      ess
      ))

;; List of packages to exclude.
(setq yulong-excluded-packages '())

;; For each package, define a function yulong/init-<package-name>
;;
;; (defun yulong/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

(defun yulong/post-init-company-c-headers ()
  (use-package company-c-headers
    :defer t
    :init (progn
            (setq company-c-headers-path-system
                  (quote
                   ("/usr/include/"
                    "/usr/local/include/"
                    "/usr/include/c++/5.3.1/"
                    "/usr/include/c++/5.3.1/x86_64-redhat-linux/"
                    "/usr/include/c++/5.3.1/backward/"
                    "/usr/lib/gcc/x86_64-redhat-linux/5.3.1/include"))))))

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
            (setq ess-user-full-name "Yulong Niu"))))

