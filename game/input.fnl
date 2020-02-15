(local lume (require "lib.lume"))

;; Defining each of our inputs. Designed to have a natural left-handed or right-
;; handed binding.
;;
;; - Right handed: up/left/down/right, z, v
;; - Left Handed: wasd, m, /
;;
;; Additional "space" binding for jump for first-time usability concerns.
(local inputs
       {"up" ["w" "up"]
        "left" ["a" "left"]
        "down" ["s" "down"]
        "right" ["d" "right"]

        "dash" ["v" "m"]

        "jump" ["z" "/" "space"]

        "pause" ["p"]})

;; Checks if a given key is part of an input.
(fn is-input [key input]
  (lume.reduce
   (lume.map (. inputs input) (partial = key))
   (fn [a b] (or a b))
   false))

;; Checks if a given input is pressed by checking against each of the possible
;; keybinds for that input.
(fn is-pressed [input]
  (lume.reduce
   (lume.map (. inputs input) love.keyboard.isDown)
   (fn [a b] (or a b))
   false))

;; Returns the axis defined by a negative and positive key. Designed so that
;; when both the negative and positive are held down, there is no movement.
(fn get-axis [neg-key pos-key]
  (+ (if (is-pressed neg-key)
         -1
         0)
     (if (is-pressed pos-key)
         1
         0)))

{:is-input is-input
 :is-pressed is-pressed
 :get-axis get-axis}
