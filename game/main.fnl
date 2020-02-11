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
        (player.make 100 100)
        (floor-top.make (/ screen-width 2)
                        (- screen-height 16)
                        screen-width
                        32)
        ;; tilemap
        ])

;; Loading resources
(fn love.load []
  (print "starting")
  (: repl :start)
  (each [_ entity (ipairs entities)]
    (entity.load world)))

(fn love.draw []
  (each [_ entity (ipairs entities)]
    (entity.draw)))

(fn love.update [dt]
  (each [_ entity (ipairs entities)]
    (entity.update camera dt))
  (world.update world dt))

(fn love.keypressed [key scancode repeat]
  (each [_ entity (ipairs entities)]
    (entity.keypressed key scancode repeat)))
