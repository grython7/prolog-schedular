ta_slot_assignment([ta(X,Y)|T],[ta(X,Y1)|T],X):-
Y1 is Y-1.
ta_slot_assignment([ta(X,Y)|T],[ta(X,Y)|T1],W):-
W\=X,
ta_slot_assignment(T,T1,W).

slot_assignment(LabsNum, TAs, RemTAs, Assignment):-
	slot_assignment_helper1(LabsNum, TAs, Assignment),
	slot_assignment_helper2(TAs, Assignment, RemTAs).

slot_assignment_helper1(0,_,[]):- !.
%Take
slot_assignment_helper1(LabsNum, [ta(Name, Load)|T],[Name|Rest]):-
	LabsNum > 0,
	LabsNum1 is LabsNum -1,
	Load>0,
	slot_assignment_helper1(LabsNum1, T, Rest).
%Leave
slot_assignment_helper1(LabsNum, [_|T],Assignment):-
	slot_assignment_helper1(LabsNum, T, Assignment).

slot_assignment_helper2(TAs, [], TAs).
slot_assignment_helper2(TAs, [Name|T], RemTAs):-
	ta_slot_assignment(TAs, RemTAs1, Name),
	slot_assignment_helper2(RemTAs1, T, RemTAs).

max_slots_per_day(L,Max):-
append(L,L1),
max_slots_per_day_helper(L1,Max).

max_slots_per_day_helper([],_).
max_slots_per_day_helper([H|T],Max):-
occ(H,[H|T],X),
X=<Max,
my_delete(H,[H|T],New),
max_slots_per_day_helper(New,Max).

occ(_,[],0).
occ(X,[X|T],R):-
	occ(X,T,R1),
	R is 1+R1.
occ(X,[H|T],R):-
	X\=H,
	occ(X,T,R).

my_delete(_, [], []).
my_delete(X, [X|T], T1):-
	my_delete(X, T, T1).
my_delete(X, [H|T], [H|T1]):-
	X\=H,
	my_delete(X, T, T1).

day_schedule([],RemTAs,RemTAs,[]).
day_schedule([H|T],TAs,RemTAs,Assignment):-
	slot_assignment(H,TAs,Rem1,Ass1),
	day_schedule(T,Rem1,RemTAs,X),
	Assignment=[Ass1|X].

week_schedule([],_,_,[]).
week_schedule([H|T],TAs,DayMax,WeekSched):-
day_schedule(H,TAs,RemTAs,Assignment),
max_slots_per_day(Assignment,DayMax),
week_schedule(T,RemTAs,DayMax,X),
WeekSched=[Assignment|X].
