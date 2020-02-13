;; Unions a series of tables. When multiple tables have the same keys, the
;; function prefers values in later tables.
(fn union-tables [...]
  (local union {})

  (each [_ t (ipairs [...])]
    (each [key value (pairs t)]
      (tset union key value)))

  union)

{:union-tables union-tables}
