(local init-mode (require "game.modes.init"))
(local pause-mode (require "game.modes.pause"))

(local modes {init-mode.name init-mode
              pause-mode.name pause-mode})
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
  (let [modes (or modes mode-stack)
        num-modes (length modes)
        head (. modes num-modes)
        tail [(unpack modes 1 (- num-modes 1))]]
    (match head
      nil (do)
      {callback callback-fn} (when (callback-fn params)
                               (call-on-mode callback params tail)))))

{:push-mode push-mode
 :pop-mode pop-mode
 :set-mode set-mode

 :call-on-mode call-on-mode}
