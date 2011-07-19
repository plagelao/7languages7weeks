(ns day-1.core)
(defn big [str n] (> (count str) n))
(defn collection-type [col]
  (cond (= clojure.lang.PersistentList (class col)) :list
        (= clojure.lang.PersistentArrayMap (class col)) :map
        (= clojure.lang.PersistentVector (class col)) :vector))
