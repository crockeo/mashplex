(local utils (require "game.utils"))

(local camera (require "game.entities.camera"))
(local player (require "game.entities.player"))
(local tilemap (require "game.entities.tilemap"))

(local world (love.physics.newWorld
              0
              (* 9.81 30)
              true))

(var entities [])

(fn game-init [params]
  (set entities [camera tilemap])

  (utils.call-on entities
                 :load
                 (utils.union-tables params
                                     {:entities entities
                                      :world world})))

(fn game-draw [params]
  (utils.call-on entities
                 :draw
                 (utils.union-tables params
                                     {:camera camera})))

(fn game-update [params]
  (utils.call-on entities
                 :update
                 (utils.union-tables params
                                     {:camera camera
                                      :world world}))
  (world:update params.dt))

(fn game-keypressed [params]
  (utils.call-on entities
                 :keypressed
                 params))


{:name :game

 :init game-init
 :draw game-draw
 :update game-update
 :keypressed game-keypressed}
