# donuts-lisp 🍩

A collection of rotating ASCII donut implementations written in different Lisp dialects.

This project is inspired by the classic donut.c program and explores how the same rendering logic can be expressed across multiple Lisp standards and implementations.

---

## Project Structure
Each implementation includes three variants:
- **Standard version** — the normal readable implementation
- **One-line version** — condensed into a single line of code
- **Verbose version** — expanded and commented for easier understanding of how the donut renderer works

---

## Implemented Dialects

| Dialect       | File        |
| ------------- | ----------- |
| Racket        | `donut.rkt` |
| Scheme (R5RS) | `donut.scm` |

---

## Goal

The purpose of this repository is to compare:
- Syntax differences between Lisp dialects
- Standard library availability
- Portability across implementations
- How graphics/math-heavy terminal programs translate between standards

---

## Preview

```

                   ######***!!!!!!!!!!!!!!!!!!!!!!!***#######
                  ####****!!!!!!!===;;;;;;;;;====!!!!!!***#####
                ####***!!!!!=====;;;:::::::::;;;=====!!!!!***####
              *##****!!!!====;;:::~~~~~~~~~~~~~:::;;====!!!!****##*
             *******!!!!==;;;;:~~~---,,,,,,,---~~:::;;;===!!!*****#*
            ******!!!!!==;;::~~---,,..........,,--~~::;;;=!!!!!******
           ******!!!!===;;::~--,.................,--~:::;===!!!!******
          !*****!!!!!==;;::~~-,...................,-~~~:;;;==!!!!*****!
          !*****!!!!==;;;::~-,.....................,-~~:;;===!!!!*****!
          !****!!!!!===;;::~-,......         ......,--~::;===!!!!!****!=
         !!!***!!!!!===;;::~-,....             ....,-~~::;;==!!!!!***!!!
         =!!!!*!!!!!!!==;;::~-,..               ...--~:;;;==!!!!!!***!!=
         =!!!!!*!!!!!!!==;;;:~-,                 ,-~::;;===!!!!!!!!!!!!=
         =!!!!!****!!!!!!===;;::-               ,~:;:;====!!!!!!**!!!!!=
         =!!!!!*******!!!!!!!===;~             ~:=;====!!!!!!*****!!!!==
          =!!!!****************!!!=;         ;==!!*!!!!***********!!!!=
          ;=!!!!************#######*****!!***********************!!!!=;
          :===!!*******#########$$$$$$$$$$$$$$$$#########********!!!==:
           :===!!******######$$$$$$$$@@@@@@$$$$$$$$#######******!!===:
            ;;==!!*****######$$$$$$@@@@@@@@@@$$$$$$$#####******!!===:
             :;===!!*****#####$$$$$$$@@@@@@@$$$$$$$#####*****!!!==;:
               ;;==!!******####$$$$$$$$$$$$$$$$$$$####******!!==;;-
                :;;==!!*****#########$$$$$$$########******!!==;;:
                  ~;;==!!!******################*******!!!==;;~

```
(Spinning in the terminal, of course.)

---

## Running

### Racket version

Requires [Racket](https://racket-lang.org/)

```Bash
racket donut.rkt
```

### Scheme Version
Run using any R5RS-compatible Scheme implementation.

Example with [CHICKEN Scheme](https://www.call-cc.org/):

```Bash
csi donut.scm
```

---

## Inspiration

Inspired by the famous ASCII torus renderer commonly known as `donut.c`.