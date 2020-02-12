(local fennel (require "lib.fennel"))
(local repl (require "lib.stdio"))

(local mode-stack (require "game.mode-stack"))
(mode-stack.push-mode "init")

;; Love2D callbacks that are automatically forwarded to
(fn love.draw []
  (mode-stack.call-on-mode :draw {}))

(fn love.load [arg unfiltered-arg]
  (repl:start)
  (mode-stack.call-on-mode :load {:arg arg
                                  :unfiltered-arg unfiltered-arg}))

(fn love.quit []
  (mode-stack.call-on-mode :quit {}))

(fn love.update [dt]
  (mode-stack.call-on-mode :update {:dt dt
                                    :mode-stack mode-stack}))

(fn love.keypressed [key scancode isrepeat]
  (mode-stack.call-on-mode :keypressed {:isrepeat isrepeat
                                        :key key
                                        :mode-stack mode-stack
                                        :scancode scancode}))

(fn love.keyreleased [key scancode]
  (mode-stack.call-on-mode :keypressed {:key key
                                        :mode-stack mode-stack
                                        :scancode scancode}))
