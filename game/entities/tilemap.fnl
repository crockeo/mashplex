
;; note: took a tileset from https://rpg.hamsterrepublic.com/ohrrpgce/Free_Tilemaps

(local sti (require "lib.sti"))


(local map (sti "res/map/level.lua"
                  ;; { "box2d" }
                  ))

(fn tiled-load [world]
  ;; (map.box2d_init world)
  )

(fn tiled-draw [world]
  (map.draw)
  )

(fn tiled-update [dt]
  (map.update dt)
  )

{:load tiled-load
 :draw tiled-draw
 :update tiled-update
 :keypressed (fn [key scancode repeat])
 ;; :set-target camera-set-target
 }
