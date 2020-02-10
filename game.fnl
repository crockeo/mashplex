#!/usr/bin/env fennel

(local fennel (require "lib.fennel"))
;; (local sti (require "lib.sti"))
;; (local fun (require "lib.fun"))

(local circle-radius 5)
(local speed 100)

(fn assoc [tbl k v ...]
  (tset tbl k v)
  (if ...
      (assoc tbl (unpack [...]))
      tbl))

;; game state

;; get something from a table:
;; (. {:a 1} :a)
(local colemak-p true)

;; pass keys
(local state
       {
        :controls
        {:up (if colemak-p "w" "w")
         :down (if colemak-p "r" "s")
         :left (if colemak-p "a" "a")
         :right (if colemak-p "s" "d")
         }
        :position
        {:x 100
         :y 100
         }})

;; Drawing our little circle friend
(fn love.draw []
  (love.graphics.circle
   "fill"
   (. state :position :x)
   (. state :position :y)
   circle-radius
   ))

;; Getting the direction on a given axis
(fn get-dir [neg-key pos-key]
  (+ (if (love.keyboard.isDown neg-key)
         -1
         0)
     (if (love.keyboard.isDown pos-key)
         1
         0)))

;; Moving him around :)
(fn love.update [dt]
  (tset state :position :x
       (+ (. state :position :x)
            (* dt
               speed
               (get-dir
                (. state :controls :left)
                (. state :controls :right)
                ;; "a" "d"
                ))))

  (tset state :position :y
       (+ (. state :position :y)
            (* dt
               speed
               (get-dir
                ;; "w"
                (. state :controls :up)
                (. state :controls :down)
                ;; "s"
                )))))
