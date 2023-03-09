-- 1. Multiset Operators
/*
Collections should be the same type

MULTISET UNION [ALL|DISTINCT] - compbine 2 collection into 2
MULTISET INTERSECT [ALL|DISTINCT] - only common elements of 2
MULTISET EXCEPT [ALL|DISTINCT] - returns elements of one collection which are not presented in other

ALL|DISTINCT - remove or not duplicates
*/


-- 2. SYNTAX
v_collection1 := v_collection2 MULTISET UNION v_collection3 ;
