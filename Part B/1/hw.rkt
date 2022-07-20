
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; list of numbers from low to high inclusive, stride at a time
(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

;; list of strings with each string appended by suffix
(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

;; ith element where i is n mod length, else error
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t
         (let* ([len (length xs)]
                [i (remainder n len)])
           (car (list-tail xs i)))]))

;; list of the first n elements produced by a stream
(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (let ([next (s)])
        (cons (car next)
              (stream-for-n-steps (cdr next) (- n 1))))))

;; stream of natural numbers, but numbers divisible by 5 are negated
(define funny-number-stream
  (letrec ([f (lambda (n)
                (lambda ()
                  (if (= (remainder n 5) 0)
                      (cons (- 0 n) (f (+ n 1)))
                      (cons n (f (+ n 1))))))])
    (f 1)))

;; a stream that alternates between "dan.jpg" and "dog.jpg"
(define dan-then-dog
  (letrec ([dan (lambda ()
                  (cons "dan.jpg" dog))]
           [dog (lambda ()
                  (cons "dog.jpg" dan))])
    dan))

;; stream of (0 . v_i) where v_i is the ith element of a given stream
(define (stream-add-zero s)
  (lambda ()
    (let ([next (s)])
      (cons (cons 0 (car next)) (stream-add-zero (cdr next))))))

;; a stream of (a_i . b_i) where a_i and b_i are the ith (mod length) elements from each list
(define (cycle-lists xs ys)
  (letrec ([helper (lambda (n)
                     (lambda ()
                       (cons (cons (list-nth-mod xs n)
                                   (list-nth-mod ys n))
                             (helper (+ n 1)))))])
    (helper 0)))

;; assoc but for vectors, skip non pairs
(define (vector-assoc v vec)
  (letrec ([len (vector-length vec)]
           [loop
            (lambda (n)
              (if (>= n len)
                  #f
                  (let ([item (vector-ref vec n)])
                    (if (and (pair? item) (equal? v (car item)))
                        item
                        (loop (+ n 1))))))])
    (loop 0)))
                     
;; a function that behaves like assoc but with memoization
(define (cached-assoc xs n)
  (let ([cache (make-vector n #f)]
        [next 0])
    (lambda (v)
      (let ([try (vector-assoc v cache)])
        (if (false? try)
            (let ([result (assoc v xs)])
              (if (false? result)
                  #f
                  (begin (vector-set! cache next result)
                         (set! next (modulo (+ next 1) n))
                         result)))
            try)))))

;; challenge problem
(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (letrec ([cap e1]
              [try e2]
              [loop (lambda ()
                      (if (< try cap)
                          (begin (set! try e2) (loop))
                          #t))])
       (loop))]))
                        
