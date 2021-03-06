;; inspo/mostly stolen: https://github.com/telent/fenestra/blob/master/main.fnl
;; make fennel more clojure-like

(local lume (require "lib.lume"))

(lambda inc [x] (+ x 1))
(lambda dec [x] (- x 1))

;; fennel's default is identity, not value re: comparing tables
(lambda equal? [a b]
  (if (= (type a) (type b))
      (if (= (type a) "table")
          (and (= (length a) (length b))
               (every (fn [k] (equal? (. a k) (. b k)))
                      (keys a)))
          (= a b))
      false))

(fn assoc [tbl k v ...]
  (tset tbl k v)
  (if ...
      (assoc tbl (unpack [...]))
      tbl))

(lambda assoc-in [tbl path value]
  (let [k (head path)
        r (tail path)]
    (if (empty? r)
        (assoc tbl k value)
        (assoc tbl k (assoc-in (or (. tbl k) {}) r value)))))
