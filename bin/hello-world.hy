#!/usr/bin/env hy

;; ## Basics

(print "Hello world")

;; ### variable setting

(setv zone-plane 8)
(setv fruit ["apple" "banana" "cantaloupe"])
(print (get fruit 0))  ; => apple
(setv (get fruit 1) "durian")
(print (get fruit 1))  ; => durian
(print (cut "abcdef" 1 4))  ; => bcd

;; ### IF-THEN

(if (= 1 1)
  (print "Math works. The universe is safe.")
  (print "Math has failed. The universe is doomed."))
;; IF-THEN-ELSE
(if (do (print "Let's check.") (= 1 1))
  (do
    (print "Math works.")
    (print "The universe is safe."))
  (do
    (print "Math has failed.")
    (print "The universe is doomed.")))
;; ### COND
(setv somevar 33)
(cond
  [(> somevar 50)
   (print "That variable is too big!")]
  [(< somevar 10)
   (print "That variable is too small!")]
  [True
   (print "That variable is jussssst right!")])
;; ### FOR
(for [x [1 2 3]]
  (print x))         ; => 1 2 3
;; ### WHILE
(setv x 3)
(while (> x 0)
  (print x)
  (setv x (- x 1)))  ; => 3 2 1

;; ### LFOR - List comprehension
(print (lfor  x [1 2 3]  (* x 2)))  ; => [2, 4, 6]

;; ## Functions, Classes, Modules

;; ### Functions

(defn fib [n]
  (if (< n 2)
    n
    (+ (fib (- n 1)) (fib (- n 2)))))
(print (fib 8))  ; => 21
;; Anonymous function
(print (list (filter (fn [x] (% x 2)) (range 10))))
;; function parameters
(defn test [a b [c None] [d "x"] #* e]
  [a b c d e])
(print (test 1 2))            ; => [1, 2, None, 'x', ()]
(print (test 1 2 3 4 5 6 7))  ; => [1, 2, 3, 4, (5, 6, 7)]
(test 1 2 :d "y")             ; => [1, 2, None, 'y', ()]

;; ### Classes

(defclass FooBar []
  (defn __init__ [self x]
    (setv self.x x))
  (defn get-x [self]
    self.x))

(setv fb (FooBar 15))
(print fb.x)         ; => 15
(print (. fb x))     ; => 15
(print (.get-x fb))  ; => 15
(print (fb.get-x))   ; => 15
;; import external module
(import math)
(print (math.sqrt 2))  ; => 1.4142135623730951

;; ## Metaprogramming with Macros

(print "Executing")
(defmacro m []
  (print "Now for a slow computation")
  (setv x (% (** 10 10 7) 3))
  (print "Done computing")
  x)
(print "Value:" (m))
(print "Done executing")

;; for importing macros
;; (require tutorial.macros)
