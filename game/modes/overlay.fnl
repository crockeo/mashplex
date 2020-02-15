(local input (require "game.input"))

(var rainbow-shader nil)

(var title-text nil)
(var continue-text nil)

(var after-overlay nil)

(fn overlay-load [params]
  (set rainbow-shader (love.graphics.newShader "res/rainbow.frag"))
  (set continue-text (love.graphics.newText (love.graphics.getFont)
                                            "Press JUMP to continue.")))

(fn overlay-init [params]
  (set title-text (love.graphics.newText (love.graphics.getFont)
                                         params.text))
  (set after-overlay params.after-overlay))

(fn overlay-draw [params]
  (rainbow-shader:send "time" params.time)
  (love.graphics.setShader rainbow-shader)

  (love.graphics.draw title-text

                      (/ params.window-width 2)
                      (/ params.window-height 2)

                      0
                      1 1

                      (/ (title-text:getWidth) 2)
                      (/ (title-text:getHeight) 2))

  (love.graphics.setShader)

  (love.graphics.draw continue-text

                      (/ params.window-width 2)
                      (- params.window-height
                         (/ (continue-text:getHeight) 4)
                         16)

                      0
                      0.6 0.6

                      (/ (continue-text:getWidth) 2)
                      (/ (continue-text:getHeight) 2))

  true)

(fn overlay-update [params]
  false)

(fn overlay-keypressed [params]
  (when (input.is-input params.key "jump")
    (after-overlay params))
  false)

{:name :overlay

 :load overlay-load
 :init overlay-init
 :draw overlay-draw
 :update overlay-update
 :keypressed overlay-keypressed}
