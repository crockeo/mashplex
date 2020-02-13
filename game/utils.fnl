;; Function that checks types when debugging is enabled.
(fn check-type [value expected-type allow-nil]
  (when debug-mode
    (assert (or (and allow-nil
                     (= value nil))
                (= (type value) expected-type)))))

;; Unions a series of tables. When multiple tables have the same keys, the
;; function prefers values in later tables.
(fn union-tables [...]
  (local union {})

  (each [_ t (ipairs [...])]
    (each [key value (pairs t)]
      (tset union key value)))

  union)

;; Calls a function on a series of tables, if the function exists in them. Also
;; accepts a variadic number of parameters, which are passed into the function.
(fn call-on [ts callback-name ...]
  (check-type ts "table")
  (check-type callback-name "string")

  (each [_ t (ipairs ts)]
    (let [callback (. t callback-name)]
      (when callback
        (callback (unpack [...]))))))

{:union-tables union-tables
 :call-on call-on}
