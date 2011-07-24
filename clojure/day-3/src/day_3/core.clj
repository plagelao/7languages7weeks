(ns day-3.core)

(defprotocol Account
  (debit [this quantity])
  (credit [this quantity]))

(defrecord BankAccount [balance]
  Account
  (debit [this quantity]
    (BankAccount. (- balance quantity)))
  (credit [this quantity]
    (BankAccount. (+ balance quantity))))

(defn account [balance] (BankAccount. balance))
(def accounts (ref [(account 50)]))
(defn add-money [amount]
  (dosync (ref-set accounts (map (fn [a] (credit a amount)) @accounts))),
  @accounts)
(defn substract-money [amount]
  (dosync (ref-set accounts (map (fn [a] (debit a amount)) @accounts))),
  @accounts)
