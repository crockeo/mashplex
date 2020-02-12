(local init-mode (require "game.modes.init"))

(local modes {init-mode.name init-mode
              :init2 (require "game.modes.init")})
(local mode-stack [])

;; Pushes a named mode onto the top of the stack. This selects the mode where
;; (= name mode.name).
(fn push-mode [name]
  (table.insert mode-stack (. modes name)))

;; Takes the topmost mode off of the stack.
(fn pop-mode [])

;; Returns true iff there exists a mode on the stack.
(fn has-mode [])

;; Sets the stack to equal exactly the selected mode. Equivalent to popping all
;; of the modes off of the stack, and then pushing a mode.
(fn set-mode [name])

;; Calling a named callback on a mode if it exists
(fn call-on-mode [callback params]
  (each [_ mode (ipairs mode-stack)]
    (let [callback-fn (. mode callback)]
      (when (~= callback-fn nil)
        (callback-fn params)))))

{:push-mode push-mode
 :pop-mode pop-mode
 :has-mode has-mode
 :set-mode set-mode

 :call-on-mode call-on-mode}
