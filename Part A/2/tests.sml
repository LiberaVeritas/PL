(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw2.sml";

val test1 = all_except_option ("string", ["string"]) = SOME []

val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = []

val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = []

val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test5 = card_color (Clubs, Num 2) = Black

val test6 = card_value (Clubs, Num 2) = 2

val test7 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []

val test8 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true

val test9 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4

val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)


             
             

val a1 = all_except_option ("a", ["a", "b", "c"]) = SOME ["b", "c"]
val a2 = all_except_option ("b", ["a", "c"]) = NONE
val a3 = all_except_option ("a", []) = NONE


val b1 = get_substitutions1 ([], "a") = []
val b2 = get_substitutions1 ([[]], "a") = []
val b3 = get_substitutions1 ([["b", "c", "d"], ["x", "y"]], "a") = []
val b4 = get_substitutions1 ([["a", "b"], ["x", "y", "z"], [], ["y", "p"]], "y") =
["x", "z", "p"]
val b5 = get_substitutions1 ([["y", "b"], ["x", "y", "z"], ["p", "y"]], "y") =
["b", "x", "z", "p"]
val b6 = get_substitutions1 ([["a", "b"], ["x", "y", "z"], ["p", "q"]], "y") =
["x", "z"]
val b7 = get_substitutions1 ([["Fred","Fredrick"],
                              ["Elizabeth","Betty"],
                              ["Freddie","Fred","F"]],
                              "Fred") = ["Fredrick","Freddie","F"]
val b8 = get_substitutions1 ([["Fred","Fredrick"],
                              ["Jeff","Jeffrey"],
                              ["Geoff","Jeff","Jeffrey"]],
                              "Jeff") = ["Jeffrey","Geoff","Jeffrey"]


val c1 = get_substitutions2 ([], "a") = []
val c2 = get_substitutions2 ([[]], "a") = []
val c3 = get_substitutions2 ([["b", "c", "d"], ["x", "y"]], "a") = []
val c4 = get_substitutions2 ([["a", "b"], ["x", "y", "z"], [], ["y", "p"]], "y") =
["x", "z", "p"]
val c5 = get_substitutions2 ([["y", "b"], ["x", "y", "z"], ["p", "y"]], "y") =
["b", "x", "z", "p"]
val c6 = get_substitutions2 ([["a", "b"], ["x", "y", "z"], ["p", "q"]], "y") =
["x", "z"]
val c7 = get_substitutions2 ([["Fred","Fredrick"],
                             ["Elizabeth","Betty"],
                             ["Freddie","Fred","F"]],
                             "Fred") = ["Fredrick","Freddie","F"]
val c8 = get_substitutions2 ([["Fred","Fredrick"],
                             ["Jeff","Jeffrey"],
                             ["Geoff","Jeff","Jeffrey"]],
                             "Jeff") = ["Jeffrey","Geoff","Jeffrey"]


val d1 = similar_names ([], {first="a", middle="b", last="c"}) =
[{first="a", middle="b", last="c"}]

val d2 = similar_names ([[]], {first="a", middle="b", last="c"}) =
[{first="a", middle="b", last="c"}]

val d8 = similar_names ([["a"]], {first="a", middle="b", last="c"}) =
[{first="a", middle="b", last="c"}]

val d4 = similar_names (
[["b", "c", "d"], ["x", "y"]],
{first="a", middle="b", last="c"})
=
[{first="a", middle="b", last="c"}]

val d5 = similar_names (
[["a", "b"], ["x", "y", "z"], [], ["y", "p"]],
{first="y", middle="b", last="c"})
=
[{first="y", middle="b", last="c"},
{first="x", middle="b", last="c"},
{first="z", middle="b", last="c"},
{first="p", middle="b", last="c"}]

val d6 = similar_names (
[["y", "b"], ["x", "y", "z"], ["p", "y"]], 
{first="y", middle="b", last="c"})
=
[{first="y", middle="b", last="c"},
{first="b", middle="b", last="c"},
{first="x", middle="b", last="c"},
{first="z", middle="b", last="c"},
{first="p", middle="b", last="c"}]


val d7 = similar_names (
[["a", "b"], ["x", "y", "z"], ["p", "q"]], 
{first="y", middle="b", last="c"})
=
[{first="y", middle="b", last="c"},
{first="x", middle="b", last="c"},
{first="z", middle="b", last="c"}]



