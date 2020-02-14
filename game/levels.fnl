(local levels [(require "game.levels.demo")
               (require "game.levels.demo2")
               (require "game.levels.tutorial")])

(fn get-level [index]
  (. levels index))

{:get-level get-level}
