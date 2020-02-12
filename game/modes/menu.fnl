(local input (require "game.input"))

(local player-scale 6)
(local player-rotation-rate (/ math.pi 8))

(var rainbow-shader nil)

(var player-sprite nil)
(var player-rotation 0)

(var title nil)
(var subtitle nil)

(fn menu-load []
  (set rainbow-shader (love.graphics.newShader "res/rainbow.frag"))

  (set player-sprite (love.graphics.newImage "res/player.png"))

  (set title (love.graphics.newText
              (love.graphics.getFont)
              "m a s h p l e x"))

  (set subtitle (love.graphics.newText
                 (love.graphics.getFont)
                 "press JUMP to start")))

(fn menu-init [])

(fn menu-draw [params]
  (let [(width height) (player-sprite:getDimensions)]
    (love.graphics.draw player-sprite

                        (/ params.window-width 2)
                        0

                        player-rotation

                        player-scale
                        player-scale

                        (* width 0.5)
                        (* height 0.5)))

  (rainbow-shader:send "time" params.time)
  (love.graphics.setShader rainbow-shader)
  (let [scale (+ 1
                 (/ (math.sin (* (love.timer.getTime) math.pi)) 4))

        rotation (* 0.1 math.pi (math.sin (* (love.timer.getTime) 2)))]
    (love.graphics.draw title

                        (/ params.window-width 2)
                        (/ params.window-height 2)

                        rotation

                        scale scale

                        (/ (title:getWidth) 2)
                        (/ (title:getHeight) 2)))
  (love.graphics.setShader)

  (love.graphics.draw subtitle

                      (/ params.window-width 2)
                      (- params.window-height 16)

                      0

                      0.6 0.6

                      (/ (subtitle:getWidth) 2)
                      (subtitle:getHeight)))

(fn menu-update [params]
  (set player-rotation (+ player-rotation (* player-rotation-rate params.dt))))

(fn menu-keypressed [params]
  (when (input.is-input params.key "jump")
    (params.mode-stack.set-mode :init)))

{:name :menu

 :load menu-load
 :init menu-init
 :draw menu-draw
 :update menu-update
 :keypressed menu-keypressed}
