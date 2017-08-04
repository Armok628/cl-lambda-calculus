# cl-lambda-calculus
Redex reducer in Common Lisp

This project hasn't been thoroughly tested quite yet, but I've tested it enough to at least get the impression that it works. It has successfully reduced every redex I've thrown at it, but I'm not quite sure how to test the Y-combinator yet to be certain that I've translated it to my notation correctly, yet alone find out whether it actually works.

Anyway, it occurred to me that I might want to explain my notation a little. Take the S combinator, for example: `λx. λy. λz. (x z) (y z)` becomes `(L (X Y Z) ((X Z) (Y Z)))`. Parentheses represent function creation and application. The arguments to a function are enclosed in their own list. Function application should always be explicit.

A β-reduction example: `` `(,lnot (,lnot ,true)) `` is interpreted (by eval) as

`((L (C) ((C (L (X Y) Y)) (L (X Y) X))) ((L (C) ((C (L (X Y) Y)) (L (X Y) X))) (L (X Y) X)))`

which can be reduced as follows by successive applications of `beta-reduce`:

`(((((L (X Y) X) (L (X Y) Y)) (L (X Y) X)) (L (X Y) Y)) (L (X Y) X))`

`((((L (#:G390) (L (X Y) Y)) (L (X Y) X)) (L (X Y) Y)) (L (X Y) X))`

(Symbols that look like `#:G390` above are created by `(gensym)` for use in α-conversion)

`(((L (X Y) Y) (L (X Y) Y)) (L (X Y) X))`

`((L (#:G402) #:G402) (L (X Y) X))`

`(L (X Y) X)` (a.k.a. `true`)

Also, for the record, I'm pretty much fresh out of high school as of writing this. Any mistakes I've made will probably become apparent in time through my Computer Engineering coursework eventually, and this project is kind of a one-off anyway.
