#lang racket

(require racket/math)

(define width 80)
(define height 24)

(define chars ".,-~:;=!*#$@")

(define (render-frame A B)
  (define output (make-vector (* width height) #\space))
  (define zbuffer (make-vector (* width height) 0.0))

  (for ([theta (in-range 0 (* 2 pi) 0.07)])      ; θ (tube)
    (for ([phi (in-range 0 (* 2 pi) 0.02)])      ; φ (around donut)

      ;; Torus parameters
      (define R 3)
      (define r 1.5)

      ;; Precompute trig
      (define cosθ (cos theta))
      (define sinθ (sin theta))
      (define cosφ (cos phi))
      (define sinφ (sin phi))

      ;; Point on torus BEFORE rotation
      (define circle-x (+ R (* r cosθ)))  ; R + r cosθ
      (define circle-y (* r sinθ))

      ;; 3D coordinates
      (define x (* circle-x cosφ))
      (define y (* circle-x sinφ))
      (define z circle-y)

      ;; Rotation (X then Z)
      (define sinA (sin A))
      (define cosA (cos A))
      (define sinB (sin B))
      (define cosB (cos B))

      ;; rotate around X
      (define y1 (- (* y cosA) (* z sinA)))
      (define z1 (+ (* y sinA) (* z cosA)))

      ;; rotate around Z
      (define x2 (- (* x cosB) (* y1 sinB)))
      (define y2 (+ (* x sinB) (* y1 cosB)))
      (define z2 z1)

      ;; Projection
      (define K 5)
      (define inv-z (/ 1 (+ z2 K)))

      (define xp (inexact->exact (round (+ (/ width 2)
                                           (* 30 inv-z x2)))))
      (define yp (inexact->exact (round (+ (/ height 2)
                                           (* 15 inv-z y2)))))

      ;; Lighting (approx normal dot light)
      (define L (- (* cosφ cosθ sinB)
                   (* cosA cosθ sinφ)
                   (* sinA sinθ)
                   (* cosB (+ (* cosA sinθ)
                              (* cosθ sinA sinφ)))))

      (define idx (+ xp (* yp width)))

      (when (and (>= xp 0) (< xp width)
                 (>= yp 0) (< yp height)
                 (> inv-z (vector-ref zbuffer idx)))

        (vector-set! zbuffer idx inv-z)

        (define brightness (max 0 (min (- (string-length chars) 1)
                                       (inexact->exact (floor (* 8 L))))))

        (vector-set! output idx
                     (string-ref chars brightness)))))

  ;; Print frame
  (for ([y (in-range height)])
    (for ([x (in-range width)])
      (display (vector-ref output (+ x (* y width)))))
    (newline)))

;; Animation loop
(define (animate)
  (let loop ([A 0.0] [B 0.0])
    (display "\033[H") ; reset cursor
    (render-frame A B)
    (sleep 0.03)
    (loop (+ A 0.04) (+ B 0.02))))

(render-frame 0.0 0.0)