#  Cellular Automata: Rule 110 in Fortran
### Andreas Windisch, andreas.windisch@yahoo.com 

## 1. Files contained in this repository

- README.md - This file.
- rule110.f90 - the main R script, see description below.

## 2. General description
Cellular Automata are very fascinating machines that can be easily simulated on a computer by evolving a state vector according to a certain rule. Because some people find it confusing that a rule can be expressed with just a number, like rule 110, let me try to explain what that means.
The first thing you should be familar with is the binary system, that is, representing numbers using just zeros and ones. Let's have a look at this. As an example, let us use the decimal number 23. How does 23 look like as a binary number?
It turns out that 23 in binary representation is 10111b, where I added a 'b' to emphasize that this is not a decimal number. The procedure by which the representation is found is simple: First, divide the number by 2 and memorize its integer part. In this case, we would have 23./2 = 11, where with ./ I denote an integer division, that is, a division which throws away the remainder. Then, let us have a look at the remainder of this division, which happens to be 23%2=1. This one is the first bit to the very left that we have to note down. Then, we continue in the same fashion, only this time we use the result of the previous integer division as a starting point. Earlier we found 11 as a result of the integer quotient. Thus, we have 11./2 = 5, and 11%2 = 1, so we note down another 1 to the left of the 1 we have found in the previous step. To make this procedure more readable, let me write it as a table, where I also perform the remaining iterations to arrive at the final binary representation of the decimal number 23.

|    Operation    |    Integer Quotient    |    Remainder    |    Note down binary form    |
|:---------------:|:----------------------:|:---------------:|----------------------------:|
|   23/2          |        11              |     1           |        1                    |
|   11/2          |        5               |     1           |       11                    |
|    5/2          |        2               |     1           |      111                    |
|    2/2          |        1               |     0           |     0111                    |
|    1/2          |        0               |     1           |    10111                    |

But how can we be sure that this is the right sequence of zeros and ones? Let us try and see wether we can get the decimal number back if we perform the conversion back to the decimal system. In the binary system, starting on the right, we have to add up a factor of 2^n, where n is the place where we found a one. So, in our example and starting from the right, we have 2^0 + 2^1 + 2^2 + 2^4 = 1 + 2 + 4 + 16 = 23.
Now that we have reviewed conversions between the binary and the decimal system, what does that have to do with cellular automata?
To understand this, we have to know how cellular automata work. 
Simple automata, like rule 110, work as follows. First, we need some array of just ones and zeros. Let us say that our array is of length eleven, and that we initialize it as

```code
0 0 0 0 0 1 0 0 0 0 0 
```
Next, we are interested in how this array (or state) can be evolved in time. This is where the rule enters the game. An entry of the next state is obtained from the current state dpending on what the left and right neighbors of that entry, as well as the entry at the position that we want to update, is. Since the state only has either zeros or ones, and because we only consider the current value of the position that we want to update, along with the values of the two neighboring cells, there are eight possible situations we have to consider. To be more economical, let us assume that the current value of the cell we want to update is called q, the current value of its left neighbor p, and the current value of its right neighbor r. There are eight different cases that can arise in this setup. Let me again write a table.

|   Case   |   p   |   q   |    r   |
|:--------:|:-----:|:-----:|:------:|
|     1    |   0   |   0   |   0    |
|     2    |   0   |   0   |   1    |
|     3    |   0   |   1   |   0    |
|     4    |   0   |   1   |   1    |
|     5    |   1   |   0   |   0    |
|     6    |   1   |   0   |   1    |
|     7    |   1   |   1   |   0    |
|     8    |   1   |   1   |   1    |

In order to have a valid rule, we have to define a specific outcome (either one or zero) for each of these eight cases. Let us write the table again, but this time add another column that specifies the outcome and thus our rule (for now, assume that I choose the value for the new entry at random).

