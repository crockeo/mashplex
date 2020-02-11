
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

{:load tiled-load
 :draw tiled-draw
 :update tiled-update
 :keypressed (fn [key scancode repeat])
 ;; :set-target camera-set-target
 }
