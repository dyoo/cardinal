#lang scribble/manual
@(require planet/scribble
          scribble/eval
          (for-label (this-package-in main)))

@title{cardinal: get the cardinal string representation of a number}
@author+email["Danny Yoo" "dyoo@hashcollision.org"]

@defmodule/this-package[main]

@(define my-eval (make-base-eval))

This library provides the function @racket[number->cardinal] to get the english
cardinal string representation of a number.
@interaction[#:eval my-eval
(require (planet dyoo/cardinal))
(number->cardinal 0)
(number->cardinal 1)
(number->cardinal 2)
(number->cardinal 31415926)]


The main function provided by the library is:
@defproc[(number->cardinal [n exact-nonnegative-integer]) string]{
Given @racket[n], produces the cardinal string representation
of the number.

@interaction[#:eval my-eval
(number->cardinal 0)
(number->cardinal 1)
(number->cardinal 1024)
(number->cardinal 2048)
(number->cardinal 4096)
(number->cardinal (expt 2 10))
]


Note that this function is contracted to work only on nonnegative
integers up to @racket[maximum-countable-cardinal-number].
@interaction[#:eval my-eval
(number->cardinal 1)
(number->cardinal 2)
(number->cardinal +inf.0)]
}



@section{Miscellaneous functions and values}

@defproc[(number->cardinal/uncontracted [n number]) string]{
The uncontracted version of @racket[number->cardinal].  This function
still produces a runtime error if given a number greater than
@racket[maximum-countable-cardinal-number].
}


@defthing[maximum-countable-cardinal-number number]{
The maximum number that this library can convert to a cardinal string representation.

As of this writing, this value is:
@interaction[#:eval my-eval
maximum-countable-cardinal-number]
}




@section{Notes}

Neil van Dyke's
@link["http://www.neilvandyke.org/numspell-scheme/"]{numspell} library
has richer functionality; I wish I'd seen it earlier.