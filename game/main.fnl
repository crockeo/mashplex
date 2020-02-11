(local fennel (require "lib.fennel"))
(local repl (require "lib.stdio"))

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

(fn love.load []
  (: repl :start)
  (each [_ entity (ipairs entities)]
    (entity.load {"entities" entities
                  "world" world})))

(fn love.draw []
  (each [_ entity (ipairs entities)]
    (entity.draw {"camera" camera
                  "screen-height" screen-height
                  "screen-width" screen-width})))

(fn love.update [dt]
  (each [_ entity (ipairs entities)]
    (entity.update {"camera" camera
                    "dt" dt}))
  (world.update world dt))

(fn love.keypressed [key scancode repeat]
  (each [_ entity (ipairs entities)]
    (entity.keypressed {"key" key
                        "repeat" repeat
                        "scancode" scancode})))
