;; vi keybinds
(define-configuration buffer
  ((default-modes
    (pushnew 'nyxt/mode/vi:vi-normal-mode %slot-value%))))

;; Adblocker
(define-configuration web-buffer
  ((default-modes
    (pushnew 'nyxt/mode/blocker:blocker-mode %slot-value%))))
