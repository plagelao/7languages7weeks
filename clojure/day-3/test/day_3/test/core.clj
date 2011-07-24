(ns day-3.test.core
  (:use [day-3.core] :reload)
  (:use [clojure.test]))

(deftest account-has-balance
  (is (= 50 (:balance account 50))))
(deftest can-add-money-to-an-account
  (is (= 100 (:balance (credit (account 50) 50)))))
(deftest can-substract-money-to-an-account
  (is (= 0 (:balance (debit (account 50) 50)))))
(deftest accounts-has-one-account
  (is (= 1 (count @accounts))))
(deftest account-balance-is-150-if-we-add-100
  (is (= 150 (:balance (first (add-money 100))))))
(deftest account-balance-is-0-if-we-substract-150
  (is (= 0 (:balance (first (substract-money 150))))))
