(local input (require "game.input"))
(local levels (require "game.levels"))
(local tiled-util (require "game.tiled-util"))
(local utils (require "game.utils"))

(local camera (require "game.entities.camera"))
(local player (require "game.entities.player"))
(local tilemap (require "game.entities.tilemap"))

(local world (love.physics.newWorld
              0
              (* 9.81 30)
              true))

(var entities {})
(var level-index nil)

;; Possible state transitions. Each of them are an overlay that goes on top of
;; the game.
(fn game-pause [params]
  (params.mode-stack.push-mode
   :overlay
   {:text "Paused"
    :after-overlay (fn [] (params.mode-stack.pop-mode))}))

(fn game-win [params]
  (params.mode-stack.push-mode
   :overlay
   {:text "You Win!"
    :after-overlay (fn []
                     (if (> (+ level-index 1) (levels.get-level-count))
                         (do) ; TODO: What shouls happen when we're at the end of the road?
                         (params.mode-stack.set-mode :game
                                                     {:level (+ level-index 1)})))}))

(fn game-lose [params]
  (params.mode-stack.push-mode
   :overlay
   {:text "You Lose :("
    :after-overlay (fn []
                     (params.mode-stack.set-mode :game
                                                 {:level level-index}))}))

;; Lifecycle listeners
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
                                     {:camera camera}))
  (love.graphics.origin)

  true)

(fn game-update [params]
  (utils.call-on entities
                 :update
                 (utils.union-tables params
                                     {:camera camera
                                      :world world}))

  (let [(x y) (entities.player.get-pos)
        properties (tiled-util.get-occupied-flags (entities.tilemap.get-map)
                                                  "Foreground"
                                                  x y
                                                  (entities.player.get-radius))]
    (match properties
      {:win true} (game-win params)
      {:die true} (game-lose params)))

  (world:update params.dt))

(fn game-keypressed [params]
  (utils.call-on entities
                 :keypressed
                 params)

  (when (input.is-input params.key "pause")
    (game-pause params)))


{:name :game

 :init game-init
 :draw game-draw
 :update game-update
 :keypressed game-keypressed}
