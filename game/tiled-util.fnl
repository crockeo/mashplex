(local utils (require "game.utils"))

;; Returns each of the tiles that a player occupies under a Tiled map, as loaded
;; by STI.
(fn get-occupied-tiles [map layer-name x y radius]
  (let [tx (/ x map.tilewidth)
        ty (/ y map.tileheight)

        tw (/ radius map.tilewidth)
        th (/ radius map.tileheight)

        margin 0.1

        top (+ ty (* th margin))
        bottom (+ ty (* (- 2 margin) th))
        left tx
        right (+ tx (* (- 2 margin) tw))]

    (local tiles [])

    (for [col (utils.round left) (utils.round right)]
      (for [row (utils.round top) (utils.round bottom)]
        (let [tile (. map "layers" layer-name "data" row col)]
          (when tile
            (table.insert tiles {:col col
                                 :row row
                                 :width tile.width
                                 :height tile.height
                                 :properties tile.properties})))))

    tiles))

;; Returns a set of the boolean properties occupied by the player. Used to
;; perform game logic about hitting into spikes / finishing a level.
(fn get-occupied-flags [map layer-name x y radius]
  (let [occupied-tiles (get-occupied-tiles map layer-name x y radius)
        properties {}]
    (each [_ tile (ipairs occupied-tiles)]
      (each [key value (pairs tile.properties)]
        (when (and (= (type value) "boolean")
                   value)
          (tset properties key true))))
    properties))

{:get-occupied-tiles get-occupied-tiles
 :get-occupied-flags get-occupied-flags}
