(local camera (require "game.entities.camera"))

(local floor-top (require "game.entities.floor-top"))
(local player (require "game.entities.player"))
(local tilemap (require "game.entities.tilemap"))

(local world (love.physics.newWorld
              0
              (* 9.81 30)
              true))

(local (screen-width screen-height) (love.window.getMode))

(local entities
       [camera
        tilemap])

(fn init-load [params]
  (each [_ entity (ipairs entities)]
    (entity.load {"entities" entities
                  "world" world})))

(fn init-draw []
  (each [_ entity (ipairs entities)]
    (entity.draw {"camera" camera
                  "debug" false
                  "screen-height" screen-height
                  "screen-width" screen-width})))

(fn init-update [params]
  (each [_ entity (ipairs entities)]
    (entity.update {"camera" camera
                    "dt" params.dt}))
  (world.update world params.dt)
  true)

(fn init-keypressed [params]
  (when (= params.key "p")
    (params.mode-stack.push-mode :pause))

  (each [_ entity (ipairs entities)]
    (entity.keypressed params)))

{:name "init"

 :load init-load
 :draw init-draw
 :update init-update
 :keypressed init-keypressed}
