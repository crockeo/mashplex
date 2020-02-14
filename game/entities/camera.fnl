(local lume (require "lib.lume"))

;; The speed at which the camera goes towards the target. If the math is right
;; in camera-update, it should take (1/lerp-rate) seconds to go from any
;; location to the new location.
(local lerp-rate 8)

;; Denotes the first movement of the camera. Used to move directly to the
;; player when it's spawned.
(var first true)

;; The location of the camera.
(var x 0)
(var y 0)

;; The target location of the camera. The current location automatically moves
;; towards the target location.
(var target-x 0)
(var target-y 0)

;; Sets the target of the camera.
(fn camera-set-target [tx ty immediate]
  (set target-x tx)
  (set target-y ty)

  (when (or first immediate)
    (set x target-x)
    (set y target-y))

  (set first false))

;; Moves the global coordinate space to the location of the camera at each tick.
(fn camera-draw [params]
  (love.graphics.origin)
  (love.graphics.translate (+ (- x) (/ params.window-width 2))
                           (+ (- y) (/ params.window-height 2))))

;; LERPs the camera towards the targeted location.
(fn camera-update [params]
  (set x (lume.lerp x target-x (* lerp-rate params.dt)))
  (set y (lume.lerp y target-y (* lerp-rate params.dt))))

{:load (fn [])
 :draw camera-draw
 :update camera-update
 :keypressed (fn [])

 :set-target camera-set-target

 :getX (fn [] x)
 :getY (fn [] y)}
