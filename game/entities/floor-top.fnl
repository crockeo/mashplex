; Constructs an instance of a floor tile at a particular initial location.
(fn make-floor-top [x y width height]
  (local quad
         (love.graphics.newQuad 0 0 width height 32 32))

  (var sprite nil)

  (var body nil)
  (var shape nil)
  (var fixture nil)

  (fn floor-top-load [world]
    ;; Rendering resources
    (set sprite (love.graphics.newImage "res/floor_top.png"))

    ;; physics resources
    (set body (love.physics.newBody
               world
               x y
               "static"))

    (set shape (love.physics.newRectangleShape width height))

    (set fixture (love.physics.newFixture
                  body
                  shape))

    (fixture.setFriction fixture 1.0))

  (fn floor-top-draw [camera]
    (let [(x y) (body.getWorldPoints body (shape.getPoints shape))]
      (love.graphics.draw sprite
                          quad
                          x
                          y)))

  {:load floor-top-load
   :draw floor-top-draw
   :update (fn [])
   :keypressed (fn [])})

{:make make-floor-top}
