(local fennel (require "lib.fennel"))

(local player (require "game.entities.player"))

(local entities [player])

;; Loading resources
(fn love.load []
  (each [_ entity (ipairs entities)]
    (entity.load)))

(fn love.draw []
  (each [_ entity (ipairs entities)]
    (entity.draw)))

(fn love.update [dt]
  (each [_ entity (ipairs entities)]
    (entity.update dt)))
