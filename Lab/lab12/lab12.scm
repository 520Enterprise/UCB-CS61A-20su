
(define-macro (def func args body)
	`(define ,func (lambda ,args ,body))
	)


(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define all-three-multiples
	(cons-stream 3 (map-stream (lambda (x) (+ 3 x)) all-three-multiples))
)


(define (compose-all funcs)
	(if (null? funcs)
		(lambda (x) x)
		(lambda (x) ((compose-all (cdr funcs)) ((car funcs) x)))
	)
)


(define (partial-sums stream)
;  (define (add-stream s t)
;	  (cond ((null? s) nil)
;	  	((null? t) nil)
;	  	(else (cons-stream (+ (car s) (car t)) (add-stream (cdr-stream s) (cdr-stream t))))
;	  )
;	  )
;  (cons-stream (car stream) (add-stream (cdr-stream stream) (partial-sums stream)))
	(define (helper sum stream)
		(if (null? stream)
			nil
			(cons-stream (+ sum (car stream))
				(helper (+ sum (car stream)) (cdr-stream stream))
				)
			)
		)
	(helper 0 stream)
	)

