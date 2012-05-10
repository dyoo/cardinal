#lang racket/base

;; A library for computing the English cardinal number string
;; representations.
;;
;; http://en.wikipedia.org/wiki/Names_of_numbers_in_English

(define (number->cardinal n)
  (small-number->cardinal n))


;; Handles numbers between 0 and 99.
(define (small-number->cardinal n)
  (cond
   [(< n 21)
    (vector-ref small-cardinals n)]
   [(< n 100)
    (if (= 0 (remainder n 10))
        (vector-ref tens (quotient n 10))
        (string-append (vector-ref tens (quotient n 10))
                       "-"
                       (vector-ref small-cardinals (remainder n 10))))]



(define small-cardinals #("zero" "one" "two" "three" "four"
                          "five" "six" "seven" "eight" "nine" "ten"
                          "eleven" "twelve" "thirteen" "fourteen"
                          "fifteen" "sixteen" "seventeen" "eighteen"
                          "nineteen" "twenty"))

(define tens #(""
               "ten" "twenty" "thirty" "forty"
               "fifty" "sixty" "seventy" "eighty"
               "ninety"))



;; http://www.mrob.com/pub/math/largenum.html
(define scales
  #("hundred"
    "thousand"
    "million"
    "billion"
    "trillion"
    "quadrillion"
    "quintillion"
    "sextillion"
    "septillion"
    "octillion"
    "nonillion"
    "decillion"
    "undecillion"
    "duodecillion"
    "tredecillion"
    "quattuordecillion"
    "quindecillion"
    "sexdecillion"
    "septendecillion"
    "octodecillion"
    "novemdecillion"
    "vigintillion"))

    