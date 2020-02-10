(local input (require "game.input"))

(local speed 100)

(var x 100)
(var y 100)
(var sprite nil)

(local world (love.physics.newWorld
              0
              (* 9.81 30)
              true))

(local body (love.physics.newBody
             world
             x y
             "dynamic"))

(local shape (love.physics.newCircleShape 16))

(local fixture (love.physics.newFixture
                body
                shape))

;; Load's the player resources. Namely our cute lil ball friend.
(fn player-load []
  (set sprite (love.graphics.newImage "res/player.png")))

;; Rendering our cute lil ball friend at its coordinates.
(fn player-draw []
  (let [(x y) (body.getWorldPoint body (shape.getPoint shape))]
    (love.graphics.draw sprite x y)))

;; Updating the player.
(fn player-update [dt]
  (let [get-dir (fn [neg-key pos-key]
                  (+ (if (input.is-pressed neg-key)
                         -1
                         0)
                     (if (input.is-pressed pos-key)
                         1
                         0)))]

    (body.applyForce body
                     (* speed
                        (get-dir "left" "right"))
                     (* speed
                        (get-dir "up" "down"))))

  (world.update world dt))

{:load player-load
 :draw player-draw
 :update player-update}
