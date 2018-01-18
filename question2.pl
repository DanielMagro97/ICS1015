% Question 2

% 2a
%extraCoef(Coef,Equation,Value).

/* The following 3 rules each have the first argument set to the coefficient that may be specified in the
 * first argument, being x,y or c(constant). Depending on whichever query is entered into the console,
 * pattern matching occurs on the first argument, and the relevant rule is selected. If the query were
 * to be, say extraCoef(y,eq(1,2,3),V)., then y would be matched to the second rule, 1 and 3 would be
 * discarded, and Y would be set to 2, and V set to Y.
 */
extraCoef(x,eq(X,_,_),X).
extraCoef(y,eq(_,Y,_),Y).
extraCoef(c,eq(_,_,C),C).

%extraCoef(x,eq(2,1,4),V). => V = 2.



% 2b
%sameCoefSign(Coef1,Coef2).

/* The following 3 rules define all possible combinations of Coef1 and Coef2 that have same signs.
 * These being both positive (rule 1),both negative (rule 2) or both 0 (rule 3).
 */
sameCoefSign(X,Y) :- X>0,Y>0.
sameCoefSign(X,Y) :- X<0,Y<0.
sameCoefSign(X,Y) :- X=:=0,Y=:=0.

/*
 * sameCoefSign(-2,-1). => yes
 * sameCoefSign(-2,1). => no
 */



% 2c
%raiseEq(Multiple,OrigEq,FinalEq).

/* This rule works by first creating 3 new variables, one for each coefficient of the FinalEquation.
 * The first argument, T, receives the Multiple by which the first equation will be multiplied.
 * Then, Xt, Yt and Ct are set to their original value multiplied by T, (Xt = X * T, Yt = ...).
 * Finally, the Third argument is eq(Xt,Yt,Ct), which will return the FinalEquation.
 */
raiseEq(T,eq(X,Y,C),eq(Xt,Yt,Ct)) :- Xt is X * T, Yt is Y * T, Ct is C * T.

%raiseEq(2,eq(1,-1,-1),F). => F = eq(2,-2,-2)



% 2d
%solveSim(Eq1,Eq2,Xvalue,Yvalue).
	 
/* First, Eq1 was multiplied throughout by the coefficient of X in Eq2, using the raiseEq relation.
 * The resulting equation was stored in Eq1_2.
 * Similary, the second equation was multiplied throughout by the coefficient of X in the first equation.
 * The resulting equation was stored in Eq2_2.
 * 
 * Next, the coefficient of Y in the newly created first equation, Eq1_2, is stored inside the Variable Vy1 using the extraCoef relation ,
 * Similarly, the coefficient of Y in Eq2_2 was stored inside Vy2.
 * 
 * Similarly, the constant in Eq1_2 is stored inside Vc1 and the constant inside Eq2_2 is stored inside Vc2.
 * 
 * DiffY is set to Vy1 - Vy2 and DiffC is set to Vc1 - Vc2.
 * 
 * The final value of Y, Yv, is set to DiffC / DiffY.
 * 
 * The final value of X, Xv, is set to (C1-(Y1*Yv))/X1.
 */
solveSim(eq(X1,Y1,C1),eq(X2,Y2,C2),Xv,Yv) :-
	raiseEq(X2,eq(X1,Y1,C1),Eq1_2), raiseEq(X1,eq(X2,Y2,C2),Eq2_2),
	extraCoef(y,Eq1_2,Vy1), extraCoef(y,Eq2_2,Vy2),
	extraCoef(c,Eq1_2,Vc1), extraCoef(c,Eq2_2,Vc2),
	DiffY is Vy1 - Vy2, DiffC is Vc1 - Vc2,
	Yv is DiffC / DiffY,
	Xv is (C1-(Y1*Yv))/X1.


%solveSim(eq(2,1,4),eq(1,-1,-1),X,Y). => X = 1, Y = 2.



% 2e
%checkSol(Eq1,Eq2,Xvalue,Yvalue).

/* The coefficients of Eq1 (x,y and the costant) were stored in X1,Y1 and C1 respectively using the extraCoef relation.
 * Next, the coefficients and the values of x and y (Xv and Yv) are substituted into the equation (X1*Xv + Y1*Yv) and (C1)
 * and both sides are checked for equality.
 * The same process was repeated for the second equation (Eq2).
 * If and only if both equations hold with the substitued values of x and y will the relation return yes, otherwise it will
 * return no
 */
checkSol(Eq1,Eq2,Xv,Yv) :-
	extraCoef(x,Eq1,X1), extraCoef(y,Eq1,Y1), extraCoef(c,Eq1,C1),
	X1*Xv + Y1*Yv =:= C1,
	extraCoef(x,Eq2,X2), extraCoef(y,Eq2,Y2), extraCoef(c,Eq2,C2),
	X2*Xv + Y2*Yv =:= C2.

%checkSol(eq(2,1,4),eq(1,-1,-1),1,2). => yes
