(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* solutions for problem 1 *)


(* SOME lst where lst is given list with given string removed,
NONE if string is not in list
string * string list -> string list option *)
fun all_except_option (s, strings) =
    (* list with string removed *)
    let exception NotInList
        fun all_except (s, []) = raise NotInList
          | all_except (s, x::xs) =
                if same_string (s, x) then xs else x::all_except (s, xs)
    in SOME (all_except (s, strings)) handle NotInList => NONE
    end

(* list of strings in subs containing s, excepting s
string list list * string -> string list *)
fun get_substitutions1 ([], s) = []
  | get_substitutions1 (sub::rest, s) = 
        case all_except_option (s, sub) of
            NONE => get_substitutions1 (rest, s)
          | SOME ys => ys @ get_substitutions1 (rest, s)

(* tail recursive version *)
fun get_substitutions2 ([], s) = []
  | get_substitutions2 (subs, s) =
        let fun f ([], s, acc) = acc
              | f (sub::rest, s, acc) =
                    case all_except_option (s, sub) of
                        NONE => f (rest, s, acc)
                      | SOME ys => f (rest, s, acc @ ys)
        in f (subs, s, [])
        end

(* list of names with all possible first name substitutes 
string list list * name' -> name' list *)
fun similar_names ([], name) = [name]
  | similar_names (subs, {first=f, middle=m, last=l}) =
        (* list of names with each first name in list *)
        let fun make_names ([], m, l) = []
              | make_names (f::fs, m, l) =
                  {first=f, middle=m, last=l} :: make_names (fs, m, l)
        in case get_substitutions1 (subs, f) of  
                [] => make_names ([f], m, l)
              | fs => make_names (f::fs, m, l)
        end



(* assume that Num is always used with values 2, 3, ..., 10 *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* solutions for problem 2 *)


(* card -> color *)
fun card_color (Clubs, _) = Black
  | card_color (Spades, _) = Black
  | card_color (_,_) = Red

(* card -> int[2, 11] *)
fun card_value (_, Num r) = r
  | card_value (_, Ace) = 11
  | card_value (_, _) = 10

(* list of card with given card removed,
exn if card not in list
card list * card * exn -> card list *)
fun remove_card ([], _, e) = raise e
  | remove_card (c::cs, target, e) =
        if c = target
        then cs
        else c::remove_card (cs, target, e)
    
(* whether all cards in list have same color
card list -> bool *)
fun all_same_color [] = true
  | all_same_color (_::[]) = true
  | all_same_color (c::c'::cs) = 
        card_color c = card_color c' andalso all_same_color (c'::cs)

(* sum of card values
card list -> int[>2] *)
fun sum_cards cs =
    let fun sum ([], acc) = acc
          | sum (c::cs, acc) = sum (cs, acc + card_value c)
    in sum (cs, 0)
    end

(* the score of a list of held cards given a goal, where score is
goal - sum if sum <= goal,
3 * (sum - goal) if sum > goal,
score / 2 if all cards have same color,
goal / 2 if hand is empty
card list * int[>=0] -> int[>=0] *)
fun score (cs, goal) =
    let 
        val sum = sum_cards cs
        val prelim = 
            if sum <= goal
            then goal - sum
            else 3 * (sum - goal)
    in if all_same_color cs then prelim div 2 else prelim
    end

(* card list * move list * int[>=0] -> int[>=0] *)
(* result of playing the game *)
fun officiate (cs, mvs, goal) =
    let fun f (cs, mvs, hand) = 
            case (cs, mvs, hand, (sum_cards hand) > goal) of
                (_, _, _, true) => score (hand, goal)
              | (_, [], hand, false) => score (hand, goal)
              | ([], (Draw::mvs), hand, false) => score (hand, goal)
              | (c::cs, (Draw::mvs), hand, false) =>
                    f (cs, mvs, c::hand)
              | (cs, (Discard c::mvs), hand, false) =>
                    f (cs, mvs, remove_card (hand, c, IllegalMove))
    in f (cs, mvs, [])
    end










(* challenge problems *)

(* sum of card values, first sum with ace 11 and second with ace 1
card list -> int[>2] * int[>2] *)
fun sum_cards_challenge cs =
    let fun sum ([], acc, acc2) = (acc, acc2)
          | sum ((_, Ace)::cs, acc, acc2) = sum (cs, acc + 11, acc2 + 1)
          | sum (c::cs, acc, acc2) = sum (cs, acc + card_value c, acc2 + card_value c)
    in sum (cs, 0, 0)
    end

(* the score of a list of held cards given a goal, where score is
goal - sum if sum <= goal,
3 * (sum - goal) if sum > goal,
score / 2 if all cards have same color,
goal / 2 if hand is empty,
and aces can be either 1 or 11
card list * int[>=0] -> int[>=0] *)
fun score_challenge (cs, goal) =
    let 
        val (sum, sum2) = sum_cards_challenge cs
        val prelim = 
            if sum <= goal
            then goal - sum
            else 3 * (sum - goal)
        val prelim2 =
            if sum2 <= goal
            then goal - sum2
            else 3 * (sum2 - goal)
        val best = Int.min (prelim, prelim2)
    in if all_same_color cs then best div 2 else best
    end

(* card list * move list * int[>=0] -> int[>=0] *)
(* result of playing the game *)
fun officiate_challenge (cs, mvs, goal) =
    let fun g ((a, b), goal) = a > goal andalso b > goal
        fun f (cs, mvs, hand) = 
            case (cs, mvs, hand, g (sum_cards_challenge hand, goal)) of
                (_, _, _, true) => score_challenge (hand, goal)
              | (_, [], hand, false) => score_challenge (hand, goal)
              | ([], (Draw::mvs), hand, false) => score_challenge (hand, goal)
              | (c::cs, (Draw::mvs), hand, false) =>
                    f (cs, mvs, c::hand)
              | (cs, (Discard c::mvs), hand, false) =>
                    f (cs, mvs, remove_card (hand, c, IllegalMove))
    in f (cs, mvs, [])
    end



fun careful_player (cs, goal) =
    let 
        fun g ([], _) = false
          | g (c::cs, []) = (score (cs, goal) = 0)
          | g (c::cs, x::xs) = (score (x::cs, goal) = 0)
        fun h (cs) =
                case cs of
                    [] => []
                  | c::cs => if score (cs, goal) = 0 then [Discard c, Draw] else h cs
        fun f (cs, hand, moves) =
                case (cs, score (hand, goal), g (hand, cs)) of
                    (_, 0, _) => moves
                  | (_, _, true) => moves @ h hand
                  | ([], _, false) => moves @ h hand
                  | (c::cs, _, false) => 
                        if (goal - sum_cards hand) <= 10
                        then moves @ h hand 
                        else if (sum_cards (c::hand)) > goal
                        then moves @ h hand
                        else f (cs, (c::hand), moves @ [Draw])
    in f (cs, [], [])
    end
