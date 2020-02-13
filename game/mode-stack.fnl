(local lume (require "lib.lume"))

;; Constructing the list of modes. Designed in this way so we can have a single
;; import define the existance of a mode.
(fn generate-modes [mode-list]
  (local modes {})

  (each [_ mode (ipairs mode-list)]
    (tset modes mode.name mode))

  modes)

(local modes (generate-modes
              [(require "game.modes.game")
               (require "game.modes.menu")
               (require "game.modes.pause")]))

(var mode-stack [(. modes :menu)])

;; Pushes a named mode onto the top of the stck. This selects the mode where
;; (= name mode.name).
(fn push-mode [name ...]
  (local mode (. modes name))
  (assert mode
          (string.format "No such mode '%s'"
                         name))

  (when mode.init
    (mode.init (unpack [...])))

  (table.insert mode-stack mode))

;; Takes the topmost mode off of the stack.
(fn pop-mode []
  (table.remove mode-stack))

;; Sets the stack to equal exactly the selected mode. Equivalent to popping all
;; of the modes off of the stack, and then pushing a mode.
(fn set-mode [name ...]
  (local mode (. modes name))
  (assert mode
          (string.format "No such mode '%s'"
                         name))

  (when mode.init
    (mode.init (unpack [...])))

  (set mode-stack [mode]))

;; Calling a named callback on a mode if it exists
(fn call-on-mode [callback params reverse modes]
  (let [modes (or modes mode-stack)
        num-modes (length modes)

        head (if reverse
                 (. modes 1)
                 (. modes num-modes))

        tail (if reverse
                 [(unpack modes 2 num-modes)]
                 [(unpack modes 1 (- num-modes 1))])]

    (match head
      nil (do)
      {callback callback-fn} (when (callback-fn params)
                               (call-on-mode callback params reverse tail))
      default (call-on-mode callback params reverse tail))))

{:modes modes

 :push-mode push-mode
 :pop-mode pop-mode
 :set-mode set-mode

 :call-on-mode call-on-mode}
