(fn pause-draw []
  true)

(fn pause-update [params]
  false)

(fn pause-keypressed [params]
  (when (= params.key "p")
    (params.mode-stack.pop-mode))

  false)

{:name :pause

 :draw pause-draw
 :update pause-update
 :keypressed pause-keypressed}
