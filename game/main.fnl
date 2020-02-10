(local fennel (require "lib.fennel"))

(local circle-radius 5)
(local speed 100)
(var x 100)
(var y 100)

;; Drawing our little circle friend
(fn love.draw []
  (love.graphics.circle
   "fill"
   x
   y
   circle-radius))

;; Getting the direction on a given axis
(fn get-dir [neg-key pos-key]
  (+ (if (love.keyboard.isDown neg-key)
         -1
         0)
     (if (love.keyboard.isDown pos-key)
         1
         0)))

;; Moving him around :)
(fn love.update [dt]
  (set x (+ x
            (* dt
               speed
               (get-dir "a" "d"))))

  (set y (+ y
            (* dt
               speed
               (get-dir "w" "s")))))
