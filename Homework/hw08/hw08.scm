(define (rle s)
    (define (rle-helper s last-count last-value)
        (cond ((null? s) (cons-stream (list last-value last-count) nil))
              ((= (car s) last-value)
                  (rle-helper (cdr-stream s) (+ last-count 1) last-value))
              (else
               (cons-stream (list last-value last-count)
                     (rle-helper (cdr-stream s) 1 (car s))))
            )
        )
    (cond ((null? s) nil)
          (else (rle-helper s 0 (car s)))
        )
)



(define (group-by-nondecreasing s)
    (define (group-by-nondecreasing-helper s last-list last-value)
        (cond ((null? s) (cons-stream last-list nil))
              ((< (car s) last-value)
                  (cons-stream last-list (group-by-nondecreasing-helper (cdr-stream s) (list (car s)) (car s))))
                (else
                    (group-by-nondecreasing-helper (cdr-stream s) (append last-list (list (car s))) (car s)))
            )
        )
    (cond ((null? s) nil)
          (else (group-by-nondecreasing-helper s nil (car s)))
        )
    )


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

