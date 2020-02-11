
;; note: took a tileset from https://rpg.hamsterrepublic.com/ohrrpgce/Free_Tilemaps
(local lume (require "lib.lume"))
(local sti (require "lib.sti"))

(var map nil)

(fn tiled-load [params]
  (set map (sti "res/map/level.lua"
              ;; { "box2d" }
              )))

(fn tiled-draw [params]
  (map.draw map
            (- (params.camera.getX))
            (- (params.camera.getY))))

(fn tiled-update [params]
  (map:update params.dt))

;; Finds an individual object by name in a collection of Tiled objects.
(fn find-named-object [objs name]
  (. (lume.filter
      objs
      (fn [obj] (= obj.name name))) 1))

;; Returns the player's start position from the Tiled map.
(fn get-start-position []
  (let [spawn (find-named-object map.layers.Player.objects "Spawn")]
    (values spawn.x spawn.y)))

{:load tiled-load
 :draw tiled-draw
 :update tiled-update
 :keypressed (fn [])

 :get-start-position get-start-position}
