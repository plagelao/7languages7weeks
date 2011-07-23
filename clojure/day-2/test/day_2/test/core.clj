(ns day-2.test.core
  (:use [day-2.core] :reload)
  (:use [clojure.test]))

(deftest unless-with-else
  (is (unless true false true)))
(deftest unless-only
  (is (unless false true false)))

(deftest type-and-protocol
  (is (= "Why?" (rant (troll)))))
