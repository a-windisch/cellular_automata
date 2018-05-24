#  Cellular Automata: Rule 110 in Fortran
### Andreas Windisch, andreas.windisch@yahoo.com 

## 1. Files contained in this repository

- README.md - This file.
- rule110.f90 - the main R script, see description below.

## 2. General description
Cellular Automata are very fascinating machines that can be easily simulated on a computer by evolving a state vector according to a certain rule. The rule can be implemented by means of a boolean expression. For example, the famous rule 110 can be expressed as
```bash
  q AND (NOT p) OR (q XOR r)
```
see e.g. [wolfram aplpha]{https://www.wolframalpha.com/input/?i=rule+110&lk=3}. The most fascinating aspect about rule 110 is, that it is a Turing complete automaton [[1]],{https://web.archive.org/web/20160528014857/http://www.complex-systems.com/pdf/15-1-1.pdf}.
This rule is readily implemented and is fun to play with.

## 3. rule110.f90
This file contains a few lines of code that implement rule 110 in Fortran. 

[1] Matthew Cook, Universality in Elementary Cellular Automata, Complex Systems 15:1-40, 2004
