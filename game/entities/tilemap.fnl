(local lume (require "lib.lume"))
(local sti (require "lib.sti"))

;; Finds an individual object by name in a collection of Tiled objects.
(fn find-named-object [objs name]
  (. (lume.filter
      objs
      (fn [obj] (= obj.name name))) 1))

;; Constructs a tilemap from a given level.
(fn tilemap-make [level]
  (var map nil)

  (fn tilemap-init [params]
    (set map (sti level.path ["box2d"]))
    (map:box2d_init params.world))

  (fn tilemap-draw [params]
    (map:draw (- (/ params.window-width 2) (params.camera.getX))
              (- (/ params.window-height 2) (params.camera.getY)))

    (when debug-mode
      (love.graphics.setColor 1 0 0)
      (map:box2d_draw)
      (love.graphics.setColor 1 1 1)))

  (fn tilemap-update [params]
    (map:update params.dt))

  (fn player-start-position []
    (let [spawn (find-named-object map.layers.Player.objects "Spawn")]
      (values spawn.x spawn.y)))

  {:init tilemap-init
   :draw tilemap-draw
   :update tilemap-update

   :player-start-position player-start-position})

{:make tilemap-make}
