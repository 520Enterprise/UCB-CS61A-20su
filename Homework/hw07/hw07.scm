(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cddr s))
)


(define (sign num)
  (cond ((< num 0) -1)
        ((= num 0) 0)
        ((> num 0) 1)
  )
)


(define (square x) (* x x))

(define (pow x y)
  (cond ((= y 0) 1)
        ((even? y) (square (pow x (/ y 2))))
        ((odd? y) (* x (pow x (- y 1))))
  )
)


(define (unique s)
  (cond ((null? s) nil)
        (else (cons (car s)
                  (unique (filter (lambda (x) (not (equal? x (car s)))) (cdr s)))))
  )
)


(define (replicate x n)
    (define (replicate-tail num lst-sofar)
      (cond ((= num 0) lst-sofar)
            (else (replicate-tail (- num 1) (cons x lst-sofar)))
      )
    )
    (replicate-tail n nil)
  )



(define (accumulate combiner start n term)
    (define (accumulate-tail num total-sofar)
        (cond ((= num 0) total-sofar)
              (else (accumulate-tail (- num 1) (combiner (term num) total-sofar)))
        )
    )
    (accumulate-tail n start)
)


(define (accumulate-tail combiner start n term)
    (define (helper num total-sofar)
        (cond ((= num 0) total-sofar)
            (else (helper (- num 1) (combiner (term num) total-sofar)))
            )
        )
    (helper n start)
)


(define-macro (list-of map-expr for var in lst if filter-expr)
    (list 'map (list 'lambda (list var) map-expr) (list 'filter (list 'lambda (list var) filter-expr) lst))
)

