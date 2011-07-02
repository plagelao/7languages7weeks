---
layout: post
categories:
  - prolog
---
And here we are, last day with prolog. Today, we learn how to solve puzzles! The author showed us how to solve Sudokus and the Eight Queens puzzle. It is mind blowing, and shows how awesome prolog is. Seriously.
The only problem I have with this day is that the exercises are just simple variations of the puzzles already solved by the author, so doing them is not a real challenge. Anyway, I want to show you how to solve a Sudoku with prolog, so let's do one of the exercises together.

- Modify the Sudoku solver to work on 9x9 puzzle.

  First of all, what is a 9x9 sudoku?

        Puzzle = [S11,S12,S13,S14,S15,S16,S17,S18,S19,
                  S21,S22,S23,S24,S25,S26,S27,S28,S29,
                  S31,S32,S33,S34,S35,S36,S37,S38,S39,
                  S41,S42,S43,S44,S45,S46,S47,S48,S49,
                  S51,S52,S53,S54,S55,S56,S57,S58,S59,
                  S61,S62,S63,S64,S65,S66,S67,S68,S69,
                  S71,S72,S73,S74,S75,S76,S77,S78,S79,
                  S81,S82,S83,S84,S85,S86,S87,S88,S89,
                  S91,S92,S93,S94,S95,S96,S97,S98,S99],

  We also know that the valid values for any cell are any number between 1 and 9:

        fd_domain(Solution, 1, 9),

  Another Sudoku rule is that the numbers in a row must be different (And so do the numbers in a column and the numbers in a square), so, what are rows, columns and squares?

        Row1 = [S11,S12,S13,S14,S15,S16,S17,S18,S19],
        Row2 = [S21,S22,S23,S24,S25,S26,S27,S28,S29],
        Row3 = [S31,S32,S33,S34,S35,S36,S37,S38,S39],
        Row4 = [S41,S42,S43,S44,S45,S46,S47,S48,S49],
        Row5 = [S51,S52,S53,S54,S55,S56,S57,S58,S59],
        Row6 = [S61,S62,S63,S64,S65,S66,S67,S68,S69],
        Row7 = [S71,S72,S73,S74,S75,S76,S77,S78,S79],
        Row8 = [S81,S82,S83,S84,S85,S86,S87,S88,S89],
        Row9 = [S91,S92,S93,S94,S95,S96,S97,S98,S99],

        Col1 = [S11,S21,S31,S41,S51,S61,S71,S81,S91],
        Col2 = [S12,S22,S32,S42,S52,S62,S72,S82,S92],
        Col3 = [S13,S23,S33,S43,S53,S63,S73,S83,S93],
        Col4 = [S14,S24,S34,S44,S54,S64,S74,S84,S94],
        Col5 = [S15,S25,S35,S45,S55,S65,S75,S85,S95],
        Col6 = [S16,S26,S36,S46,S56,S66,S76,S86,S96],
        Col7 = [S17,S27,S37,S47,S57,S67,S77,S87,S97],
        Col8 = [S18,S28,S38,S48,S58,S68,S78,S88,S98],
        Col9 = [S19,S29,S39,S49,S59,S69,S79,S89,S99],

        Square1 = [S11, S12, S13, S21, S22, S23, S31, S32, S33],
        Square2 = [S14, S15, S16, S24, S25, S26, S34, S35, S36],
        Square3 = [S17, S18, S19, S27, S28, S29, S37, S38, S39],
        Square4 = [S41, S42, S43, S51, S52, S53, S61, S62, S63],
        Square5 = [S44, S45, S46, S54, S55, S56, S64, S65, S66],
        Square6 = [S47, S48, S49, S57, S58, S59, S67, S68, S69],
        Square7 = [S71, S72, S73, S81, S82, S83, S91, S92, S93],
        Square8 = [S74, S75, S76, S84, S85, S86, S94, S95, S95],
        Square9 = [S77, S78, S79, S87, S88, S89, S97, S98, S99],

  Now that we know what rows, columns and squares are, all we need to do is to define what it means for any of them to not have any repeated value:


        valid([Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8, Row9,
               Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9,
               Square1, Square2, Square3, Square4, Square5, Square6, Square7, Square8, Square9]).

  where valid is:

        valid([]).
        valid([Head|Tail]) :-
          fd_all_different(Head), valid(Tail).

  And that is all! Prolog knows how to solve 9x9 sudokus now :D If we run:

        sudoku([1, 2, 3, 4, _, _, _, _, _,
                _, _, _, _, _, _, _, _, _,
                _, _, _, _, _, _, _, _, _,
                _, _, _, _, _, _, _, _, _,
                _, _, _, _, _, _, _, _, _,
                _, _, _, _, _, _, _, _, _,
                _, _, _, _, _, _, _, _, _,
                _, _, _, _, _, _, _, _, _,
                _, _, _, _, _, 4, 3, 2, 1],
                Solution).

  We get a solution for that particular sudoku:

        Solution = [1,2,3,4,_#59(5..9),_#81(5..9),_#103(5..9),_#125(5..9),_#147(5..9),
        _#169(4..9),_#191(4..9),_#213(4..9),_#235(1..3:5..9),_#257(1..3:5..9),_#279(1..3:5..9),_#301(1..2:4..9),_#323(1:3..9),_#345(2..9),
        _#367(4..9),_#389(4..9),_#411(4..9),_#433(1..3:5..9),_#455(1..3:5..9),_#477(1..3:5..9),_#499(1..2:4..9),_#521(1:3..9),_#543(2..9),
        _#565(2..9),_#587(1:3..9),_#609(1..2:4..9),_#631(1..3:5..9),_#653(1..9),_#675(1..3:5..9),_#697(1..2:4..9),_#719(1:3..9),_#741(2..9),
        _#763(2..9),_#785(1:3..9),_#807(1..2:4..9),_#829(1..3:5..9),_#851(1..9),_#873(1..3:5..9),_#895(1..2:4..9),_#917(1:3..9),_#939(2..9),
        _#961(2..9),_#983(1:3..9),_#1005(1..2:4..9),_#1027(1..3:5..9),_#1049(1..9),_#1071(1..3:5..9),_#1093(1..2:4..9),_#1115(1:3..9),_#1137(2..9),
        _#1159(2..9),_#1181(1:3..9),_#1203(1..2:4..9),_#1225(1..3:5..9),_#1247(1..9),_#1269(1..3:5..9),_#1291(4..9),_#1313(4..9),_#1335(4..9),
        _#1357(2..9),_#1379(1:3..9),_#1401(1..2:4..9),_#1423(1..3:5..9),_#1445(1..9),_#1467(1..3:5..9),_#1489(4..9),_#1511(4..9),_#1533(4..9),
        _#1555(5..9),_#1577(5..9),_#1599(5..9),_#1621(5..9),_#1643(5..9),4,3,2,1]

        yes

  I do not know why prolog is giving us the solution in that format... Does any one know why? I am sure that we can force prolog to print more readable solutions, but I have not investigated it. Anyway, the point of the exercise is to show how well does prolog fit for this kind of problems.

And this is it. Prolog week finish here (at least the coding part, tomorrow at 14:00 BST the study group meets to talk about the week). I really enjoyed prolog and now I have another tool in my toolbox (and a one less thing I did not know I did not know).

See you next week with Scala! Unfortunately I will be very bussy next week and I will not finish the three days :(
