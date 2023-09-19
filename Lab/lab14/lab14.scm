(define (split-at lst n)
  	(define (helper lst n current)
			(cond ((or (null? lst) (= n 0)) (append (list current) lst))
		  		(else (helper (cdr lst) (- n 1) (append current (list (car lst)))))
				)
		)
	(helper lst n nil)
)


(define-macro (switch expr cases)
	(cons 'cond
		(map (lambda (case) (cons (eq? (eval expr) (car case)) (cdr case)))
			cases)
		)
	)

