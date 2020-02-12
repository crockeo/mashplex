(local input (require "game.input"))

(local button-count 3)
(var selected-button 0)

(fn menu-load [])

(fn menu-init []
  (set selected-button 0))

(fn menu-draw []
  (love.graphics.print
   (string.format "%d" selected-button)
   10 10))

(fn menu-keypressed [params]
  (local inputs {"up" -1
                 "down" 1})

  (each [input-name dir (pairs inputs)]
    (when (input.is-input params.key input-name)
      (set selected-button (% (+ selected-button dir) button-count))))

  (when (input.is-input params.key "jump")
    (params.mode-stack.set-mode :init)))

{:name :menu

 :load menu-load
 :init menu-init
 :draw menu-draw
 :keypressed menu-keypressed}
