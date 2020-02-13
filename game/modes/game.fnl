(local utils (require "game.utils"))

(local camera (require "game.entities.camera"))
(local player (require "game.entities.player"))
(local tilemap (require "game.entities.tilemap"))

(local world (love.physics.newWorld
              0
              (* 9.81 30)
              true))

(local entities [camera
                 tilemap])

;; Applies a function to each entity in the game.
(fn apply-to-entities [fn-name params]
  (each [_ entity (ipairs entities)]
    (when (. entity fn-name)
      ((. entity fn-name) params))))

;; Constructs a callback that delegates functionality to entities.
(fn make-callback [fn-name game-params]
  (fn [params]
    (apply-to-entities fn-name
                       (utils.union-tables params
                                           game-params))
    true))

{:name :game

 :load (make-callback :load
                      {:entities entities
                       :world world})

 :draw (make-callback :draw
                      {:camera camera})

 :update (make-callback :update
                        {:camera camera})

 :keypressed (make-callback :keypressed
                            {})}
