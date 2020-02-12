(fn pause-update [params]
  false)

(fn pause-keypressed [params]
  (when (= params.key "p")
    (params.mode-stack.pop-mode))

  false)

{:name :pause

 :update pause-update
 :keypressed pause-keypressed}
