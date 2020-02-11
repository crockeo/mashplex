
;; note: took a tileset from https://rpg.hamsterrepublic.com/ohrrpgce/Free_Tilemaps

(local sti (require "lib.sti"))

(var map nil)

(fn tiled-load []
  (set map (sti "res/map/level.lua"
              ;; { "box2d" }
              )))

(fn tiled-draw [camera]
  (map.draw map
            (- (camera.getX))
            (- (camera.getY))))

(fn tiled-update [camera dt]
  ;; (: map :draw) is identical to (map.draw map)
  (: map :update dt)
  )

;; Returns the player's start position from the Tiled map.
;;
;; TODO: Let's try to make this less brittle. I have a feeling that indexing on
;;       unnamed layers is probably going to break it.
(fn get-start-position []
  (let [player-obj (. map.layers 2 "objects" 1)]
    (values (. player-obj "x") (. player-obj "y"))))

{:load tiled-load
 :draw tiled-draw
 :update tiled-update
 :keypressed (fn [key scancode repeat])

 :get-start-position get-start-position}
