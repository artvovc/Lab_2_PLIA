femeie(ana).
femeie(maria).
femeie(lilia).
femeie(valea).
femeie(tatiana).
femeie(felicia).
femeie(alina).
femeie(anghelina).
femeie(cezarina).

barbat(ilie).
barbat(sergiu).
barbat(valeriu).
barbat(nicolai).
barbat(mihail).
barbat(vergiliu).
barbat(artiom).
barbat(stanis).

parinti(ana,ilie,valeriu).
parinti(ana,ilie,tatiana).
parinti(ana,ilie,valea).
parinti(maria,sergiu,nicolai).
parinti(maria,sergiu,felicia).
parinti(lilia,valeriu,alina).
parinti(lilia,valeriu,vergiliu).
parinti(valea,mihail,anghelina).
parinti(tatiana,nicolai,stanis).
parinti(tatiana,nicolai,artiom).

mama(X,Y):- parinti(X,_,Y),femeie(X),write(X),write(" "),write(Y),nl,fail;true.
tata(X,Y):- parinti(_,X,Y),barbat(X).
frati(X,Y):- parinti(M,T,X),parinti(M,T,Y),X\=Y.
sora(X,Y):- frati(X,Y),femeie(X).
frate(X,Y):- frati(X,Y),barbat(X).

dumneaieiAreFrate(X,Y):- sora(X,Y),!,write("Pentru: "),write(X),write(" frate este: "),write(Y),nl.
dumnealuiAreSora(X,Y):- sora(X,Y),!,write("Sora: "),write(X),write(" pentru: "),write(Y),nl.

frate0(X,Y,X):- parinti(M,T,X),parinti(M,T,Y),X\=Y,!.
frate0(_,Y,Y).

verisori(X,Y):- parinti(M1,T1,X),parinti(M2,T2,Y),
	(
	  frati(M1,M2);
	  frati(M1,T2);
          frati(T1,M2);
          frati(T1,T2)
	),X\=Y,not(frati(X,Y)),write(X),write(" "),write(Y),nl,fail;true.

bunici(X,Y,N):- parinti(X,Y,Z),(parinti(Z,_,N);parinti(_,Z,N)).
bunica(X,N):- bunici(X,_,N).
bunel(X,N):-bunici(_,X,N).
nepot(X):-parinti(M,T,X),(parinti(_,_,M);parinti(_,_,T)).
casatoriti(X,Y):- parinti(X,Y,_).
unchi(X,Y):-parinti(M,T,Y),
		((frate(X,M);frate(X,T));
		( parinti(M1,T1,M),parinti(M1,T1,C1),
		casatoriti(C1,X),not(parinti(_,X,Y)));
		( parinti(M2,T2,T),parinti(M2,T2,C2),
		casatoriti(C2,X),not(parinti(_,X,Y)))
		).
matusa(X,Y):-parinti(M,T,Y),
		((sora(X,M);sora(X,T));
		( parinti(M1,T1,M),parinti(M1,T1,C1),
		casatoriti(X,C1),not(parinti(X,_,Y)));
		( parinti(M2,T2,T),parinti(M2,T2,C2),
		casatoriti(X,C2),not(parinti(X,_,Y)))
		).

p(1).
p(2):-!.
p(3).

copil(peter,9). copil(paul,10). copil(chris,9). copil(susan,9).
joaca():- copil(X,M),copil(Y,M),X\=Y,write(X),write(" "),write(Y),nl,fail;true.

min0(X,Y,Y):-X>=Y.
min0(X,Y,X):-X<Y.

min1(X,Y,Y):-X>=Y,!.
min1(X,Y,X):-X<Y.

min2(X,Y,Y):-X>=Y,!.
min2(X,_,X).

inc(X,Y):- Y is X+1.

getElementById([Head|Tail],ValueIndex,IncFrom,Result):- inc(IncFrom,LocalI), LocalI=\=ValueIndex->getElementById(Tail,ValueIndex,LocalI,Result);(Result=Head,!).

length_1(0,[]).
length_1(L+1, [_|T]) :- length_1(L,T).

ciclu([H|T],ArrSize,StartInc):-
	inc(StartInc,LocalI),
	getElementById([H|T],LocalI,0,Result),
	LocalI=<ArrSize->
	((Pair is mod(Result,2),Pair==0->(write(Result),
         (LocalI<ArrSize->write(",");write("")))
	 ;write("")),ciclu([H|T],ArrSize,LocalI));!.

result([H|T]):-write("["),length_1(X,[H|T]),ArrSize is X,ciclu([H|T],ArrSize,0),write("]").

















































