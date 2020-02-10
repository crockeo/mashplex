(local fennel (require "lib.fennel"))

(local floor-top (require "game.entities.floor-top"))
(local player (require "game.entities.player"))

(local world (love.physics.newWorld
              0
              (* 9.81 30)
              true))

(local (screen-width screen-height) (love.window.getMode))

(local entities
       [player
        (floor-top.make (/ screen-width 2)
                        (- screen-height 16)
                        screen-width
                        32)])

;; Loading resources
(fn love.load []
  (each [_ entity (ipairs entities)]
    (entity.load world)))

(fn love.draw []
  (each [_ entity (ipairs entities)]
    (entity.draw)))

(fn love.update [dt]
  (each [_ entity (ipairs entities)]
    (entity.update dt))
  (world.update world dt))
