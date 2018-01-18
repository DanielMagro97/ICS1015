% Question 4

% 4a
%mem_of(M,S).

% Base Case, If the Head of the list is the same as the element being checked for membership, M, then 'M' is a member of 'S'.
mem_of(M,[M|_]).
/* General Case, If the base case is not satisfied, The Head and the Tail of the set (list) are seperated in the second argument,
 * using the bar notation, [H|T]. However H is discarded using '_' since it is not needed. The same relation is then called
 * recursively using the tail 'T'.
 */
mem_of(M,[_|T]) :- mem_of(M,T).

/* Another possible way of implementing mem_of
 * mem_of(M,[H|T]) :- H=:=M; mem_of(M,T). */

/* An easier (and possibly more efficient) way of doing this would be to use the inbuilt Prolog method.
 * mem_of(M,S) :- member(M,S).
 */

%mem_of(6,[2,6,3,4]). => yes
%mem_of(6,[2,5,3,4]). => no



% 4b
%subset_of(S1,S2).

% Base Case, The empty set is a subset of any other set.
subset_of([],_).
/* General Case, First, the Head and the Tail of the first set 'S1' are split in the first argument, [H|T].
 * Next, it is checked whether the Head 'H' is an element of the set 'S2' and the same relation is called recursively, using the Tail 'T'.
 * The recursive calls keep occuring until all the heads have been checked
 * until the tail, T, is the empty list, which is the base case.
 * If all the elements of S1 are also present in S2, this must mean that S1 is a subset of S2.
 */
subset_of([H|T],S2) :- mem_of(H,S2),subset_of(T,S2).

%subset_of([2,4],[2,6,3,4]). => yes



% 4c
%intersect(S1,S2,S3).

% The intersection of the empty set with any set is the empty set
intersect([],_,[]).
/* The first argument, [X|S1], splits the head, X, and the tail, now named S1, of the set 'S1',
 * Then, the relation checks if 'X' is a member of S2. If so, the same relation is called using the tail of S1.
 * Also, because of the third argument, [X|S3], X is attached to the resulting set, S3.
 * If not, The next rule is applicable.
 */
intersect([X|S1],S2,[X|S3]) :- mem_of(X,S2), intersect(S1,S2,S3).
/* This rule is applicable when X is not a member of S2. This relation simply calls the intersect procedure using
 * the tail of S1, discarding the head (since it does not occur in S2 it is not part of the intersect).
 */
intersect([_|S1],S2,S3) :- intersect(S1,S2,S3).

%intersect([20,4,13,11,24],[33,2,4,11,20,68],S). => S = [20,4,11].



% 4d
%unite(S1,S2,S3).

% The union of an empty set and any other set is the set.
unite([],S,S).
/* The first argument, [X|S1], splits the head, X, and the tail, now named S1, of the set 'S1',
 * Then, the relation checks if 'X' is NOT a member of S2. If 'X' is not a member of S2, The same relation is called recursively using the tail of S1.
 * The above is done to avoid duplicates in the resulting set union. The recursive calls keep occuring until S1 is an empty set.
 * At this point, the base case is reached, and thus the resulting set becomes 'S2'. Then, with each successive call back,
 * 'X' is attached to the head of the resultant set, 'S3'.
 * If 'X' is a member of S2, then the following rule is applicable.
 */
unite([X|S1],S2,[X|S3]) :- not(mem_of(X,S2)), unite(S1,S2,S3).
/* This rule is applicable when X is a member of S2. This relation simply calls the unite procedure using the tail
 * of S1, discarding the head (since it occurs in S2, and S3 (the resulting set) will be set to S2 in the base case,
 * there is no need for S1 to contain it as it will lead to repeated elements).
 */
unite([_|S1],S2,S3) :- unite(S1,S2,S3).

%unite([5,2,6,3,4],[1,5,7,2,4],S). => S = [6,3,1,5,7,2,4]
