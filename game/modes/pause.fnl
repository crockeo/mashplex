(var rainbow-shader nil)
(var pause-text nil)

(fn pause-load []
  (set rainbow-shader (love.graphics.newShader "res/rainbow.frag"))

  (set pause-text (love.graphics.newText
                   (love.graphics.getFont)
                   "p a u s e d")))

(fn pause-draw [params]
  (rainbow-shader:send "time" params.time)
  (love.graphics.setShader rainbow-shader)

  (love.graphics.draw pause-text

                      (/ params.window-width 2)
                      (/ params.window-height 2)

                      0
                      1 1

                      (/ (pause-text:getWidth) 2)
                      (/ (pause-text:getHeight) 2))

  (love.graphics.setShader)

  true)

(fn pause-update [params]
  false)

(fn pause-keypressed [params]
  (when (= params.key "p")
    (params.mode-stack.pop-mode))

  false)

{:name :pause

 :load pause-load
 :draw pause-draw
 :update pause-update
 :keypressed pause-keypressed}
