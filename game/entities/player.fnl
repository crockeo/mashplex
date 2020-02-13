(local lume (require "lib.lume"))

(local input (require "game.input"))

(fn make [x y]
  (local speed 100)
  (local jump-impulse 200)

  (local radius 16)

  (var sprite nil)

  (var body nil)
  (var shape nil)
  (var fixture nil)

  ;; Generating the rays that we use to check if we're actively on the ground.
  (fn player-ground-rays []
    (let [ray-count 5
          margin-mul 1.35

          (x y) (body:getWorldPoint (shape:getPoint))

          min-angle (/ (* 5 math.pi) 4)
          max-angle (/ (* 7 math.pi) 4)
          step (/ (- max-angle min-angle) (- ray-count 1))

          rays []]

      (for [i 0 (- ray-count 1)]
        (local angle (+ min-angle (* i step)))

        (table.insert rays
                      [x y
                       (- x (* radius margin-mul (math.cos angle)))
                       (- y (* radius margin-mul (math.sin angle)))]))

      rays))

  ;; Load's the player resources. Namely our cute lil ball friend.
  (fn player-load [params]
    ;; Rendering resources
    (set sprite (love.graphics.newImage "res/player.png"))

    ;; Physics resources
    (set body (love.physics.newBody
               params.world
               (+ x radius)
               (+ y radius)
               "dynamic"))

    (set shape (love.physics.newCircleShape 16))

    (set fixture (love.physics.newFixture
                  body
                  shape))

    (body.setAngularDamping body 1)

    (fixture.setFriction fixture 5.0)
    (fixture.setRestitution fixture 0.3))

  ;; Rendering our cute lil ball friend at its coordinates.
  (fn player-draw [params]
    (let [(x y) (body.getWorldPoint body (shape.getPoint shape))
          angle (body.getAngle body)
          transform (love.math.newTransform)]
      (transform.translate transform x y)
      (transform.rotate transform angle)
      (transform.translate transform (- radius) (- radius))

      (love.graphics.draw sprite transform))

    (when debug-mode
      (local rays (player-ground-rays))

      (love.graphics.setColor 1 0 0)
      (each [_ ray (ipairs rays)]
        (local (x1 y1 x2 y2) (unpack ray))

        (love.graphics.line x1 y1 x2 y2))
      (love.graphics.setColor 1 1 1)))

  ;; Returns whether or not the player is actively on the ground.
  (fn player-on-ground []
    (lume.reduce
     (lume.map (player-ground-rays)
               (fn [rays]
                 (let [(x1 y1 x2 y2) (unpack rays)
                       world (body:getWorld)]

                   (var on-ground false)
                   (world:rayCast x1 y1 x2 y2
                                  (fn [other-fixture x y nx ny fraction]
                                    (when (and (~= other-fixture fixture)
                                               (< ny 0))
                                      (set on-ground true))
                                    0))
                   on-ground)))
     (fn [a b] (or a b))
     false))

  ;; Updating the player.
  (fn player-update [params]
    (let [axis (input.get-axis "left" "right")]
      (when (not (player-on-ground))
        (body.applyForce body
                         (* speed
                            axis)
                         0))

      (body.applyAngularImpulse body
                                (* speed axis)))

    (let [(x y) (body.getWorldPoint body (shape.getPoint shape))]
      (params.camera.set-target (+ x radius) (+ y radius))))

  ;; Performing actions with the player. Like dashing or jumping.
  (fn player-keypressed [params]
    (when (and (input.is-input params.key "jump")
               (player-on-ground))
      (body.applyLinearImpulse body
                               0
                               (- jump-impulse))))

  {:load player-load
   :draw player-draw
   :update player-update
   :keypressed player-keypressed})

{:make make}
