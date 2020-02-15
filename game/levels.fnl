(local levels [(require "game.levels.demo")
               (require "game.levels.demo2")
               (require "game.levels.tutorial")])

(fn get-level [index]
  (. levels index))

(fn get-level-count []
  (length levels))

{:get-level get-level
 :get-level-count get-level-count}
