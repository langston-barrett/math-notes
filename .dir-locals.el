;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

;; https://stackoverflow.com/questions/4012321/how-can-i-access-the-path-to-the-current-directory-in-an-emacs-directory-variabl 
((nil . ((eval . (setq ispell-personal-dictionary
                       (expand-file-name
                        "dictionary.txt"
                        (file-name-directory
                         (let ((d (dir-locals-find-file ".")))
                           (if (stringp d) d (car d))))))))))