|   Case   |   p   |   q   |    r   |   new entry  |
|:--------:|:-----:|:-----:|:------:|:------------:|
|     1    |   0   |   0   |   0    |      0       |
|     2    |   0   |   0   |   1    |      1       |
|     3    |   0   |   1   |   0    |      1       |
|     4    |   0   |   1   |   1    |      1       |
|     5    |   1   |   0   |   0    |      0       |
|     6    |   1   |   0   |   1    |      1       |
|     7    |   1   |   1   |   0    |      1       |
|     8    |   1   |   1   |   1    |      0       |

We have now defined a rule under which we can compute the next state of the automaton, based on the current state (we thus need an initial state to kick off the evolution). Reading the 'new entry' column that we just added from bottom to top, we have 01101110. This can be thought of as being just some binary number, like the one that we discussed in the example above. Let us find out what this number is in the decimal representation. Starting on the right, we have 2^1 + 2^2 + 2^3 + 2^5 + 2^6 = 2 + 4 + 8 + 32 + 64 = 110. Wait, doesn't that sound familar? I mentioned rule 110 above, and that is exactly the rule I specified in this example here. So now you know what rule 110 is, and you shouldn't be surprised that there are many other rules that one can come up with, depending on how we place ones and/or zeros in the column that specified the outcome of each of the eight cases in the table above. In fact, since there are eight cases to be specified to be either 0 or 1, there are 2^8 different possibilities, which amounts to a total of 256 different rules that one could come up with. The fascinating thing about cellular automata is that they behave very differently, depending on which rule we choose. It turns out that 110 is particularly interesting, which is why I chose it as an example.
Now that you know what rule 110 is, let us evolve the state vector we defined above for a few steps, such that you can convince yourself that you understand how it works. Assuming that there are zeros to the left and the right of the array (those are our boundary conditions), and using the table above, we find, for the first 5 steps:

```code
0 0 0 0 0 1 0 0 0 0 0 
0 0 0 0 1 1 0 0 0 0 0 
0 0 0 1 1 1 0 0 0 0 0 
0 0 1 1 0 1 0 0 0 0 0 
0 1 1 1 1 1 0 0 0 0 0 
. . . . . . . . . . . 
. . . . . . . . . . . 
. . . . . . . . . . . 
```
There is one last thing that I would like to mention. It is convenient to write a rule in terms of a boolean expression of p, q and r. For example, for rule 110 one finds, see e.g. [wolfram aplpha](https://www.wolframalpha.com/input/?i=rule+110&lk=3):

```bash
  q AND (NOT p) OR (q XOR r)

```
Let us see how this works out by adding yet another column to our table:

|   Case   |   p   |   q   |    r   |   new entry  |   q AND (NOT p) OR (q XOR r)   | 
|:--------:|:-----:|:-----:|:------:|:------------:|:------------------------------:|
|     1    |   0   |   0   |   0    |      0       |           0                    |
|     2    |   0   |   0   |   1    |      1       |           1                    |
|     3    |   0   |   1   |   0    |      1       |           1                    |
|     4    |   0   |   1   |   1    |      1       |           1                    |
|     5    |   1   |   0   |   0    |      0       |           0                    |
|     6    |   1   |   0   |   1    |      1       |           1                    |
|     7    |   1   |   1   |   0    |      1       |           1                    |
|     8    |   1   |   1   |   1    |      0       |           0                    |


This should be enough to get you started implementing your own cellular automaton and studying its properties. The most fascinating aspect about rule 110 is, that it is a Turing complete automaton [1](https://web.archive.org/web/20160528014857/http://www.complex-systems.com/pdf/15-1-1.pdf).
This rule is readily implemented and is fun to play with. I do hope that you enjoy this subject as much as I do! Have fun playing with cellular automata :-) (feel free to contact me using the meail address above).

## 3. rule110.f90
This file contains a few lines of code that implement rule 110 in Fortran.
On a linux system, compile it with

```bash
$ gfortran rule110.f90
``` 
and launch the program with

```bash
$ ./a.out
```

[1] Matthew Cook, Universality in Elementary Cellular Automata, Complex Systems 15:1-40, 2004
