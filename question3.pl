% Question 3

% 3a
%sumOfRatios(Ratio,Sum).

% Base Case, The sum of a ratio with only one term is that term.
sumOfRatios(ratio([X]),X).
/* General Case, In the first argument, the ratio, represented as a list, is split using the Bar Notation, ratio([H|T]).
 * The same relation is called recursively using the Tail, T, until there is only one term left, and thus the base case is reached.
 * The base case sets the sum of the ratio to the single term that is left. Then the recursive call back starts happening
 * With every step of the call back, the Sum 'S' is incremented by the value of the Head 'H'.
 */
sumOfRatios(ratio([H|T]),S) :- sumOfRatios(ratio(T),S1), S is S1 + H.

%sumOfRatios(ratio([3,1,2]),S). => S = 6



% 3b
%reduceRatio(OriginalRatio,FinalRatio).

/* gcd_eff is a generic relation which calculates the Greatest Common Divisor (GCD) of any two integers.
 * gcd is another relation which calculates the GCD of a list of integers
 */
% Base Case
gcd_eff(X,0,L) :- L is X.
gcd_eff(0,Y,L) :- L is Y.
% General Case, Calculates the modulo of the two integers and recursively calls the same rule with the Remainder and the smaller integer.
gcd_eff(X,Y,L) :- (X>Y,(M is X mod Y,gcd_eff(M,Y,L));(M is Y mod X,gcd_eff(X,M,L))).
% Base Case, Calculates the GCD of the last two integers in the list using the gcd_eff relation.
gcd([X,Y],GCD) :- gcd_eff(X,Y,GCD).
/* General Case, The Head and Tail are split in the first argument, [H|T],
 * Then, the same rule is called recursively using the Tail, T, until the Base Case is reached.
 * The base case returns the GCD of the last 2 elements in the list. After that the recursive call back starts happening.
 * With every step of the call back, the value of the is updated with the GCD of the Head and the previous GCD.
 */
gcd([H|T],GCD) :- gcd(T,GCD1), gcd_eff(H,GCD1,GCD).


% Base Case, when only one element is left, the reduced ratio is the element divided by the GCD.
divR([X],GCD,[FR]) :- FR is X/GCD.
/* General Case, The Head and Tail of the ratio list are split in the first argument, [H|T],
 * The Head is divided by the GCD, and stored inside X, the same relation is called again, this time with the Tail.
 * The recursive call keeps happening until there is only one element left, and thus the base case is reached.
 * With every recursive call back after the base case, the reduced ratios are attached to their preceeding term,
 * one by one, using the bar notation, [X|FR].
 * Finally, X is attached to the start of the FinalRatio in the thrid argument, [X|FR].
 */
divR([H|T],GCD,[X|FR]) :- X is H/GCD,divR(T,GCD,FR).

/* This relation first calculates the GCD of all the ratios in the list.
 * then it divides every term/dividend of the ratio by the GCD using the divR relation.
 */
reduceRatio(ratio(OR),FR) :- gcd(OR,GCD),divR(OR,GCD,FR).

%reduceRatio(ratio([30,10,20]),R). => R = ratio([3,1,2])



% 3c
%divideRatio(Amount,Ratio,Parts).

% The mulR relation multiplies every term in the Ratio by 'M'.
% This relation works exactly like divR, only every '/' is replaced by a '*'.
mulR([X],M,[FR]) :- FR is X*M.
mulR([H|T],M,[X|FR]) :- X is H*M,mulR(T,M,FR).

/* This relation first calculates the sum of all the terms in the ratio 'R', using the sumOfRatios relation, and stores the sum in 'S'.
 * Next, it divides the Amount 'A' to be divided among the ratio, by the Sum 'S', and stores the quotient in M.
 * Finally, the relation mulR is called with the Ratio 'R' and 'M', with the output being stored in 'P'.
 */
divideRatio(A,ratio(R),P) :-
	sumOfRatios(ratio(R),S),
	M is A / S,
	mulR(R,M,P).

%divideRatio(54,ratio([30,10,20]),P). => P = [27,9,18]
