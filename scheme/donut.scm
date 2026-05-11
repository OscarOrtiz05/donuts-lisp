
                     (define c".,-~:;=!*#$@")                    
                 (define pi 3.141592653589793) (                
              define (mr x) (inexact->exact (floor(             
           + x 0.5)))) (define (clamp x lo hi) (cond (          
         (< x lo) lo) ((> x hi) hi) (else x))) (define (        
        rf A B)(define o(make-vector 1920 #\space))(define       
      zb (make-vector 1920 0.0)) (let tl ((t 0.0)) (if (< t     
     (* 2 pi)) (begin (let pl ((p 0.0)) (if (< p (* 2 pi)) (    
    begin (let* ((x (* (+ 2 (cos t)) (cos p)))(y (* (+ 2 (cos   
   t)) (sin p))) (y1 (- (* y (cos A)) (* (sin t) (sin A))))(z1  
  (+ (* y (sin A)) (* (sin t         ) (cos A)))) (x2 (- (* x ( 
  cos B)) (* y1 (sin B)))               ) (y2 (+ (* x (sin B))( 
 * y1(cos B))))(i(/ 1.0                   (+ z1 5.0))) (xp (mr (
 + 40(* 30 i x2))))(yp                     (mr (+ 12 (* 15 i y2)
 ))) (L (- (* (cos p)(                     cos t) (sin B))(*(cos
 A) (cos t) (sin p))(*                     (sin A) (sin t)) (* (
 cos B) (+ (* (cos A)(                     sin t))  (* (cos t) (
 sin A) (sin p)))))))(                     if (and(>= xp 0)(< xp
 80) (>= yp 0) (< yp 24                   )) (let ((idx (+ xp (*
  yp 80) ) ) ) (if (> i (               vector-ref zb idx)  ) ( 
  begin(vector-set! zb idx i         )#|qqq|#(let ((bs (clamp ( 
   inexact->exact (floor (* 8 L))) 0 (- (string-length c) 1)))  
    ) (vector-set! o idx (string-ref c bs)) ) ))) )) (pl (+ p   
     0.02))))) (tl (+ t 0.07))) )) (let yl ((y 0) ) (if (< y    
      24) (begin (let xl ((x 0))(if (< x 80) (begin(display     
        (vector-ref o (+ x (* y 80)) )) (xl (+ x 1))))) (       
         newline)(yl (+ y 1))))))(define (animate) (let        
           l((A 0.0)(B 0.0))(display "\033[H")(rf A B)          
              (l (+ A 0.04) (+ B 0.02)))) (animate)             
                 #|~~~~~~donut.scm implemented by 
                  OscarOrtiz-05~~~~~~~~~~~~~~~|# 