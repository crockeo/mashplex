
;; note: took a tileset from https://rpg.hamsterrepublic.com/ohrrpgce/Free_Tilemaps
(local lume (require "lib.lume"))
(local sti (require "lib.sti"))

(local player (require "game.entities.player"))

(var map nil)

;; Finds an individual object by name in a collection of Tiled objects.
(fn find-named-object [objs name]
  (. (lume.filter
      objs
      (fn [obj] (= obj.name name))) 1))

;; Returns the player's start position from the Tiled map.
(fn get-start-position []
  (let [spawn (find-named-object map.layers.Player.objects "Spawn")]
    (values spawn.x spawn.y)))

(fn tiled-load [params]
  (set map (sti "res/map/level.lua"
                ["box2d"]))

  (let [(px py) (get-start-position)]
    (table.insert params.entities
                  (player.make px py)))

  (map:removeLayer "Player")

  (map:box2d_init params.world))

(fn tiled-draw [params]
  (map.draw map
            (- (/ params.window-width 2) (params.camera.getX))
            (- (/ params.window-height 2) (params.camera.getY)))

  (when params.debug
    (love.graphics.setColor 1 0 0)
    (map:box2d_draw)
    (love.graphics.setColor 1 1 1)))

(fn tiled-update [params]
  (map:update params.dt))

{:load tiled-load
 :draw tiled-draw
 :update tiled-update
 :keypressed (fn [])}
