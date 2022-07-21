;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

;; a MUPL list givena racket list of MUPL values
(define (racketlist->mupllist xs)
  (if (null? xs)
      (aunit)
      (apair (car xs) (racketlist->mupllist (cdr xs)))))

;; racket list given a MUPL list
(define (mupllist->racketlist xs)
  (if (aunit? xs)
      null
      (cons (apair-e1 xs) (mupllist->racketlist (apair-e2 xs)))))

;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        [(int? e) e]
        [(aunit? e) e]
        [(closure? e) e]
        [(isaunit? e)
         (let ([v (eval-under-env (isaunit-e e) env)])
           (if (aunit? v)
               (int 1)
               (int 0)))]
        [(apair? e)
         (let ([v1 (eval-under-env (apair-e1 e) env)]
               [v2 (eval-under-env (apair-e2 e) env)])
           (apair v1 v2))]
        [(fst? e)
         (let ([v (eval-under-env (fst-e e) env)])
           (if (apair? v)
               (apair-e1 v)
               (error "MUPL fst applied to non apair")))]
        [(snd? e)
         (let ([v (eval-under-env (snd-e e) env)])
           (if (apair? v)
               (apair-e2 v)
               (error "MUPL snd applied to non apair")))]
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (if (> (int-num v1)
                      (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "MUPL ifgreater conditional applied to non-number")))]
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        [(mlet? e)
         (let ([v (mlet-var e)]
               [exp (mlet-e e)]
               [body (mlet-body e)])
           (let ([ext-env (cons
                           (cons v (eval-under-env exp env))
                           env)])
             (eval-under-env body ext-env)))]
        [(fun? e)
         (closure env e)]
        [(call? e)
         (let* ([c (eval-under-env (call-funexp e) env)]
                [v (eval-under-env (call-actual e) env)]
                [f (closure-fun c)])
           (if (not (closure? c))
               (error "MUPL call applied to non-function")
               (let* ([fun-env (closure-env c)]
                      [name (fun-nameopt f)]
                      [formal (fun-formal f)]
                      [body (fun-body f)]
                      [ext (mlet formal v body)])
                 (eval-under-env (if (false? name)
                                     ext
                                     (mlet name c ext))
                                 fun-env))))]
        ;; CHANGE add more cases here
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3) (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2)
  (if (null? lstlst)
      e2
      (mlet (car (car lstlst))
            (cdr (car lstlst))
            (mlet* (cdr lstlst)
                   e2))))

(define (ifeq e1 e2 e3 e4)
  (mlet "_x" e1
        (mlet "_y" e2
              (ifgreater (var "_x") (var "_y") e4
                         (ifgreater (var "_y") (var "_x") e4 e3)))))

;; Problem 4

(define mupl-map
  (fun #f "f"
       (fun "loop" "xs"
            (ifaunit (var "xs")
                     (aunit)
                     (apair (call (var "f") (fst (var "xs")))
                            (call (var "loop") (snd (var "xs"))))))))

(define mupl-mapAddN 
  (mlet "map" mupl-map
        (fun #f "n"
             (call (var "map")
                   (fun #f "num"
                        (add (var "n") (var "num")))))))

;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e)
  (if (not (fun? e))
      e
      (fun-challenge (fun-nameopt e)
                     (fun-formal e)
                     (fun-body e)
                     (letrec ([loop
                               (lambda (e acc)
                                 (cond [(var? e) (set-add acc (var-string e))]
                                       [(apair? e)
                                        (set-union (loop (fst e) acc)
                                                   (loop (snd e) acc))]
                                       [(add? e)
                                        (set-union (loop (add-e1 e) acc)
                                                   (loop (add-e2 e) acc))]
                                       [(mlet? e)
                                        (set-remove (loop (mlet-body e) acc) (mlet-var e))]
                                       [(ifgreater? e)
                                        (set-union (loop (ifgreater-e1 e) acc)
                                                   (loop (ifgreater-e2 e) acc)
                                                   (loop (ifgreater-e3 e) acc)
                                                   (loop (ifgreater-e4 e) acc))]
                                       [(fun? e)
                                        (set-remove (set-remove (loop (fun-body e) acc)
                                                                (fun-formal e))
                                                    (if (false? (fun-nameopt e))
                                                                null
                                                                (fun-nameopt e)))]
                                       [#t null]))])
                       (set-remove (set-remove (loop (fun-body e) null) (fun-formal e))
                                   (if (false? (fun-nameopt e))
                                       null
                                       (fun-nameopt e)))))))
                                       
;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        [(int? e) e]
        [(aunit? e) e]
        [(closure? e) e]
        [(isaunit? e)
         (let ([v (eval-under-env-c (compute-free-vars (isaunit-e e)) env)])
           (if (aunit? v)
               (int 1)
               (int 0)))]
        [(apair? e)
         (let ([v1 (eval-under-env-c (compute-free-vars (apair-e1 e)) env)]
               [v2 (eval-under-env-c (compute-free-vars (apair-e2 e)) env)])
           (apair v1 v2))]
        [(fst? e)
         (let ([v (eval-under-env-c (compute-free-vars (fst-e e)) env)])
           (if (apair? v)
               (apair-e1 v)
               (error "MUPL fst applied to non apair")))]
        [(snd? e)
         (let ([v (eval-under-env-c (compute-free-vars (snd-e e)) env)])
           (if (apair? v)
               (apair-e2 v)
               (error "MUPL snd applied to non apair")))]
        [(ifgreater? e)
         (let ([v1 (eval-under-env-c (compute-free-vars (ifgreater-e1 e)) env)]
               [v2 (eval-under-env-c (compute-free-vars (ifgreater-e2 e)) env)])
           (if (and (int? v1)
                    (int? v2))
               (if (> (int-num v1)
                      (int-num v2))
                   (eval-under-env-c (compute-free-vars (ifgreater-e3 e)) env)
                   (eval-under-env-c (compute-free-vars (ifgreater-e4 e)) env))
               (error "MUPL ifgreater conditional applied to non-number")))]
        [(add? e) 
         (let ([v1 (eval-under-env-c (compute-free-vars (add-e1 e)) env)]
               [v2 (eval-under-env-c (compute-free-vars (add-e2 e)) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        [(mlet? e)
         (let ([v (mlet-var e)]
               [exp (mlet-e e)]
               [body (mlet-body e)])
           (let ([ext-env (cons
                           (cons v (eval-under-env-c (compute-free-vars exp) env))
                           env)])
             (eval-under-env-c (compute-free-vars body) ext-env)))]
        [(fun-challenge? e)
         (closure (map (lambda (s)
                         (cons s (envlookup env s)))
                       (set->list (fun-challenge-freevars e)))
                  e)]
        [(call? e)
         (let* ([c (eval-under-env-c (compute-free-vars (call-funexp e)) env)]
                [v (eval-under-env-c (compute-free-vars (call-actual e)) env)]
                [f (compute-free-vars (closure-fun c))])
           (if (not (closure? c))
               (error "MUPL call applied to non-function")
               (let* ([fun-env (closure-env c)]
                      [name (fun-challenge-nameopt f)]
                      [formal (fun-challenge-formal f)]
                      [body (fun-challenge-body f)]
                      [ext (mlet formal v body)])
                 (eval-under-env-c (compute-free-vars (if (false? name)
                                     ext
                                     (mlet name c ext)))
                                 fun-env))))]
        ;; CHANGE add more cases here
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
