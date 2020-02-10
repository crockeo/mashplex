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
                  shape)))

  (fn floor-top-draw []
    (let [(x y) (body.getWorldPoints body (shape.getPoints shape))]
      (love.graphics.draw sprite
                          quad
                          x
                          y)))

  (fn floor-top-update [dt])

  {:load floor-top-load
   :draw floor-top-draw
   :update floor-top-update})

{:make make-floor-top}
