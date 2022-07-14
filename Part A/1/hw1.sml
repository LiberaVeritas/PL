(* Homework 1 solutions *)

(* date is (int*int*int), year month and day *)


(* whether first date comes strictly before second
: bool *)
fun is_older (date1 : (int*int*int), date2 : (int*int*int)) =
    let 
        val y1 = #1 date1
        val y2 = #1 date2
        val m1 = #2 date1
        val m2 = #2 date2
        val d1 = #3 date1
        val d2 = #3 date2
    in
        y1 < y2 orelse
        y1 = y2 andalso
        (m1 < m2 orelse
             (m1 = m2 andalso d1 < d2))
    end

(* list of only the dates from given list that are in the given month
: (int*int*int) list *)
fun dates_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then []
    else 
        let 
            val date = hd dates
            val rest = dates_in_month (tl dates, month)
        in if #2 date = month
           then date :: rest
           else rest
        end

(* list of only the dates from given list that are in any of the given months
: (int*int*int) list *)
fun dates_in_months (dates : (int*int*int) list, months : int list) =
    if null dates orelse null months
    then []
    else dates_in_month (dates, hd months) @ dates_in_months (dates, tl months)

(* the number of given dates that are in the given month
: int *)
fun number_in_month (dates : (int*int*int) list, month : int) =
    let fun count_dates (dates : (int*int*int) list) = 
            if null dates
            then 0
            else 1 + count_dates (tl dates)
    in count_dates (dates_in_month (dates, month))
    end

(* the number of given dates that are in any of the given months
: int *)
fun number_in_months (dates : (int*int*int) list, months : int list) =
    if null dates orelse null months
    then 0
    else number_in_month (dates, hd months) + number_in_months (dates, tl months)

(* the nth string in list for a given n, first string if n < 1
: string *)
fun get_nth (strings : string list, n : int) =
    if n <= 1
    then hd strings
    else get_nth (tl strings, n - 1)

(* string of form MMM DD, YYYY given a date
: string *)
fun date_to_string (date : (int*int*int)) =
    let
        val months = ["January", "February", "March", "April", "May", "June", "July",
                      "August", "September", "October", "November", "December"]
        val year = Int.toString (#1 date)
        val month = get_nth (months, #2 date)
        val day = Int.toString (#3 date)
    in month ^ " " ^ day ^ ", " ^ year
    end

(* n such that the sum of the first n ints is less than given sum,
and the sum of the first n + 1 ints is at least the given sum
: int *)
fun number_before_reaching_sum (sum : int, ints : int list) =
    if null ints
    then 0
    else
        let 
            val x = hd ints
            val so_far = number_before_reaching_sum (sum - x, tl ints)
        in if x >= sum
           then so_far
           else 1 + so_far
        end

(* month that given day in year is in
: int *)
fun what_month (day : int) =
    let val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in 1 + number_before_reaching_sum (day, days_in_months)
    end

(* list of months each day of given day range is in
: int list *)
fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month day1 :: month_range (1 + day1, day2)

(* oldest date from given list, NONE if list is empty
: (int*int*int) option *)
fun oldest (dates : (int*int*int) list) =
    if null dates
    then NONE
    else 
        let fun oldest_in (dates : (int*int*int) list, oldest_so_far : (int*int*int)) =
                if null dates
                then oldest_so_far
                else if is_older (hd dates, oldest_so_far)
                     then oldest_in (tl dates, hd dates)
                     else oldest_in (tl dates, oldest_so_far)
        in SOME (oldest_in (dates, hd dates))
        end







(* challenge problems *)


(* whether given int is in given list of ints
: bool *)
fun member (x : int, xs : int list) =
    if null xs
    then false
    else x = hd xs orelse member (x, tl xs)

(* list with duplicated removed from given list
: int list *)
fun duplicates_removed (xs : int list) =
    if null xs
    then []
    else
        let 
            val rest = duplicates_removed (tl xs)
            val x = hd xs
        in 
           if member (x, rest)
           then rest
           else x :: rest
        end

(* dates_in_months but months may have repeated elements *)
fun dates_in_months_challenge (dates : (int*int*int) list, months : int list) =
    dates_in_months (dates, duplicates_removed months)

(* number_in_months but months may have repeated elements *)
fun number_in_months_challenge (dates : (int*int*int) list, months : int list) =
    number_in_months (dates, duplicates_removed months)



(* whether year is leap year or not *)
fun leap_year (year : int) =
    not (year mod 100 = 0) andalso
    (year mod 400 = 0 orelse year mod 4 = 0)

fun day_valid (day : int, month : int, daylist : int list) =
    if month = 1
    then day <= hd daylist
    else day_valid (day, month - 1, tl daylist)

(* if date is reasonable *)
fun reasonable_date (date : (int*int*int)) = 
    let
        val days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        val leap_year_days = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        val year = #1 date
        val month = #2 date
        val day = #3 date
    in 
        year > 0 andalso
        1 <= month andalso month <= 12 andalso
        1 <= day andalso day <= 31 andalso
        if leap_year year
        then day_valid (day, month, leap_year_days)
        else day_valid (day, month, days)
    end
