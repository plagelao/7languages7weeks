(ns day-1.test.core
  (:use [day-1.core] :reload)
  (:use [clojure.test]))

(deftest str-bigger-than-n
  (is (big "a string" 5)))
(deftest str-smaller-than-n
  (is (not (big "a string" 8))))
(deftest collection-is-a-list
  (is (= :list (collection-type '(1 2)))))
(deftest collection-is-a-map
  (is (= :map (collection-type {1 2}))))
(deftest collection-is-a-vector
  (is (= :vector (collection-type [1 2]))))
