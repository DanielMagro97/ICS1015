%Question1

% 1a
% leftPush(Item,OldDeque,NewDeque).
/* The 'Item' to be pushed to the left of the 'NewDeque' is attached to the 'OldDeque'
 * using the Bar Notation. The first two arguments are 'inputs' and the last one is an 'output'.
 */

leftPush(Item,OldDeque,[Item|OldDeque]).

%leftPush(6,[1,2,3],L). => L = [6,1,2,3]



% 1b
%rightPop(OldDeque,Item,NewDeque)

% Base Case, Deque with one(/last) element
rightPop([Item],Item,[]).
/* General Case, OldDeque still has multiple elements. The Head and Tail of the 'OldDeque' are
 * split in the first argument, [H|T], and the same rule is called recusrively using the Tail.
 * Recurive calls carry on until the Base Case is reached, when only one 'Item' remains,
 * that which is to be popped, which is set as the second argument. Then the recursive unwinding
 * starts happening, where each Head is attached to the start of the List using the Bar Notation,
 * [H|T2], which will eventually become 'NewDeque'. The first recursive call back after the base
 * case attaches the empty list to the head (which is now the new last(rightmost) element),
 * which is how it is popped.
 */
rightPop([H|T],Item,[H|T2]) :- rightPop(T,Item,T2).

%rightPop([6,1,2,3],I,L). => I = 3, L = [6,1,2]



% 1c
%leftPop(OldDeque,Item,NewDeque)

/* The 'Item' to be popped from the left of the 'OldDeque' is removed from the 'OldDeque'
 * using the Bar Notation. The first two arguments are 'inputs' and the last one is an 'output'.
 * The 'Item' is set to the Head of the OldDeque, and the NewDeque is set to the Tail of the OldDeque.
 */
leftPop([H|T],H,T).

%leftPop([6,1,2,3],I,L). => I = 6, L = [1,2,3]


%rightPush(Item,OldDeque,NewDeque).

% Base Case, pushing an item to an empty List
rightPush(Item,[],[Item]).
/* General Case, OldDeque still has multiple elements. The Head and Tail of the 'OldDeque' are
 * split in the second argument, [H|T], and the same rule is called recusrively using the Tail.
 * Recurive calls carry on until the Base Case is reached, when the empty List is reached,
 * and the item to be pushed, which is set as the first argument, can be inserted easily
 * Then the recursive unwinding starts happening, where each Head is attached to the start of the
 * List using the Bar Notation, [H|T2], which will eventually become 'NewDeque'.
 */
rightPush(Item,[H|T],[H|T2]) :- rightPush(Item,T,T2).

%rightPush(6,[1,2,3],L). => L = [1,2,3,6]



% 1d
% checkEmpty(Deque)

% Predicate, The fact that a Deque is empty if it is an Empty List.
checkEmpty([]).

/* 
 * checkEmpty([]). => yes
 * checkEmpty([1]). => no
 * checkEmpty([6,1,2,3]). => no
 */



% 1e
%dequeSize([6,1,2,3],S).

% Base Case, an empty Deque has size 0
dequeSize([],0).
/* General Case, in the first argument the Deque is Split using the Bar Notation, [_|T], discarding
 * the head as it has no relevance, and the same rule is called recursively until the Base Case is
 * reached. The Base case sets the Size to 0 and starts the recursive unwinding. Each time another
 * rule is unwound, the size of the deque is incremented.
 */
dequeSize([_|T],S) :- dequeSize(T,S1), S is S1+1.

%dequeSize([6,1,2,3],S). => S = 4

