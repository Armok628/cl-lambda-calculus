(defvar K '(L (X Y) X))
(defvar S '(L (X Y Z) ((X Z) (Y Z))))
(defvar Y '(L (F) ((L (X) (F (X X))) (L (X) (F (X X)))))); Untested
(defvar true '(L (X Y) X))
(defvar false '(L (X Y) Y))
(defvar lnot `(L (C) ((C ,false) ,true)))

(defun subst-assoc (l env)
  (cond ((listp l) (mapcar (lambda (x) (subst-assoc x env)) l))
	((and (symbolp l) (assoc l env)) (cdr (assoc l env)))
	(t l)))

(defun alpha-convert (func)
  (subst-assoc func (loop for sym in (cadr func)
			  collect (cons sym (gensym)))))

(defun l-apply (func args)
  (setf func (alpha-convert func))
  (let ((env (loop for a in (cadr func) for b in args collect (cons a b))))
    (if (> (length (cadr func)) (length args))
      `(l ,(nthcdr (length args) (cadr func))
	  ,@(subst-assoc (cddr func) env))
      (car (subst-assoc (cddr func) env)))))

(defun beta-reduce (redex)
  (cond ((atom redex) redex)
	((eq (car redex) 'l) redex)
	((eq (caar redex) 'l)
	 (l-apply (car redex) (mapcar #'beta-reduce (cdr redex))))
	(t (mapcar #'beta-reduce redex))))

(defun times (n f v) (if (zerop n) v (times (1- n) f (funcall f v))))
