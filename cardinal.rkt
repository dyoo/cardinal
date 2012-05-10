#lang racket/base

(require racket/contract)

;; A library for computing the English cardinal number string
;; representations.
;;
;; http://en.wikipedia.org/wiki/Names_of_numbers_in_English

(provide

 (contract-out
  [number->cardinal [countable-number? . -> . string?]])
 
 (rename-out [number->cardinal number->cardinal/uncontracted])

 maximum-countable-cardinal-number)


;; countable-number? any -> boolean
(define (countable-number? n)
  (and (exact-nonnegative-integer? n)
       (<= n maximum-countable-cardinal-number)))


;; number->cardinal: number -> string
;; Converts the number to a string.
;;
;; TODO: we should do efficient string concatenation if profiling demands it.
;;
(define (number->cardinal n)
  (cond
   [(< n 1000)
    (small-number->cardinal n)]
   [else
    (define this-mag (mag10 n))
    (cond
     [(>= this-mag max-mag)
      (error 'number->cardinal "~s too large to count" n)]
     [else
      (define s (quotient this-mag 3))
      (define t (expt 10 (* 3 s)))
      (if (= 0 (remainder n t))
          (string-append (small-number->cardinal (quotient n t))
                         " "
                         (vector-ref scales s))
          (string-append (small-number->cardinal (quotient n t))
                         " " (vector-ref scales s)
                         " " (number->cardinal (remainder n t))))])]))
          

;; Handles numbers between 0 and 999.
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
   [(< n 1000)
    (if (= 0 (remainder n 100))
        (string-append (small-number->cardinal (quotient n 100))
                   " hundred")
        (string-append (small-number->cardinal (quotient n 100))
                       " hundred "
                       (small-number->cardinal (remainder n 100))))]))

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
  #(""
    "thousand"       ;; 10^3
    "million"        ;; 10^6
    "billion"        ;; 10^9
    "trillion"       ;; 10^12
    "quadrillion"    ;; 10^15
    "quintillion"    ;; ...
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
    "vigintillion"
    ))



;; Porduces the magnitude of a number in terms of powers of 10.
(define (mag10 n)
  (let loop ([n n]
             [x 0])
    (cond [(= 0 (quotient n 10))
           x]
          [else
           (loop (quotient n 10)
                 (add1 x))])))

(define max-mag (* 3 (vector-length scales)))

(define maximum-countable-cardinal-number
  (sub1 (expt 10 max-mag)))
