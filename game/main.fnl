(local fennel (require "lib.fennel"))

(local player (require "game.entities.player"))

(local world (love.physics.newWorld
              0
              (* 9.81 30)
              true))

(local entities [player])

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
