(define pi 3.141592653589793)

(define width 80)
(define height 24)

(define chars ".,-~:;=!*#$@")

(define (my-round x)
  (inexact->exact (floor (+ x 0.5))))

(define (clamp x lo hi)
  (cond ((< x lo) lo)
        ((> x hi) hi)
        (else x)))

(define (render-frame A B)

  (define output (make-vector (* width height) #\space))
  (define zbuffer (make-vector (* width height) 0.0))

  ;; precompute rotation trig
  (define sinA (sin A))
  (define cosA (cos A))
  (define sinB (sin B))
  (define cosB (cos B))

  ;; theta loop
  (let theta-loop ((theta 0.0))

    (if (< theta (* 2 pi))

        (begin

          ;; phi loop
          (let phi-loop ((phi 0.0))

            (if (< phi (* 2 pi))

                (begin

                  ;; torus params
                  (let* ((R 3.0)
                         (r 1.5)

                         ;; trig
                         (costh (cos theta))
                         (sinth (sin theta))
                         (cosph (cos phi))
                         (sinph (sin phi))

                         ;; torus point
                         (circle-x (+ R (* r costh)))
                         (circle-y (* r sinth))

                         ;; 3D coords
                         (x (* circle-x cosph))
                         (y (* circle-x sinph))
                         (z circle-y)

                         ;; rotate X
                         (y1 (- (* y cosA) (* z sinA)))
                         (z1 (+ (* y sinA) (* z cosA)))

                         ;; rotate Z
                         (x2 (- (* x cosB) (* y1 sinB)))
                         (y2 (+ (* x sinB) (* y1 cosB)))
                         (z2 z1)

                         ;; projection
                         (K 5.0)
                         (inv-z (/ 1.0 (+ z2 K)))

                         (xp
                           (my-round
                             (+ (/ width 2)
                                (* 30 inv-z x2))))

                         (yp
                           (my-round
                             (+ (/ height 2)
                                (* 15 inv-z y2))))

                         ;; lighting
                         (L
                           (- (* cosph costh sinB)
                              (* cosA costh sinph)
                              (* sinA sinth)
                              (* cosB
                                 (+ (* cosA sinth)
                                    (* costh sinA sinph))))))

                  ;; bounds check
                  (if (and (>= xp 0)
                           (< xp width)
                           (>= yp 0)
                           (< yp height))

                      (let ((idx (+ xp (* yp width))))

                        (if (> inv-z
                               (vector-ref zbuffer idx))

                            (begin

                              (vector-set!
                                zbuffer
                                idx
                                inv-z)

                              (let ((brightness
                                      (clamp
                                        (inexact->exact
                                          (floor (* 8 L)))
                                        0
                                        (- (string-length chars) 1))))

                                (vector-set!
                                  output
                                  idx
                                  (string-ref chars brightness))))))))

                  ;; next phi
                  (phi-loop (+ phi 0.02)))))

          ;; next theta
          (theta-loop (+ theta 0.07)))))

  ;; print frame
  (let y-loop ((y 0))

    (if (< y height)

        (begin

          (let x-loop ((x 0))

            (if (< x width)

                (begin
                  (display
                    (vector-ref output
                                (+ x (* y width))))
                  (x-loop (+ x 1)))))

          (newline)
          (y-loop (+ y 1))))))

(define (animate)

  (let loop ((A 0.0)
             (B 0.0))

    ;; ANSI escape: move cursor to top-left
    (display "\033[H")

    (render-frame A B)

    ;; recurse forever
    (loop (+ A 0.04)
          (+ B 0.02))))

(animate)