(gc-report-set! #t)

(load "opengl")

(define buffer (opengl-create-empty-float-array 10))
(define values (list 1.0 2.0 3.0 4.0 5.0
                     6.0 7.0 8.0 9.0 10.0))

(define counter-data (vector 0))

(define (count)
  (let ((now (vector-ref counter-data 0)))
    (if (= (modulo now 1000) 0)
        (println "Counting " now))
    (vector-set! counter-data 0 (+ now 1))))

(define (churn)
  (count)
  (opengl-set-float-array! buffer values)
  (churn))

(churn)


