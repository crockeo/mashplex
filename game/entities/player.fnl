(local input (require "game.input"))

(local speed 100)

(var x 100)
(var y 100)
(var sprite nil)

;; Load's the player resources. Namely our cute lil ball friend.
(fn player-load []
  (set sprite (love.graphics.newImage "res/player.png")))

;; Rendering our cute lil ball friend at its coordinates.
(fn player-draw []
  (love.graphics.draw sprite x y))

;; Updating the player.
(fn player-update [dt]
  (let [get-dir (fn [neg-key pos-key]
                  (+ (if (input.is-pressed neg-key)
                         -1
                         0)
                     (if (input.is-pressed pos-key)
                         1
                         0)))]

    (set x (+ x (* dt
                   speed
                   (get-dir "left" "right"))))

    (set y (+ y (* dt
                   speed
                   (get-dir "up" "down"))))))

{:load player-load
 :draw player-draw
 :update player-update}
