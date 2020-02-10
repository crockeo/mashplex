(local fennel (require "lib.fennel"))
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

        "jump" ["z" "/" "space"]})

;; Checks if a given input is pressed by checking against each of the possible
;; keybinds for that input.
(fn is-pressed [input]
  (lume.reduce
   (lume.map (. inputs input) love.keyboard.isDown)
   (fn [i1 i2]
     (or i1 i2))
   false))

(local circle-radius 5)
(local speed 100)
(var x 100)
(var y 100)

;; Drawing our little circle friend
(fn love.draw []
  (love.graphics.circle
   "fill"
   x
   y
   circle-radius))

;; Getting the direction on a given axis
(fn get-dir [neg-key pos-key]
  (+ (if (is-pressed neg-key)
         -1
         0)
     (if (is-pressed pos-key)
         1
         0)))

;; Moving him around :)
(fn love.update [dt]
  (set x (+ x
            (* dt
               speed
               (get-dir "left" "right"))))

  (set y (+ y
            (* dt
               speed
               (get-dir "up" "down")))))
