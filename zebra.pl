%
% 
% x = {house_color,nationality,drink,smoke,pet}
%   That is, for all X, X has a house_color,ationality, drink, smoke and pet
% D = { {yellow, blue, red, ivory, green},
%       {Norwegian, Ukrainian, English, Spaniard, Japanese},
%       {Water, Tea, Milk, OJ, Coffee},
%       {Kools, Chesterfields, Oldgold, Luckystrike, Parliament},
%       {Fox, Horse, Snails, Dog, Zebra} }
%


% _ are variables, as in the mathematical sense not the programming sense 
% knowing that we can make a predicate that the english man's house is red, and
% has three unknown variables:
% This is Rule 2:
%2.The Englishman lives in the red house.

englishhouse(H) :-
    member(house(red,
                  english,
                  _, %Don't know the drink
                  _, %don't knowpythontheir smokes
                  _ %don't know pythonheir pet
                  ), H).

%Rule 3:
%3.The Spaniard owns the dog.
spaniardshouse(H) :-
    member(house(_, %don't know pythonhe color
                 spanish,
                 _, %dont know tpythone drink
                 _, %don't know pythonhat they smoke
                 dog
                 ), H).

%4.Coffee is drunk in the green house.
coffeedrinkers(H) :-
        member(house(green, 
                     _, %don't know the nationality
                     coffee, %dont know the drink
                     _, %don't know what they smoke
                     _ % don't know the pet
                    ), H).

%5.The Ukrainian drinks tea.
ukrainianteadrinker(H) :-
    member(house(_, 
                 ukrainian,
                 tea,
                 _, %don't know what they smoke
                 _ % don't know the pet
                ), H).

%7.The Old Gold smoker owns snails.
oldgoldsnails(H) :-
    member(house(_, 
                 _,
                 _,
                 oldgold,
                 snail
                ), H).
%8.Kools are smoked in the yellow house.
koolyellow(H) :-
    member(house(yellow, 
                 _,
                 _,
                 kool,
                 _
                ), H).

%13.The Lucky Strike smoker drinks orange juice.
luckyoj(H) :-
    member(house(_, 
            _,
            oj,
            luckystrike,
            _
           ), H).
%14.The Japanese smokes Parliaments.
japaneseparliament(H) :-
    member(house(_, 
            japanese,
            _,
            parliament,
            _
           ), H).

% While some predicates are easy to make, 'the person who owns snails smokes cools'
% some are much more difficult
%6.The green house is immediately to the right of the ivory house.(yourright)

%9.Milk is drunk in the middle house.
% We have the list of house objects pased in as H,
% can we just, then, simply add a house predicate into the 'middle' house?
milk(H) :-
    H = [_,_,house(_,_,milk,_,_),_,_].


%10.The Norwegian lives in the first house.
%It seems it just is that easy, as we saw from the milk predicate function
%We can then, with the Norwegian, just take the head:
norwegian(H) :-
    H = [house(_,norwegian,_,_,_)|_].

%Interesting to note that 
% [house(_,norwegian,_,_,_),_,_,_,_] is sematically the same [house(_,norwegian,_,_,_)|_]
% First, in this case, can be thought of as 'to the left of second'
% Does that mean, then, we can literally order things?
% that is (back to rule 6) the green house is immediately to the right of the ivory house
% would roughly translate to [White,Green|_]

%Rule 6, maybe
/*
whitehouselefttogreencheck(H) :-
    H = [house(white,_,_,_,_),house(green,_,_,_,_)|_].

As it turns out: No.
The order, though, is basically true, but only works in the case of the leftmost, or rightmost...
we would need to create a list of [L,R] or [R,L] and append it to H...
Or just go through the permutations, as added to totheright and totheleft
*/



%which yielded this:
/*
?- neighborhood(N).
N = [house(white, norwegian, oj, luckystrike, _6716), house(green, spanish, coffee, _6678, dog), 
house(red, english, milk, oldgold, snail),
 house(yellow, ukrainian, tea, kool, _6704), 
 house(_6756, japanese, _6760, parliament, _6764)] 

 and that /looks. right to me, as compared to other versions.
*/

/*
"Next to", like rules 11, 12, 15, is like 'immediately to the right of' *or* 'immediately to the left of'
We know from rule 6 how to do the 'immediately to the left', immediately to the right is just reverse of that
*/

%H2 is to the right of H1%
totheright(H1,H2,Houses) :-
    Houses = [ H1,H2,_,_, _ ]; [ _, H1,H2,_, _ ] ; [ _,_,H1,H2,_, _ ] ; [ _,_,_,H1,H2 ].

%H2 is to the left of H1%
totheleft(H1,H2,Houses) :-
    Houses = [ H2,H1,_,_, _ ]; [ _,H2,H1,_,_, _ ] ; [ _,_,H2,H1,_, _] ; [ _,_,_,H2,H1].

