% Diamond Property Equality
% DP(r) => DP(re), i.e. the diamond property is preserved under reflexive closure
% Original code from http://www.ii.uib.no/~bezem/GL/dpe.in

:- op(1150,xfx,=>).
:- op(1200,xfx,<=).

term_expansion((X <= Y),(X :- Y)).

:- dynamic(dom/1).
:- dynamic(e/2).
:- dynamic(r/2).
:- dynamic('https://idlabresearch.github.io/etc#re'/2).
:- dynamic(not_/1).

% facts
true => dom(a),dom(b),dom(c).
true => 'https://idlabresearch.github.io/etc#re'(a,b),'https://idlabresearch.github.io/etc#re'(a,c).

% equality axioms
dom(X) => e(X,X).

e(X,Y) => e(Y,X).
not_(e(Y,X)) => not_(e(X,Y)).

e(X,Y),'https://idlabresearch.github.io/etc#re'(Y,Z) => 'https://idlabresearch.github.io/etc#re'(X,Z).
not_('https://idlabresearch.github.io/etc#re'(X,Z)),'https://idlabresearch.github.io/etc#re'(Y,Z) => not_(e(X,Y)).
e(X,Y),not_('https://idlabresearch.github.io/etc#re'(X,Z)) => not_(e(Y,Z)).

% basic facts on re
e(X,Y) => 'https://idlabresearch.github.io/etc#re'(X,Y).
not_('https://idlabresearch.github.io/etc#re'(X,Y)) => not_(e(X,Y)).

r(X,Y) => 'https://idlabresearch.github.io/etc#re'(X,Y).
not_('https://idlabresearch.github.io/etc#re'(X,Y)) => not_(r(X,Y)).

'https://idlabresearch.github.io/etc#re'(X,Y),not_(e(X,Y)) => r(X,Y).
not_(r(X,Y)),not_(e(X,Y)) => not_('https://idlabresearch.github.io/etc#re'(X,Y)).
'https://idlabresearch.github.io/etc#re'(X,Y),not_(r(X,Y)) => e(X,Y).

% DP
r(X,Y),r(X,Z) => dom(U),r(Y,U),r(Z,U).

% query
'https://idlabresearch.github.io/etc#re'(b,X),'https://idlabresearch.github.io/etc#re'(c,X) => yes.

% assuming the negation of the query so that it can be discharged when the query succeeds
'https://idlabresearch.github.io/etc#re'(b,X) => not_('https://idlabresearch.github.io/etc#re'(c,X)).
'https://idlabresearch.github.io/etc#re'(c,X) => not_('https://idlabresearch.github.io/etc#re'(b,X)).

% a single answer is fine
limited_answer(1).
