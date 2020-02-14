(local levels [(require "game.levels.demo")
               (require "game.levels.demo2")])

(fn get-level [index]
  (. levels index))

{:get-level get-level}