%Next to = to the left || to the right %
nextto(H1,H2,Houses) :-
    totheright(H1,H2,Houses);
    totheleft(H1,H2,Houses).

%11.The man who smokes Chesterfields lives in the house next to the man with the fox.
chesterfieldsnexttofox(N) :-
    nextto(h(_,_,_,chesterfield,_),
           h(_,_,_,_,fox),
           N).
%12.Kools are smoked in the house next to the house where the horse is kept.
koolsnexttohorse(N) :-
    nextto(h(_,_,_,kool,_),
            h(_,_,_,_,horse),
            N).
%15.The Norwegian lives next to the blue house
norwaynexttoblue(N):-
    nextto(h(_,norway,_,_,_),
            h(blue,_,_,_,_),
            N).

%We also need to ultimately ask 
%who owns the Zebra
%using the member function
who_owns_the_zebra(Person) :- 
    neighborhood(N),
    member(house(_,Person,_,_,zebra), N).

who_owns_the_snail(Person) :- 
    /* what is a singleton variable warning?
        Warning: /home/christopher/Desktop/Project2/zebra.pl:114:
        Singleton variables: [N]
        It's not bound? https://www.swi-prolog.org/FAQ/SingletonVar.html
        if I run [zebra]. neighborhood(N). who_owns_the_snail(N). I just get true?
        N looks to be out of scope, pass it in as a variable?
                ?- [zebra].
            Warning: /home/christopher/Desktop/Project2/zebra.pl:114:
                    Singleton variables: [N]
            true.

            ?- length(N,5).
            N = [_6616, _6622, _6628, _6634, _6640].

            ?- neighborhood(N).

            Could not reenable global-stack
            Could not reenable global-stack
            Could not reenable global-stack
            Could not reenable global-stack

    */
    neighborhood(N), %Does this work?
    /* Yes
    ?- [zebra].
    Warning: /home/christopher/Desktop/Project2/zebra.pl:114:
            Singleton variables: [N]
    true.

    ?- who_owns_the_snail(Person).
    Person = norwegian 

    The same thing should then work for the zebra and water;
    just have to implement the other rules.
    */
    member(house(_,Person,_,_,snail), N).

%who drinks the water
who_drinks_water(Person) :- 
    neighborhood(N),
    member(house(_,Person,water,_,_), N).

neighborhood(N) :-
    %rule 1
    length(N,5),
    %rule 2
    englishhouse(N),
    %rule 3
    spaniardshouse(N),
    %rule 4
    coffeedrinkers(N),
    %rule 5
    ukrainianteadrinker(N),
    %rule 6,
    totheleft( house(white,_,_,_,_) , house(green,_,_,_,_) ,N),
    %rule 7
    oldgoldsnails(N),
    %rule 8
    koolyellow(N),
    %rule 9,
    milk(N),
    %rule 10,
    norwegian(N), %I expect the english man's house to no longer be first...
    %rule 11,
    %chesterfieldsnexttofox(N),
    %rule 12,
    %koolsnexttohorse(N),
    %rule 13
    luckyoj(N),
    %rule 14
    japaneseparliament(N).
    %rule 15
    %norwaynexttoblue(N).


%All the simple rules...:
/*
christopher@christopher-NV57H:~/Desktop/Project2$ swipl
Welcome to SWI-Prolog (threaded, 64 bits, version 8.0.3)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit http://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- [zebra].
true.

?- neighborhood(N).
N = [house(red, english, _6676, oldgold, snail), house(green, spanish, coffee, _6710, dog), house(yellow, ukrainian, tea, kool, _6768), house(_6832, _6838, oj, luckystrike, _6852), house(_6860, japanese, _6872, ..., ...)] 
*/

/*
Adding in the milk drinker:
christopher@christopher-NV57H:~/Desktop/Project2$ swipl
Welcome to SWI-Prolog (threaded, 64 bits, version 8.0.3)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit http://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- [zebra].
true.

?- neighborhood(N).
N = [house(red, english, _6664, oldgold, snail), house(green, spanish, coffee, _6678, dog), house(_6732, japanese, milk, parliament, _6740), house(yellow, ukrainian, tea, kool, _6704), house(_6744, _6746, oj, luckystrike, _6752)] 
*/

/*
Adding the norwegian...
christopher@christopher-NV57H:~/Desktop/Project2$ swipl
Welcome to SWI-Prolog (threaded, 64 bits, version 8.0.3)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit http://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- [zebra].
true.

?- neighborhood(N)
|    .
N = [house(green, norwegian, coffee, oldgold, snail), house(red, english, oj, luckystrike, _6668), house(yellow, spanish, milk, kool, dog), house(_6696, ukrainian, tea, _6702, _6704), house(_6744, japanese, _6748, parliament, _6752)] 
*/