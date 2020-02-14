(local levels [(require "game.levels.demo")])

(fn get-level [index]
  (. levels index))

{:get-level get-level}
