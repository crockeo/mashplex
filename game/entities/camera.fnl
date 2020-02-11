(local lume (require "lib.lume"))

(local (screen-width screen-height) (love.window.getMode))

;; The speed at which the camera goes towards the target. If the math is right
;; in camera-update, it should take (1/lerp-rate) seconds to go from any
;; location to the new location.
(local lerp-rate 8)

;; The location of the camera.
(var x 0)
(var y 0)

;; The target location of the camera. The current location automatically moves
;; towards the target location.
(var target-x 0)
(var target-y 0)

;; Sets the target of the camera.
(fn camera-set-target [tx ty]
  (set target-x tx)
  (set target-y ty))

;; Moves the global coordinate space to the location of the camera at each tick.
(fn camera-draw [camera]
  (love.graphics.origin)
  (love.graphics.translate (+ (- x) (/ screen-width 2))
                           (+ (- y) (/ screen-height 2))))

;; LERPs the camera towards the targeted location.
(fn camera-update [_ dt]
  (set x (lume.lerp x target-x (* lerp-rate dt)))
  (set y (lume.lerp y target-y (* lerp-rate dt))))

{:load (fn [])
 :draw camera-draw
 :update camera-update
 :keypressed (fn [key scancode repeat])

 :set-target camera-set-target

 :getX (fn [] x)
 :getY (fn [] y)}
