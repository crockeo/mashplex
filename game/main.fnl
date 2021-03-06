;; We need to initialize the global for debug-mode here, rather than after
;; imports, in case any of our imports depend on the existence of the symbol.
(global debug-mode false)

(local fennel (require "lib.fennel"))
(local repl (require "lib.stdio"))

(local mode-stack (require "game.mode-stack"))

;; Love2D callbacks that are automatically forwarded to
(fn love.load [arg unfiltered-arg]
  (repl:start)

  ;; Globally setting debug mode, when appropriate
  (each [_ s (ipairs arg)]
    (when (= s "debug")
      (global debug-mode true)))

  ;; Love configurations
  (love.graphics.setDefaultFilter "nearest" "nearest")
  (love.graphics.setNewFont "res/terminal-grotesque.ttf" 64)

  ;; TODO: Move this into a more permanent position. This isn't the best place
  ;;       to do all of the initialization, especially as the game gets more
  ;;       modes.
  (each [_ mode (pairs mode-stack.modes)]
    (when mode.load
      (mode.load {:arg arg
                  :unfiltered-arg unfiltered-arg})))

  (mode-stack.call-on-mode :load {:arg arg
                                  :unfiltered-arg unfiltered-arg}))

(fn love.quit []
  (mode-stack.call-on-mode :quit {}))

(fn love.draw []
  (let [(window-width window-height) (love.window.getMode)]
    (mode-stack.call-on-mode :draw {:time (love.timer.getTime)
                                    :window-height window-height
                                    :window-width window-width} true)))

(fn love.update [dt]
  (mode-stack.call-on-mode :update {:dt dt
                                    :mode-stack mode-stack}))

(fn love.keypressed [key scancode isrepeat]
  (mode-stack.call-on-mode :keypressed {:isrepeat isrepeat
                                        :key key
                                        :mode-stack mode-stack
                                        :scancode scancode}))

(fn love.keyreleased [key scancode]
  (mode-stack.call-on-mode :keyreleased {:key key
                                        :mode-stack mode-stack
                                        :scancode scancode}))
