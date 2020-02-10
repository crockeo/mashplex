(local lume (require "lib.lume"))

(local input (require "game.input"))

(local speed 100)
(local jump-impulse 200)

(local x 100)
(local y 100)

(local radius 16)

(var sprite nil)

(var body nil)
(var shape nil)
(var fixture nil)

;; Load's the player resources. Namely our cute lil ball friend.
(fn player-load [world]
  ;; Rendering resources
  (set sprite (love.graphics.newImage "res/player.png"))

  ;; Physics resources
  (set body (love.physics.newBody
             world
             x y
             "dynamic"))

  (set shape (love.physics.newCircleShape 16))

  (set fixture (love.physics.newFixture
                body
                shape))

  (body.setAngularDamping body 1)

  (fixture.setFriction fixture 1.0)
  (fixture.setRestitution fixture 0.3))

;; Rendering our cute lil ball friend at its coordinates.
(fn player-draw []
  (let [(x y) (body.getWorldPoint body (shape.getPoint shape))
        angle (body.getAngle body)
        transform (love.math.newTransform)]
    (transform.translate transform x y)
    (transform.rotate transform angle)
    (transform.translate transform (- radius) (- radius))

    (love.graphics.draw sprite transform)))

;; Updating the player.
(fn player-update [dt]
  (body.applyAngularImpulse body
                            (* speed
                               (input.get-axis "left" "right"))))

;; Returns whether or not the player is actively on the ground.
(fn player-on-ground []
  (lume.reduce
   (lume.map (body.getContacts body)
             (fn [contact]
               (let [(_ dy) (contact.getNormal contact)]
                 (< dy 0))))
   (fn [a b] (or a b))
   false))

;; Performing actions with the player. Like dashing or jumping.
(fn player-keypressed [key scancode repeat]
  (when (and (input.is-input key "jump")
             (player-on-ground))
    (body.applyLinearImpulse body
                             0
                             (- jump-impulse))))

{:load player-load
 :draw player-draw
 :update player-update
 :keypressed player-keypressed}
