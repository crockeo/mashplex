(local utils (require "game.utils"))

(local camera (require "game.entities.camera"))
(local levels (require "game.levels"))
(local player (require "game.entities.player"))
(local tilemap (require "game.entities.tilemap"))

(local world (love.physics.newWorld
              0
              (* 9.81 30)
              true))

(var entities {})
(var level-index nil)

(fn game-init [params]
  (set level-index params.level)

  (set entities {:camera camera
                 :tilemap (tilemap.make (levels.get-level params.level))
                 :player (player.make 0 0)})

  (utils.call-on entities
                 :init
                 (utils.union-tables params
                                     {:entities entities
                                      :world world}))

  (let [(x y) (entities.tilemap.player-start-position)]
    (entities.player.set-pos x y)))

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
