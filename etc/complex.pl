% See https://en.wikipedia.org/wiki/Complex_number

:- op(1150,xfx,=>).

'https://github.com/IDLabResearch/Heiseneye#exp'([[A,B],[C,D]],[E,F]) :-
    polar([A,B],[G,H]),
    E is G^C*exp(-D*H)*cos(D*log(G)+C*H),
    F is G^C*exp(-D*H)*sin(D*log(G)+C*H).

'https://github.com/IDLabResearch/Heiseneye#log'([[A,B],[C,D]],[E,F]) :-
    polar([A,B],[G,H]),
    polar([C,D],[I,J]),
    K is log(G),
    L is log(I),
    divide([[L,J],[K,H]],[E,F]).

'https://github.com/IDLabResearch/Heiseneye#sin'([A,B],[C,D]) :-
    C is sin(A)*(exp(B)+exp(-B))/2,
    D is cos(A)*(exp(B)-exp(-B))/2.

'https://github.com/IDLabResearch/Heiseneye#cos'([A,B],[C,D]) :-
    C is cos(A)*(exp(B)+exp(-B))/2,
    D is -sin(A)*(exp(B)-exp(-B))/2.

'https://github.com/IDLabResearch/Heiseneye#tan'(A,B) :-
    'https://github.com/IDLabResearch/Heiseneye#sin'(A,C),
    'https://github.com/IDLabResearch/Heiseneye#cos'(A,D),
    divide([C,D],B).

'https://github.com/IDLabResearch/Heiseneye#asin'([A,B],[C,D]) :-
    E is (sqrt((1+A)^2+B^2)-sqrt((1-A)^2+B^2))/2,
    F is (sqrt((1+A)^2+B^2)+sqrt((1-A)^2+B^2))/2,
    C is asin(E),
    D is log(F+sqrt(F^2-1)).

'https://github.com/IDLabResearch/Heiseneye#acos'([A,B],[C,D]) :-
    E is (sqrt((1+A)^2+B^2)-sqrt((1-A)^2+B^2))/2,
    F is (sqrt((1+A)^2+B^2)+sqrt((1-A)^2+B^2))/2,
    C is acos(E),
    D is -log(F+sqrt(F^2-1)).

'https://github.com/IDLabResearch/Heiseneye#atan'(A,B) :-
    subtract([[0,1],A],C),
    add([[0,1],A],D),
    divide([C,D],E),
    'https://github.com/IDLabResearch/Heiseneye#log'([[e,0],E],F),
    divide([F,[0,2]],B).

polar([A,B],[C,D]) :-
    C is sqrt(A^2+B^2),
    E is acos(abs(A)/C),
    angular(A,B,E,D).

angular(A,B,C,D) :-
    A >= 0,
    B >= 0,
    D = C.
angular(A,B,C,D) :-
    A < 0,
    B >= 0,
    D is pi-C.
angular(A,B,C,D) :-
    A < 0,
    B < 0,
    D is C+pi.
angular(A,B,C,D) :-
    A >= 0,
    B < 0,
    D is 2*pi-C.

minus([A,B],[C,D]) :-
    C is -A,
    D is -B.

subtract([[A,B],[C,D]],[E,F]) :-
    E is A-C,
    F is B-D.

add([[A,B],[C,D]],[E,F]) :-
    E is A+C,
    F is B+D.

multiply([[A,B],[C,D]],[E,F]) :-
    E is A*C-B*D,
    F is A*D+B*C.

inverse([A,B],[C,D]) :-
    C is A/(A^2+B^2),
    D is -B/(A^2+B^2).

divide([A,B],C) :-
    inverse(B,D),
    multiply([A,D],C).

% query
'https://github.com/IDLabResearch/Heiseneye#exp'([[-1,0],[0.5,0]],_ANSWER) => yes.
'https://github.com/IDLabResearch/Heiseneye#exp'([[e,0],[0,pi]],_ANSWER) => yes.
'https://github.com/IDLabResearch/Heiseneye#log'([[e,0],[-1,0]],_ANSWER) => yes.
'https://github.com/IDLabResearch/Heiseneye#log'([[0,1],[0,1]],_ANSWER) => yes.
'https://github.com/IDLabResearch/Heiseneye#sin'([1.570796326794897,1.316957896924817],_ANSWER) => yes.
'https://github.com/IDLabResearch/Heiseneye#cos'([0,-1.316957896924817],_ANSWER) => yes.
'https://github.com/IDLabResearch/Heiseneye#tan'([1.338972522294493,0.4023594781085251],_ANSWER) => yes.
'https://github.com/IDLabResearch/Heiseneye#asin'([2,0],_ANSWER) => yes.
'https://github.com/IDLabResearch/Heiseneye#acos'([2,0],_ANSWER) => yes.
'https://github.com/IDLabResearch/Heiseneye#atan'([1,2],_ANSWER) => yes.
