% -----------------------
% Webeye -- Jos De Roo
% -----------------------
%
% Webeye performs forward chaining for rules like PREM => CONC and
% backward chaining for rules like CONC <= PREM.
%
% Queries are posed and answered as PREM => true so the answers are also
% queries be it with some parts substituted and eventually containing more
% variables than in the original query.
%

:- use_module(library(iso_ext)).
:- use_module(library(terms)).

:- op(1150,xfx,=>).

:- dynamic((=>)/2).
:- dynamic(goal/0).
:- dynamic(label/1).
:- dynamic(limited_answer/1).
:- dynamic(linear_select/0).

% run abstract machine
run :-
    (Prem => Conc),
    Prem,
    (   Conc = true
    ->  \+goal,
        labelvars(Prem),
        writeq(Prem),
        write(' => true.'),
        nl,
        (   limited_answer(1)
        ;   true
        ->  retract(limited_answer(N)),
            M is N-1,
            assertz(limited_answer(M)),
            fail
        )
    ;   \+Conc,
        labelvars(Conc),
        astep(Conc),
        retract(goal),
        fail
    ).
run :-
    (   (   goal
        ;   linear_select
        )
    ->  true
    ;   assertz(goal),
        run
    ).

% create witnesses
labelvars(Term) :-
    (   retract(label(Current))
    ->  true
    ;   Current = 0
    ),
    numbervars(Term,Current,Next),
    assertz(label(Next)).

% assert new step
astep((A,B)) :-
    astep(A),
    astep(B).
astep(false) :-
    throw('inference_fuse').
astep(A) :-
    (   \+A
    ->  assertz(A)
    ;   true
    ).