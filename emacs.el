(defvar bh-my-base (expand-file-name "~/my"))
(defvar bh-emacs-cfg-path (concat bh-my-base "/cfg/emacs"))
(defvar bh-docs-info-path (concat bh-my-base "/doc/info"))
(defvar bh-docs-todo-path (concat bh-my-base "/doc/todo"))
(defvar bh-todo-file-name (concat bh-my-base "/db/todos"))
(defvar bh-diary-dir (expand-file-name "~/diary"))

;; set the load path for emacs lisp files
(nconc load-path (list bh-emacs-cfg-path "/usr/local/share/emacs/site-lisp"))

(nconc exec-path (list "/usr/local/bin" "/sw/bin" "/opt/local/bin/"))

(mapcar
 (lambda (a) (if (file-exists-p a) (add-to-list 'load-path a t)))
 (list
  (concat bh-emacs-cfg-path "/org")
  )
 )

;; check and set info directories
(setq bh-docs-info-search-path
      (list
       bh-docs-info-path
       (expand-file-name "~/docs/info")
       "/cygwin/usr/info"
       "/usr/local/info"
       "/usr/share/info"
       "/var/info"
       ))
(mapcar
 (lambda (a) (if (file-exists-p a) (add-to-list 'Info-default-directory-list a t)))
 bh-docs-info-search-path)

;; set my email address
(setq user-mail-address "brett@hutley.net")
(setq user-full-name "Brett Hutley")

; no splash screen
(setq inhibit-startup-message t)

;; Get rid of the menubar and the toolbar...
(if (functionp 'tool-bar-mode)
    (tool-bar-mode 0) ; don't show the toolbar
  )
(menu-bar-mode 0) ; don't show the menu bar.
(scroll-bar-mode -1) ; don't show the scroll bar

; turn off the 3d formatting of the mode-line.
(set-face-attribute 'mode-line nil :box nil)

;; hilight the region transiently
(transient-mark-mode t)

;; show parenthesis...
(show-paren-mode)

;; the mode line
(line-number-mode 1)
(column-number-mode 1)
;(display-time)

(setq mac-command-modifier 'meta)
(setq line-move-visual nil)

;; turn off backup files
(setq make-backup-files nil)

(setq bh-host-win-heights
      '(("play" . 32)
        ("squirt" . 28)
        ))

;; set the frame height and position
(let ((host-entry (assoc (system-name) bh-host-win-heights)))
  (if host-entry (set-frame-height (selected-frame) (cdr host-entry))))
(set-frame-position (car (frame-list)) 0 0)

;; set some colors....
(setq my-frame-alist
      '((background-color . "dark slate gray")
        (foreground-color . "antique white")
        (cursor-color . "red")))
(mapcar (lambda (c) (add-to-list 'default-frame-alist c t)) my-frame-alist)
(mapcar (lambda (c) (add-to-list 'initial-frame-alist c t)) my-frame-alist)

(add-to-list 'minibuffer-frame-alist '(background-color . "black"))

(setq frame-background-mode 'dark)

(load "font-lock")

(if (not global-font-lock-mode)
    (global-font-lock-mode)
  )

(set-face-foreground 'font-lock-comment-face "rosy brown")
(set-face-foreground 'font-lock-constant-face "turquoise")
(set-face-foreground 'font-lock-function-name-face "pale green")
(set-face-foreground 'font-lock-keyword-face "yellow")
(set-face-foreground 'font-lock-string-face "orange")
(set-face-foreground 'font-lock-type-face "medium aquamarine")
(set-face-foreground 'font-lock-variable-name-face "yellow green")
(set-face-foreground 'modeline "orange")
;(set-face-background 'modeline "dark slate gray")
(set-face-background 'modeline "black")

(make-face 'bh-modeline-mode-face)
(make-face-italic 'bh-modeline-mode-face)
(set-face-foreground 'bh-modeline-mode-face "red")

(font-lock-add-keywords 'c-mode
  '(("\\<\\(FIXME\\|TODO\\|BH\\)" 1 font-lock-warning-face prepend)
    ("\\<\\(and\\|or\\|not\\)\\>" . font-lock-keyword-face)))


(font-lock-add-keywords 'emacs-lisp-mode
  '(("\\<setq\\>" . font-lock-keyword-face)
    ("\\<load\\>" . font-lock-keyword-face)
    ("\\<\\(and\\|or\\|not\\)\\>" . font-lock-keyword-face)
    ))

(font-lock-add-keywords 'Java-mode
  '(("\\<\\(FIXME\\|TODO\\|BH\\)" 1 font-lock-warning-face prepend)
    ("\\<\\(and\\|or\\|not\\)\\>" . font-lock-keyword-face)))


;; don't want to automatically add newlines...
(setq next-line-add-newlines nil)

;; make a visible bell
(setq visible-bell t)

;; set auto-revert-mode globally
(global-auto-revert-mode 1)

(setq tab-width 4
      ;; this will make sure spaces are used instead of tabs
      indent-tabs-mode nil)

;; the list of tab stops
(setq tab-stop-list nil)
(let ((i 1))
  (while (< i 20)
    (progn
      (setq tab-stop-list (nconc tab-stop-list (list (* i 4))))
      (setq i (+ i 1))
      )
    )
  )
(setq tab-width 4)

;; make tabs spaces...
(setq-default indent-tabs-mode nil)

;replace yes by y
(fset 'yes-or-no-p 'y-or-n-p)

(require 'cc-mode)

(defconst my-c-style
  '((c-tab-always-indent        . t)
    ;(c-comment-only-line-offset . 4)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))


    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))

    (c-offsets-alist            . (
                                   ;(arglist-close . c-lineup-arglist)
                                   (arglist-close . +)
                                   (arglist-intro . +)
                                   ;(c-lineup-arglist . +)
                                   (substatement-open . 0)
                                   (case-label        . 4)
                                   (block-open        . 0)
                                   ;(topmost-intro . 0)
                                   (topmost-intro-cont . 0)
                                   (knr-argdecl-intro . -)))

    (c-echo-syntactic-information-p . t)
    )
  "My C Programming Style")

;; Customizations for all of c-mode, c++-mode, and objc-mode
(defun my-c-mode-common-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "bretts style" my-c-style t)
  ;; other customizations
  (setq-default tab-width 4)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)

  (setq tab-width 4
        ;; this will make sure spaces are used instead of tabs
        indent-tabs-mode nil)

  ;; this will make sure spaces are used instead of tabs
  ;; we like auto-newline and hungry-delete
  ;(c-toggle-auto-hungry-state 1)
  ;; keybindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, and idl-mode-map inherit from it.
;  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
;  (define-key c-mode-base-map ";" 'self-insert-command)
;  (define-key c-mode-base-map "," 'self-insert-command)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(setq compilation-scroll-output t)

;;{{{ add a match-paren function
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;;{{{ todo mode...
(if (file-exists-p bh-todo-file-name)
    (progn
      (autoload 'todo-mode "todo-mode"
        "Major mode for editing TODO lists." t)
      (autoload 'todo-show "todo-mode"
        "Show TODO items." t)
      (autoload 'todo-insert-item "todo-mode"
        "Add TODO item." t)

      (global-set-key "\C-ct" 'todo-show) ;; switch to TODO buffer
      (global-set-key "\C-ci" 'todo-insert-item) ;; insert new item

      (setq todo-file-do bh-todo-file-name)
      )
  )

;;}}}

;; give myself a shell
(if (not (string-equal system-type "windows-nt"))
    (progn
      (setq explicit-shell-file-name "/bin/bash")
      (setq shell-file-name "/bin/bash")
      )
  (progn
      (setq explicit-shell-file-name "c:\\cygwin\\bin\\bash.exe")
      (setq shell-file-name "c:\\cygwin\\bin\\bash.exe")
      )
  )


;; additional packages
(require 'bookmark)

(global-set-key "\M-g" 'goto-line)

;; Make shift-enter insert a newline.
(global-set-key [(shift return)] 'newline)


;; my hotkeys...
(global-unset-key "\C-z")
(global-set-key (kbd "C-z }") 'reindent-c-source)
(global-set-key (kbd "C-z b") 'bookmark-map)
(global-set-key (kbd "C-z c") 'calendar)
(global-set-key (kbd "C-z C") 'chars-in-region)
(global-set-key (kbd "C-z d") 'bh-insert-code-section-divider)
(global-set-key (kbd "C-z D") 'bh-diary-open-today)
(global-set-key (kbd "C-z e") 'eval-region)
(global-set-key (kbd "C-z i") 'add-include-file)
(global-set-key (kbd "C-z o") 'bh-open-source-or-header-file)
(global-set-key (kbd "C-z O") 'occur)
(global-set-key (kbd "C-z u") 'unix-file)
(global-set-key (kbd "C-z z") 'bh-compile)
(global-set-key (kbd "C-z +") 'bh-task-timer-start-task)
(global-set-key (kbd "C-z H") 'bh-open-health-db)

;; open my health database
(defun bh-open-health-db ()
  (interactive)
  (forms-find-file (expand-file-name "~/my/db/health.el"))
  )

;; diary and calendar
(setq diary-file (concat bh-my-base "/db/diary"))
(if (not (file-exists-p diary-file))
    (save-excursion
      (find-file diary-file)
      (insert "\n")
      (save-buffer)
      (kill-buffer nil)
      )
  )

(setq european-calendar-style t)
(setq cal-tex-diary t)
(setq view-diary-entries-initially t
      mark-diary-entries-in-calendar t
      number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
(setq appt-message-warning-time 5)

(setq general-holidays '((holiday-fixed 12 25 "Christmas")))
(setq local-holidays nil)
(setq other-holidays nil)
(setq christian-holidays nil)
(setq hebrew-holidays nil)
(setq islamic-holidays nil)
(setq oriental-holidays nil)
(setq solar-holidays nil)

; Appointment stuff
(add-hook 'diary-hook 'appt-make-list)
(diary 0)

;; Start the server
(if (not (string-equal system-type "windows-nt"))
    (progn
      (server-start)
      )

  (progn
    (if (load "gnuserv" t)
        (progn
          (gnuserv-start)
          (setq gnuserv-frame (selected-frame))
          )
      )
    )
  )


;; ediff
(if (or (not (string-equal system-type "windows-nt"))
        (file-directory-p "/cygwin/bin"))
    (require 'ediff)
  (if (string-equal system-type "windows-nt")
      (progn
        (setq ediff-cmp-program "/cygwin/bin/cmp.exe")
                                        ;(setq ediff-custom-diff-program "/cygwin/bin/diff")
        (setq ediff-diff-program "/cygwin/bin/diff.exe")
        (setq ediff-diff3-program "/cygwin/bin/diff3.exe")
        )
    )
  )

(autoload 'octave-mode "octave-mod" nil t)
;(setq auto-mode-alist
;      (cons '("\\.m$" . octave-mode) auto-mode-alist))

(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))


(iswitchb-mode 1)
(icomplete-mode 99)

;; Don't need this as it's bound to M-/
;;
;(global-set-key [?\S- ] 'bh-complete)
;(defun bh-complete ()
;  (interactive)
;  (dabbrev-expand nil)
;  )

;(load "flashcard")
;(add-to-list 'auto-mode-alist '("\\.deck\\'" . flashcard-mode))

;; load any initialization file that starts with my hostname
;; for host-specific customizations...

(if (string-match "localhost" (system-name))
    (let ((sn (shell-command-to-string "hostname"))
          )
      (if (string-match "[a-z]*" sn)
          (setq system-name (substring sn (match-beginning 0) (match-end 0)))
        )
      )
  )

(let ((host-customization-file (concat bh-emacs-cfg-path "/" (system-name) ".el")))
  (if (file-exists-p host-customization-file)
      (load host-customization-file)
    )
  )

(defun kill-all-buffers ()
  (interactive)
  (let ((bl (buffer-list)) (b nil) (bn nil))
    (while bl
      (setq b (car bl))
      (setq bn (buffer-name b))
      (if (not (or (string-equal bn "*scratch*")
                   (string-equal bn "*info*")
                   (string-equal bn "*Messages*")
                   ))
          (kill-buffer b)
        )
      (setq bl (cdr bl))
      )
    )
  )

(defun bh-c-header-insert-include-guard ()
  (interactive)
  (let ((fn (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    (let ((excl-tag (concat fn "_h")))
      (save-excursion
        (goto-char 0)
        (if (not (search-forward (concat "#define " excl-tag) nil t))
            (progn
              (goto-char 0)
              (insert "#ifndef " excl-tag "\n")
              (insert "#define " excl-tag "\n")

              (goto-char (buffer-size))
              (insert "\n#endif\n")
              )
            )
        )
      )
    )
  )

(make-face 'bh-modeline-mode-face)
(make-face-italic 'bh-modeline-mode-face)
(set-face-foreground 'bh-modeline-mode-face "lime green")

(make-face 'bh-modeline-line-column-face)
(set-face-foreground 'bh-modeline-line-column-face "pale green")

(make-face 'bh-modeline-timedate-face)
(set-face-foreground 'bh-modeline-timedate-face "pale green")


;;; ------------------- TASK STUFF ------------

(defconst bh-task-xemacs-p
  (and (string-match "XEmacs\\|Lucid" (emacs-version)) t))

(if bh-task-xemacs-p
    (require 'itimer)
  (require 'timer))

(defvar bh-task-update-interval 60
  "*Seconds between updates of task timer in the mode line.")

(defvar bh-task-show-time-24hr-p nil
  "*Non-nil indicates time should be displayed as hh:mm, 0 <= hh <= 23.
Nil means 1 <= hh <= 12, and an AM/PM suffix is used.")

(defvar bh-task-show-day-and-date-p nil
  "*If non-`nil', display the month and date.")

(defvar bh-task-timer-running-p nil
  "*If non-`nil', we have a task-timer currently running")

(defvar bh-task-timer-remaining-minutes 0
  "*The number of minutes remaining for the current task")

(defvar bh-task-timer-running-color "yellow"
  "*The color to turn the foreground color of the mode line when we
have a task running.")

(defvar bh-task-timer-remaining-string ""
  "A string indicating the number of minutes remaining for the current task")

(defvar bh-task-timer-file nil
  "*File name of a file to act as a timesheet for all my tasks.
If `nil', or the file doesn't exists - don't record the task activity.")

(defvar bh-task-hook nil
  "*Functions to be called when the time is updated on the mode line.")

(defvar bh-task-mode-line-update-functions
  '(bh-task-set-time-string
    bh-task-set-day-and-date-string
    bh-task-timer-update
    )
  )


(defvar bh-task-enabled nil)
(defvar bh-task-timer nil)

(defmacro bh-task-run-at-time (time repeat function &rest args)
  (if bh-task-xemacs-p
      (list 'start-itimer
            (if (symbolp function)
                (symbol-name function)
              "anonymous function")
            function time repeat)
    (append (list 'run-at-time time repeat function) args)))

(defmacro bh-task-cancel-timer (timer)
  (let ((fn (if bh-task-xemacs-p 'delete-itimer 'cancel-timer)))
    (list 'and timer (list fn timer))))

;;;###autoload
(defun bh-task-enable ()
  (interactive)
  (or global-mode-string (setq global-mode-string '("")))
  (or (memq 'bh-task-mode-line-format global-mode-string)
      (setq global-mode-string
            (append global-mode-string '(bh-task-mode-line-format))))
  (setq bh-task-enabled t)
  (bh-task-update)
  (bh-task-reset-timer)
  (force-mode-line-update t)
  ;(bh-task-force-mode-line-update)
  )

(defun bh-task-disable ()
  (interactive)
  (bh-task-cancel-timer bh-task-timer)
  (setq bh-task-timer nil)
  (setq bh-task-enabled nil)
  (force-mode-line-update t)
  ;(bh-task-force-mode-line-update)
  )

(defun bh-task-reset-timer ()
  (bh-task-cancel-timer bh-task-timer)
  (setq bh-task-timer nil)
  (if bh-task-update-interval
      (setq bh-task-timer
            (bh-task-run-at-time bh-task-update-interval
                                  nil
                                  'bh-task-update))
    (bh-task-disable)))

(defun bh-task-build-mode-line ()
  (let ((fns bh-task-mode-line-update-functions)
        ;(process-environment (default-value 'process-environment))
        ;(default-directory (expand-file-name bh-task-default-directory))
    )
    (while fns
      (funcall (car fns))
      (setq fns (cdr fns))))
  )

(defun bh-task-update ()
  (bh-task-build-mode-line)
  (bh-task-reset-timer)
  ;(bh-task-force-mode-line-update)
  (force-mode-line-update t)
  )

(defvar bh-task-time-string "")
(defvar bh-task-day-and-date-string "")

(defun bh-task-set-time-string ()
  (if bh-task-show-time-24hr-p
      (bh-task-set-time-string-24hr)
    (bh-task-set-time-string-12hr)))

(defun bh-task-set-time-string-24hr ()
  (setq bh-task-time-string
        (substring (current-time-string) 11 16)))

(defun bh-task-set-time-string-12hr ()
  (let* ((time (current-time-string))
         (24-hours (substring time 11 13))
         (hour (string-to-int 24-hours))
         (12-hours (int-to-string (1+ (% (+ hour 11) 12))))
         (am-pm (if (> hour 11) "pm" "am")))
    (setq bh-task-time-string
          (concat 12-hours ":" (substring time 14 16) am-pm))))

(defun bh-task-set-day-and-date-string ()
  (if bh-task-show-day-and-date-p
      (let* ((tm-str (current-time-string)))
        (setq bh-task-day-and-date-string
               (concat (substring tm-str 4 7)
                       " "
                       (if (= (aref tm-str 8) ? )
                           (substring tm-str 9 10)
                         (substring tm-str 8 10)))))
    (setq bh-task-day-and-date-string nil)))


(setq bh-task-modeline-foreground-save nil)

(defun bh-task-timer-update ()
  (if bh-task-timer-running-p
      (progn
    (if (> bh-task-timer-remaining-minutes 0)
        (setq bh-task-timer-remaining-minutes    (- bh-task-timer-remaining-minutes 1))
      )
    (if (> bh-task-timer-remaining-minutes 0)
        (progn
          (setq bh-task-timer-remaining-string (concat "/" (int-to-string bh-task-timer-remaining-minutes) "m"))
          )
      (progn
        (setq bh-task-timer-running-p nil)
        (setq bh-task-timer-remaining-string "")

        ; flash screen
        ;(ding t)
        ;(ding t)
        ;(ding t)

            (set-face-foreground 'bh-modeline-timedate-face bh-task-modeline-foreground-save)
        )
      )
    )
    )
  )

(defun bh-task-timer-start-task ()
  (interactive)
  (let ((task-desc "")
    (num-mins 0))
    (setq task-desc (read-string "Task desc: "))
    (setq num-mins (string-to-int (read-string "Num minutes: ")))
    (if (<= num-mins 0)
    (error "The number of minutes should be greater than zero!")
      )

    (if (and bh-task-timer-file (file-exists-p bh-task-timer-file))
    (progn
      (save-excursion
       (find-file bh-task-timer-file)
       (goto-char (point-max))
       (let ((tm (decode-time)))
         ; (SEC MINUTE HOUR DAY MONTH YEAR DOW DST ZONE)
         (insert (format "%d-%02d-%02d %02d:%02d\t%d mins\t%s\n"
                 (elt tm 5)
                 (elt tm 4)
                 (elt tm 3)
                 (elt tm 2)
                 (elt tm 1)
                 num-mins
                 task-desc
                 ))
         )
       (save-buffer)
       (kill-buffer nil)
       )
      )
      )

    (setq bh-task-timer-running-p t)

    ; we increment here, because the first thing the timer does is decrement.
    (setq bh-task-timer-remaining-minutes (+ num-mins 1))

    (bh-task-build-mode-line)
    (setq bh-task-modeline-foreground-save (face-attribute 'bh-modeline-timedate-face :foreground))
    (set-face-foreground 'bh-modeline-timedate-face bh-task-timer-running-color)

    (force-mode-line-update t)
    ;(bh-task-force-mode-line-update)
    )
  )

;;; -------------- END OF TASK STUFF ----------

;(require 'bh-task nil t)
(setq bh-task-show-day-and-date-p t)
(bh-task-enable)
(setq bh-task-timer-file (expand-file-name "~/my/db/task_history.txt"))

(defun bh-get-modeline-time-date ()
  (propertize (concat bh-task-day-and-date-string " " bh-task-time-string bh-task-timer-remaining-string) 'face 'bh-modeline-timedate-face)
;  (propertize bh-task-day-and-date-string 'face 'bh-modeline-timedate-face)
;  " "
;  (propertize bh-task-time-string 'face 'bh-modeline-timedate-face)
;  (propertize bh-task-timer-remaining-string 'face 'bh-modeline-timedate-face)
  )

(setq default-mode-line-format
      (list
       " "
       ;(propertize ">" 'face 'diary-face)
       mode-line-mule-info mode-line-modified mode-line-frame-identification

       (propertize "%5l:%3c " 'face 'bh-modeline-line-column-face)

       ;(propertize "%p " 'face 'font-lock-keyword-face)

       (propertize "%[%20b%] " 'face 'bold)

       (list :eval '(bh-get-modeline-time-date))

       (propertize " *%m* " 'face 'bh-modeline-mode-face)

;       mode-line-buffer-identification

;       (mode-line-mode-name)

;       #("   " 0 3 nil)
;       global-mode-string
;       #("   %[(" 0 6 nil)
;       (list :eval
;        (mode-line-mode-name))
;       mode-line-process minor-mode-alist
;       #("%n" 0 2 nil)
;       #(")%]  " 0 5 nil)
;       (list which-function-mode
;        (list "" which-func-format
;         #("--" 0 2 nil)))
       ;(list -3 .
       ;    (list #("%p" 0 2 nil)))
;       #("-%-" 0 3 nil)))
       )
      )

;; the Rememberance Agent.
; The default is OK for me.
; (setq remem-prog-dir <prog-dir-string>)
(setq bh-remem-index-file (expand-file-name "~/.ra-indexes"))
(if (file-exists-p bh-remem-index-file)
    (progn
      (setq remem-database-dir bh-remem-index-file)
      (setq remem-scopes-list '(("my-docs" 6 10 500)))
      (load "remem.el")
      )
  )

(defun bh-other-window ()
  (interactive)
  (other-window 1)
  (if (string-equal (buffer-name (window-buffer)) "*remem-display*")
      (other-window 1)
    )
  )
(global-set-key (kbd "C-x o") 'bh-other-window)

(setq auto-mode-alist
      (cons '("\\.m$" . objc-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.mm$" . objc-mode) auto-mode-alist))

(defun bh-choose-header-mode ()
  (interactive)
  (if (string-equal (substring (buffer-file-name) -2) ".h")
      (progn
        ;; OK, we got a .h file, if a .m file exists we'll assume it's
        ; an objective c file. Otherwise, we'll look for a .cpp file.
        (let ((dot-m-file (concat (substring (buffer-file-name) 0 -1) "m"))
              (dot-mm-file (concat (substring (buffer-file-name) 0 -1) "mm"))
              (dot-cpp-file (concat (substring (buffer-file-name) 0 -1) "cpp")))
          (if (or (file-exists-p dot-m-file) (file-exists-p dot-mm-file))
              (progn
                (objc-mode)
                )
            (if (file-exists-p dot-cpp-file)
                (c++-mode)
              )
            )
          )
        )
    )
  )

(add-hook 'find-file-hook 'bh-choose-header-mode)

(defun bh-open-source-or-header-file ()
  (interactive)
  (if (string-equal (substring (buffer-file-name) -2) ".h")
      (progn
        ;; OK, we got a .h file, if a .m file exists we'll assume it's
        ; an objective c file. Otherwise, we'll look for a .cpp file.
        (let ((dot-m-file (concat (substring (buffer-file-name) 0 -1) "m"))
              (dot-mm-file (concat (substring (buffer-file-name) 0 -1) "mm"))
              (dot-c-file (concat (substring (buffer-file-name) 0 -1) "c"))
              (dot-cpp-file (concat (substring (buffer-file-name) 0 -1) "cpp")))
          (if (file-exists-p dot-m-file)
              (find-file-other-window dot-m-file)
            (if (file-exists-p dot-mm-file)
                (find-file-other-window dot-mm-file)
              (if (file-exists-p dot-cpp-file)
                  (find-file-other-window dot-cpp-file)
                (if (file-exists-p dot-c-file)
                    (find-file-other-window dot-c-file)
                  )
                )
              )
            )
          )
        )
    ;; else not .h file
    (if (or (string-equal (downcase (substring (buffer-file-name) -4)) ".cpp")
            (string-equal (downcase (substring (buffer-file-name) -2)) ".c")
            (string-equal (downcase (substring (buffer-file-name) -2)) ".m")
            (string-equal (downcase (substring (buffer-file-name) -3)) ".mm")
            )
        (let ((hdr-name (replace-regexp-in-string "\\.[a-z]+$" ".h" (buffer-file-name))))
          (find-file-other-window hdr-name)
          )
      )
    )
  )

(defun bh-compile ()
  (interactive)
  (let ((df (directory-files "."))
        (has-proj-file nil)
        )
    (while (and df (not has-proj-file))
      (let ((fn (car df)))
        (if (> (length fn) 10)
            (if (string-equal (substring fn -10) ".xcodeproj")
                (setq has-proj-file t)
              )
          )
        )
      (setq df (cdr df))
      )
    (if has-proj-file
        (compile "xcodebuild -configuration Debug")
      (compile "make")
      )
    )
  )

(defun bh-insert-code-section-divider ()
  (interactive)
  (let ((nm nil)
        (i 0)
        )
    (setq nm (read-string "Section:"))

    (insert "/* -- ")
    (insert nm " ")
    (while (< i (- 60 (length nm)))
      (insert "-")
      (setq i (+ i 1))
      )
    (insert " */")
    )
  (beginning-of-line)
  (next-line)
  )

(require 'php-mode nil t)
(require 'css-mode nil t)
(require 'vc-svn nil t)

(require 'bh-fin nil t)
(setq bh-fin-base-dir (expand-file-name "~/brett/docs/personal/finances/accounts"))

(require 'bh-proj nil t)
(setq bh-proj-file (expand-file-name "~/my/db/proj.el"))

(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.todo$" . org-mode))
(setq org-todo-keywords '("TODO" "FEEDBACK" "VERIFY" "STARTED" "WAITING" "DONE" "DEFERRED" "CANCELLED")
      org-todo-interpretation 'sequence)
(setq org-todo-keyword-faces
       (quote (("TODO" :foreground "antique white" :weight bold)
               ("FEEDBACK" :foreground "medium slate blue" :weight bold)
               ("VERIFY" :foreground "yellow" :weight bold)
               ("DEFERRED" :foreground "brown" :weight bold)
               ("STARTED" :foreground "dark orange" :weight bold)
               ("WAITING" :foreground "light goldenrod" :weight bold)
               ("DELEGATED" :foreground "indian red" :slant italic)
               ("DONE" :foreground "black" :weight bold)
               ("CANCELLED" :foreground "black" :strike-through "red" :weight bold)
               )))

;(require 'actionscript-mode)
;
;(require 'ruby-mode)
;(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
;(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
;

;; todo stuff...
(require 'calendar)
(defun bh-todo-file-name ()
  (interactive)
  (let ((this-date (calendar-current-date))
        (fn ""))
    (setq fn (format "%d%02d%02d.todo"
                     (nth 2 this-date)
                     (nth 0 this-date)
                     (nth 1 this-date)
                     ))
    fn
    )
  )

(defun bh-date-prev (date)
  (interactive)
  (let ((m (nth 0 date))
        (d (nth 1 date))
        (y (nth 2 date))
        (pd nil)
        )
    (setq d (- d 1))
    (setq pd (list m d y))
    (if (= d 0)
        (progn
          (setq m (- m 1))
          (setq d 31)
          (if (= m 0)
              (progn
                (setq y (- y 1))
                (setq m 12)
                )
            )
          (setq pd (list m d y))
          (while (not (calendar-date-is-legal-p pd))
            (progn
              (setq d (- d 1))
              (setq pd (list m d y))
              )
            )
          )
      )
    pd
    )
  )

(defun bh-todo-open-today ()
  (interactive)
  (let ((fn (concat bh-docs-todo-path "/" (bh-todo-file-name))))
    (if (not (file-exists-p fn))
        (let ((im-done nil)
              (this-date (calendar-current-date))
              (prev-file-name "")
              (try-count 0)
              )
          (while (and (not im-done) (< try-count 20))
            (progn
              (setq this-date (bh-date-prev this-date))
              (setq prev-file-name (concat bh-docs-todo-path "/"
                                           (format "%d%02d%02d.todo"
                                                   (nth 2 this-date)
                                                   (nth 0 this-date)
                                                   (nth 1 this-date)
                                                   )))

              (if (file-exists-p prev-file-name)
                  (progn
                    (setq im-done t)

                    (find-file fn)
                    (insert-file-contents prev-file-name)
                    (goto-char 0)
                    (while (re-search-forward "^* DEFERRED" nil t)
                      (replace-match "* TODO")
                      )
                    (goto-char 0)
                    (while (re-search-forward "^* DONE " nil t)
                      (org-cut-subtree)
                      )
                    (goto-char 0)
                    )
                )

              (setq try-count (+ try-count 1))
              )
            )

          (if (>= try-count 20)
              (find-file fn)
            )
          )

      ; else file exists!
      (find-file fn)
      )
    )
  )

(global-set-key (kbd "C-z t") 'bh-todo-open-today)

(add-hook 'kill-emacs-hook 'bh-check-all-todos-are-finalized)

(defun bh-check-all-todos-are-finalized ()
  (interactive)
  (bh-todo-open-today)
  (goto-char 0)
  (if (re-search-forward "^* TODO " nil t)
      (error "You need to close out your TODO's before quiting")
    )
  )

(defun bh-diary-file-name ()
  (interactive)
  (let ((this-date (calendar-current-date))
        (fn ""))
    (setq fn (format "%d%02d%02d.txt"
                     (nth 2 this-date)
                     (nth 0 this-date)
                     (nth 1 this-date)
                     ))
    fn
    )
  )

(defun bh-diary-open-today ()
  (interactive)
  (find-file (concat bh-diary-dir "/" (bh-diary-file-name)))
  (if (= (buffer-size) 0)
      (let ((dt-str (calendar-date-string (calendar-current-date)))
            (i 0)
            )
        (insert (concat dt-str "\n"))
        (while (< i (length dt-str))
          (insert "=")
          (setq i (+ i 1))
          )
        (insert "\n\n")
        )
    )
  )

(require 'tramp)
(setq tramp-default-method "scp")

(defun bh-delete-temp-note ()
  (interactive)
;  (if (and (string= (substring (file-name-nondi rectory (buffer-file-name)) 0 4) "tmp-")
;           (file-exists-p (buffer-file-name)))
;;      (delete-file (buffer-file-name))
;     (message (buffer-file-name))
;    )
  )

(defun bh-open-temp-note ()
  (interactive)
  (find-file (make-temp-name (expand-file-name "~/tmp/tmp-")))
  (org-mode)
  (longlines-mode)
  (add-hook 'kill-buffer-hook 'bh-delete-temp-note)
  )

;(setq load-path (cons (concat bh-emacs-cfg-path "/rhtml") load-path))
;(require 'rhtml-mode)
;(add-hook 'rhtml-mode-hook
  ;(lambda () (rinari-launch)))
;(require 'snippet)
;
;(setq load-path (cons (concat bh-emacs-cfg-path "/emacs-rails") load-path))
;(require 'rails)

;(load (concat bh-emacs-cfg-path "/nxhtml/autostart22.el"))

(load "magit")
