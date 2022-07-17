(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

(* solutions *)


(* list of only the strings that start with a capital *)
val only_capitals = List.filter (Char.isUpper o (fn s => String.sub (s, 0)))

(* longest string in list, tie break towards head *)
fun longest_string1 xs =
  let fun bigger (a, b) =
        case String.size a > String.size b of true => a | false => b
  in foldl bigger "" xs end

(* longest string in list, tie break towards tail *)
fun longest_string2 xs =
  let fun bigger (a, b) =
        case String.size a >= String.size b of true => a | false => b
  in foldl bigger "" xs end

fun longest_string_helper f xs =
  let val sz = String.size
      fun helper xs acc =
        case xs of
            [] => acc
          | x::xs => helper xs (if f (sz x, sz acc) then x else acc)
  in helper xs ""
  end

(* longest string in list, tie break towards head *)
val longest_string3 = longest_string_helper (fn (a, b) => a > b)

(* longest string in list, tie break towards tail *)
val longest_string4 = longest_string_helper (fn (a, b) => a >= b)

(* longest string that starts with a capital *)
val longest_capitalized = longest_string1 o only_capitals

(* reverse a string *)
val rev_string = String.implode o List.rev o String.explode

(* v where f of some element is SOME v, otherwise raise NoAnswer *)
fun first_answer _ [] = raise NoAnswer
  | first_answer f (x::xs) =
        case f x of SOME v => v | NONE => first_answer f xs 

(* SOME [lst1, lst2,...] such that f x1 = SOME lst1, f x2 = SOME lst2,... ,
NONE if f of any x is NONE *)
fun all_answers f [] = SOME []
  | all_answers f xs =
      let fun mapf [] acc = acc
            | mapf (x::xs) acc = 
                case f x of NONE => raise NoAnswer | SOME lst => mapf xs (acc @ lst)
      in SOME (mapf xs []) handle NoAnswer => NONE
      end


datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(* constant 0 function *)
val zero = (fn _=> 0)
(* constant 1 function *)
val one = (fn _ => 1)

(* the number of wildcards in a pattern *)
val count_wildcards = g one zero

(* number of wildcards plus then lengths of all variable lengths *)
val count_wild_and_variable_lengths = g one String.size

(* the number of times a variable name appears in a pattern *)
fun count_some_var (s, p) =
    g zero (fn x => if x = s then 1 else 0) p

(* whether a pattern contains repeated variable names *)
fun check_pat p =
  let fun only_vars p =
          case p of 
              Variable s => [s]
            | TupleP (p::ps) => (only_vars p) @ (only_vars (TupleP ps))
            | _ => []
      fun unique xs =
          case xs of
              [] => true
            | x::xs => if List.exists (fn s => x = s) xs then false else unique xs
  in unique (only_vars p)
  end

(* list of bindings if value matches pattern, or NONE *)
fun match (v, p) =
  case (v, p) of  
      (v, Variable s) => SOME [(s, v)]
    | (Constructor (s1, v), ConstructorP (s2, p)) =>
          if s1 = s2 then match (v, p) else NONE
    | (Tuple vs, TupleP ps) =>
          let val pairs = SOME (ListPair.zipEq (vs, ps))
                          handle ListPair.UnequalLengths => NONE
          in case pairs of SOME xs => all_answers match xs | NONE => NONE
          end
    | (Unit, UnitP) => SOME []
    | (Const _, ConstP _) => SOME []
    | (_, Wildcard) => SOME []
    | _ => NONE

(* first matching binding, or NONE if no match *)
fun first_match v ps =
    SOME (first_answer (fn p => match (v, p)) ps)
    handle NoAnswer => NONE




(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

