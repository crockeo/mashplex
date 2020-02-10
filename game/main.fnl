(local fennel (require "lib.fennel"))

(local input (require "game.input"))

(local circle-radius 5)
(local speed 100)
(var x 100)
(var y 100)

(var player-sprite nil)

;; Loading resources
(fn love.load []
  (set player-sprite (love.graphics.newImage "res/player.png")))

;; Drawing our little circle friend
(fn love.draw []
  (love.graphics.draw player-sprite x y))

;; Getting the direction on a given axis
(fn get-dir [neg-key pos-key]
  (+ (if (input.is-pressed neg-key)
         -1
         0)
     (if (input.is-pressed pos-key)
         1
         0)))

;; Moving him around :)
(fn love.update [dt]
  (set x (+ x
            (* dt
               speed
               (get-dir "left" "right"))))

  (set y (+ y
            (* dt
               speed
               (get-dir "up" "down")))))
