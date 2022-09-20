Better to think of subtypes as a canonical injection 
Rather than subsets/partitions
Define it to be "if a:A < B, then a can be substituted anywhere a B is expected without breaking things"
Works for function sub typing too

https://cs.stackexchange.com/questions/91330/what-exactly-is-the-semantic-difference-between-set-and-type


Type is just a construction: rules and properties.
EG. N is the rules of construction (Peano)

A term is something that can be constructed by a Type

A subtype is meets all the rules and properties of the supertype, and perhaps has additional ones
This allows a subtype to be substitued for a supertype

ie. a function expects type Super, ie. it expects that a term will have the properties and follow the rules.
A subtype term would also meet the requirement

Ex
sum type (subsumption) subtype: N < Z, N is just the same construction with the additinal rule of being non negative
product type subtype: {a, b} < {a}, the same construction alogn with an additional rule, for b
