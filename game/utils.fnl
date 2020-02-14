;; Function that checks types when debugging is enabled.
(fn check-type [value expected-type allow-nil]
  (when debug-mode
    (assert (or (and allow-nil
                     (= value nil))
                (= (type value) expected-type)))))

;; Prints out a table's key/value pairs
(fn print-table [t]
  (check-type t "table")
  (each [key value (pairs t)]
    (print key value)))

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

  (each [_ t (pairs ts)]
    (let [callback (. t callback-name)]
      (when callback
        (callback (unpack [...]))))))

;; Simple rounding function.
(fn round [num]
  (if (>= (- num (math.floor num)) 0.5)
      (math.ceil num)
      (math.floor num)))

{:check-type check-type
 :print-table print-table
 :union-tables union-tables
 :call-on call-on
 :round round}