exception T
val cardt = (Clubs, Jack)
val raised = (Hearts, Ace)
val cc1 = remove_card ([], cardt, T) handle T => [raised]
val cc2 = remove_card ([(Clubs, Num 1)], cardt, T) handle T => [raised]
val cc3 = remove_card ([(Clubs, Num 1), cardt, (Spades, King)], cardt, T) =
[(Clubs, Num 1), (Spades, King)]


val cd1 = all_same_color [] = true
val cd2 = all_same_color [(Hearts, Ace)] = true
val cd3 = all_same_color [(Hearts, Ace), (Spades, Ace)] = false
val cd4 = all_same_color [(Hearts, Ace), (Diamonds, Ace), (Hearts, Jack)] = true
val cd5 = all_same_color [(Hearts, Ace), (Diamonds, Ace), (Clubs, Jack)] = false

val ce1 = sum_cards [] = 0
val ce2 = sum_cards [(Hearts, Ace), (Hearts, Jack), (Hearts, Num 2)] = 23

val df1 = score ([], 10) = 5
val df2 = score ([(Hearts, Num 2), (Clubs, Num 3), (Clubs, Num 4), (Clubs, Num 5)], 15) = 1 
val df3 = score ([(Hearts, Num 2), (Clubs, Num 3), (Clubs, Num 4), (Clubs, Num 5)], 11) = 9
val df4 = score ([(Spades, Num 2), (Clubs, Num 3), (Clubs, Num 4), (Clubs, Num 5)], 14) = 0
val df5 = score ([(Spades, Num 2), (Clubs, Num 3), (Clubs, Num 4), (Clubs, Num 5)], 15) = 0
val df6 = score ([(Spades, Num 2), (Clubs, Num 3), (Clubs, Num 4), (Clubs, Num 5)], 11) = 4
val df7 = score ([(Spades, Num 2), (Clubs, Num 3), (Clubs, Num 4), (Clubs, Num 5)], 14) = 0
val df8 = score ([(Spades, Num 2), (Clubs, Num 3), (Clubs, Num 4), (Clubs, Num 5)], 0) = 21

val dg1 = officiate ([], [], 0) = 0
val dg2 = officiate ([(Clubs, Ace)], [], 0) = 0
val dg3 = officiate ([(Clubs, Ace)], [Draw], 11) = 0
val dg43 = officiate ([], [Draw], 0) = 0
val dg4 = officiate ([(Clubs, Ace)], [Discard (Clubs, Jack)], 11) handle IllegalMove => 0
val dg5 = officiate ([(Clubs, Ace), (Hearts, Jack)], [Draw], 11) = 0
val dg6 = officiate ([(Clubs, Ace), (Hearts, Jack)], [Draw, Draw], 21) = 0
val dg7 = officiate ([(Clubs, Ace), (Hearts, Jack)], [Draw, Draw, Discard (Clubs, Ace)], 30) = 10
val dg8 = officiate ([(Diamonds, Ace), (Hearts, Jack)], [Draw, Draw, Draw], 21) = 0
val dg9 = officiate ([(Diamonds, Ace), (Hearts, Jack)], [Draw, Draw, Draw], 10) = 1
val dg10 = officiate ([(Diamonds, Ace), (Hearts, Jack)], [Draw, Draw, Draw], 20) = 1




val gdg1 = officiate_challenge ([], [], 0) = 0
val gdg2 = officiate_challenge ([(Clubs, Ace)], [], 0) = 0
val gdg3 = officiate_challenge ([(Clubs, Ace)], [Draw], 11) = 0
val gdg43 = officiate_challenge ([], [Draw], 0) = 0
val gdg4 = officiate_challenge ([(Clubs, Ace)], [Discard (Clubs, Jack)], 11) handle IllegalMove => 0
val gdg5 = officiate_challenge ([(Clubs, Ace), (Hearts, Jack)], [Draw], 11) = 0
val gdg6 = officiate_challenge ([(Clubs, Ace), (Hearts, Jack)], [Draw, Draw], 21) = 0
val gdg7 = officiate_challenge ([(Clubs, Ace), (Hearts, Jack)], [Draw, Draw, Discard (Clubs, Ace)], 30) = 10
val gdg8 = officiate_challenge ([(Diamonds, Ace), (Hearts, Jack)], [Draw, Draw, Draw], 21) = 0
val gdg9 = officiate_challenge ([(Diamonds, Ace), (Hearts, Jack)], [Draw, Draw, Draw], 10) = 1
val gdg10 = officiate_challenge ([(Diamonds, Ace), (Hearts, Jack)], [Draw, Draw, Draw], 20) = 1
