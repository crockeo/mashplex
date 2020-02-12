(local init-mode (require "game.modes.init"))

(local modes {init-mode.name init-mode})
(var mode-stack [init-mode])

;; Pushes a named mode onto the top of the stack. This selects the mode where
;; (= name mode.name).
(fn push-mode [name]
  (table.insert mode-stack (. modes name)))

;; Takes the topmost mode off of the stack.
(fn pop-mode []
  (table.remove mode-stack))

;; Sets the stack to equal exactly the selected mode. Equivalent to popping all
;; of the modes off of the stack, and then pushing a mode.
(fn set-mode [name]
  (set mode-stack [(. modes name)]))

;; Calling a named callback on a mode if it exists
(fn call-on-mode [callback params modes]
  (local safe-modes (if (= modes nil)
                        mode-stack
                        modes))

  (let [modes (if (= modes nil)
                  mode-stack
                  modes)

        head (. modes 1)
        tail [(unpack modes 2)]

        callback-fn (. head callback)]
    (when (not (or (= head nil)
                   (= callback-fn nil)
                   (= (callback-fn params) false)))
      call-on-mode callback params tail)))

{:push-mode push-mode
 :pop-mode pop-mode
 :set-mode set-mode

 :call-on-mode call-on-mode}
