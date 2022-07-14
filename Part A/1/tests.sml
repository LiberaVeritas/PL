(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";

val test1 = is_older ((1,2,3),(2,3,4)) = true

val test2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1

val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

val test4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"

val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"

val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3

val test9 = what_month 70 = 3

val test10 = month_range (31, 34) = [1,2,2,2]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)


val test12 = is_older ((1,2,3),(1,2,3)) = false

val test13 = is_older ((2,2,3),(1,2,4)) = false

val test93 = is_older ((2, 3, 4), (1, 2, 3)) = false


val test14 = is_older ((2, 2, 3), (2, 1, 3)) = false

val test15 = is_older ((3, 2, 3), (2, 1, 3)) = false

val test16 = is_older ((1, 4, 2), (1, 3, 3)) = false

val test17 = dates_in_month ([], 5) = []

val test18 = dates_in_month ([(2012,2,28),(2013,12,1)],5) = []

val test19 = number_in_months ([], []) = 0

val test20 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 0

val test21 = number_in_months ([], [1,2,3]) = 0

val test22 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1, 5]) = 0

val test23 = number_in_months ([(2012,2,28),(2013,2,1),(2011,2,31),(2011,4,28)],[2, 4]) = 4

val test24 = number_in_month ([(2012,2,28),(2013,12,1)],1) = 0

val test25 = number_in_month ([(2012,2,28),(2013,2,1)],2) = 2




val test26 = dates_in_months ([], []) = []

val test27 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = []

val test28 = dates_in_months ([], [1,2,3]) = []

val test29 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1, 5]) = []

val test30 = dates_in_months ([(2012,2,28),(2013,2,1),(2011,2,31),(2011,4,28)],[2, 4]) = [(2012,2,28),(2013,2,1),(2011,2,31),(2011,4,28)]

val test31 = dates_in_month ([(2012,2,28),(2013,12,1)],1) = []

val test32 = dates_in_month ([(2012,2,28),(2013,2,1)],2) = [(2012,2,28),(2013,2,1)]

val test33 = get_nth (["hi", "there", "how", "are", "you"], 0) = "hi"

val test34 = get_nth (["hi", "there", "how", "are", "you"], ~2) = "hi"

val test35 = number_before_reaching_sum (1, [2,3,4,5]) = 0

val test36 = number_before_reaching_sum (6, [1,2,3,4,5]) = 2

val test37 = number_before_reaching_sum (100, [1,2,3,4,5]) = 5

val test38 = number_before_reaching_sum (100, []) = 0


val test49 = what_month 1 = 1

val test59 = what_month 365 = 12

val test69 = what_month 59 = 2

val test79 = what_month 32 = 2

val test410 = month_range (1, 1) = [1]

val test411 = month_range (2, 1) = []

val test412 = month_range (31, 32) = [1, 2]

val test413 = month_range (31, 60) 

val test511 = oldest([]) = NONE

val test611 = oldest([(2012,2,28)]) = SOME (2012,2,28)

val test711 = oldest([(2012,2,28), (2012,2,28)]) = SOME (2012,2,28)

val test811 = oldest([(2012,2,28),(2011,2,28)]) = SOME (2011,2,28)




val test5553 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2, 2,4, 3, 2,4, 4]) = 3


val tes5555 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,4, 3,4, 3, 3])


val a = reasonable_date (0, 1, 1) = false
val a1 = reasonable_date (4, 2, 29)


val c = is_older ((1,2,25),(1,12,29)) = true

val c1 = is_older ((1,2,25), (1,2,27)) = true

val c2 = is_older ((5,4,4) , (4,5,4)) = false

val d = oldest [(5,5,2),(5,10,2),(5,2,2),(5,12,2)] = SOME (5,2,2)

val d1 = oldest [(5,12,15),(5,12,10),(5,12,1)] = SOME (5,12,1)
