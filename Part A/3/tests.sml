(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw3.sml";

val test1 = only_capitals ["A","B","C"] = ["A","B","C"]

val test2 = longest_string1 ["A","bc","C"] = "bc"

val test3 = longest_string2 ["A","bc","C"] = "bc"

val test4a = longest_string3 ["A","bc","C"] = "bc"

val test4b = longest_string4 ["A","B","C"] = "C"

val test5 = longest_capitalized ["A","bc","C"] = "A"

val test6 = rev_string "abc" = "cba"

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

val test9a = count_wildcards Wildcard = 1

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9c = count_some_var ("x", Variable("x")) = 1

val test10 = check_pat (Variable("x")) = true

val test11 = match (Const(1), UnitP) = NONE

val test12 = first_match Unit [UnitP] = SOME []


val t1 = only_capitals [] = []
val t2 = only_capitals ["a", "b", "c"] = []
val t3 = only_capitals ["a", "B", "C"] = ["B", "C"]

val t4 = longest_string1 [] = ""
val t5 = longest_string1 ["a"] = "a"
val t6 = longest_string1 ["a", "ab", "c"] = "ab"
val t7 = longest_string1 ["a", "ab", "cd", "e"] = "ab"

val t8 = longest_string_helper (fn (a, b) => a > b) ["a", "ab", "cd", "e"] = "ab"
val t9 = longest_string_helper (fn (a, b) => a >= b) ["a", "ab", "cd", "e"] = "cd"

val t24 = longest_string2 [] = ""
val t25 = longest_string2 ["a"] = "a"
val t26 = longest_string2 ["a", "ab", "c"] = "ab"
val t27 = longest_string2 ["a", "ab", "c", "cd", "e"] = "cd"

val t43 = longest_string3 [] = ""
val t53 = longest_string3 ["a"] = "a"
val t63 = longest_string3 ["a", "ab", "c"] = "ab"
val t73 = longest_string3 ["a", "ab", "cd", "e"] = "ab"


val t244 = longest_string4 [] = ""
val t254 = longest_string4 ["a"] = "a"
val t264 = longest_string4 ["a", "ab", "c"] = "ab"
val t274 = longest_string4 ["a", "ab", "c", "cd", "e"] = "cd"


val s1 = longest_capitalized [] = ""
val s2 = longest_capitalized ["a", "b"] = ""
val s3 = longest_capitalized ["a", "B", "c", "Df"] = "Df"

val s4 = rev_string "" = ""
val s5 = rev_string "ab" = "ba"

val h1 = all_answers (fn x => x) [] = SOME []
val tasdf2 = (fn x => if x = 1 then SOME [x, x+1] else NONE)
val h2 = all_answers tasdf2 [1, 3, 1] = NONE
val h3 = all_answers tasdf2 [1, 1, 1] = SOME [1, 2, 1, 2, 1, 2]

val x1 = count_wildcards (TupleP [ConstructorP("af", Wildcard),Wildcard, Variable "a", Wildcard]) = 3
val x2 = count_wild_and_variable_lengths (TupleP [Variable "abcde", Wildcard]) = 6
val x3 = count_some_var ("abcde", (TupleP [Variable "abcde", Wildcard])) = 1
val x4 = check_pat (TupleP 
[Wildcard,
TupleP [Wildcard, Variable "a", TupleP
[Wildcard, Variable "b", Wildcard]],
Wildcard, Variable "a", Wildcard]) =
false
val x5 = check_pat (TupleP 
[Wildcard,
TupleP [Wildcard, Variable "a", TupleP
[Wildcard, Variable "b", Wildcard]],
Wildcard, Variable "c", Wildcard]) =
true

val x6 = match (Unit, TupleP []) = NONE
val x7 = match (Unit, UnitP) = SOME []
val x8 = match (
Tuple [Unit, Const 1, Constructor ("a", Const 2)],
TupleP [UnitP, ConstP 1, ConstructorP ("a", ConstP 2)]) = SOME []

val x9 = match (
Tuple [Unit, Const 1, Const 2, Tuple [Const 3]],
TupleP [Variable "a", Variable "b", Variable "c", TupleP [Variable "d"]]) =
SOME [("a", Unit), ("b", Const 1), ("c", Const 2), ("d", Const 3)]

val x10 = match (
Tuple [Unit, Const 1],
TupleP [Variable "a", Variable "b", Variable "c"]) = NONE

val y1 = first_match Unit [] = NONE
val y2 = first_match Unit [ConstP 1, UnitP] = SOME []
val y3 = first_match Unit [ConstP 1, Variable "a"] = SOME [("a", Unit)]
