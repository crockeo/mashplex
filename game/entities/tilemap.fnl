
;; note: took a tileset from https://rpg.hamsterrepublic.com/ohrrpgce/Free_Tilemaps

(local sti (require "lib.sti"))


(fn tiled-load [world]
  (local map (sti "res/tiled_map.lua" { "box2d" }))
  (map.box2d_init world)
  )

(fn tiled-draw [world]
  )

(fn tiled-update [world]
  (map.update world)
  )

{:load tiled-load
 :draw tiled-draw
 :update
 tiled-update
 :keypressed (fn [key scancode repeat])
 ;; :set-target camera-set-target
 }
