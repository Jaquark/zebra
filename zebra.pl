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

% Adjacency would work, using append/3 -
% https://stackoverflow.com/questions/35667142/prolog-finding-adjacent-elements-in-a-list

%Rule 6
totheleft(H1,H2,Houses) :-
    append(_, [H1,H2|_], Houses).

totheright(H1,H2,Houses) :-
    append( _, [H2,H1|_], Houses).

/*
"Next to", like rules 11, 12, 15, is like 'immediately to the right of' *or* 'immediately to the left of'
We know from rule 6 how to do the 'immediately to the left', immediately to the right is just reverse of that
*/


%Next to = to the left || to the right %
%this should be usable for rules 11, 12 and 15
nextto(H1,H2,Houses) :-
    totheleft(H1,H2,Houses) ; totheright( H1,H2,Houses ).

%We also need to ultimately ask 
%who owns the Zebra
%using the member function
who_owns_the_zebra(Person) :- 
    neighborhood(N),
    member(house(_,Person,_,_,zebra), N).

%who drinks the water
who_drinks_water(Person) :- 
    neighborhood(N),
    member(house(_,Person,water,_,_), N).

neighborhood(N) :-
    
    %rule 1
    length(N,5),                                                %write('Rule number 1\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 2
    englishhouse(N),                                            %write('Rule number 3\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 3
    spaniardshouse(N),                                          %write('Rule number 3\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 4
    coffeedrinkers(N),                                          %write('Rule number 4\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 5 
    ukrainianteadrinker(N),                                     %write('Rule number 5\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 6,
    totheleft(house(white,_,_,_,_),house(green,_,_,_,_),N),    %write('Rule number 6\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 7
    oldgoldsnails(N),                                           %write('Rule number 7\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 8
    koolyellow(N),                                              %write('Rule number 8\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 9,
    milk(N),                                                    %write('Rule number 9\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 10,
    norwegian(N),                                               %write('Rule number 10\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 11,
    nextto(house(_,_,_,chesterfield,_),house(_,_,_,_,fox),N),   %write('Rule number 11\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 12,
    nextto(house(_,_,_,kool,_),house(_,_,_,_,horse),N),         %write('Rule number 12\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 13
    luckyoj(N),                                                 %write('Rule number 13\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 14
    japaneseparliament(N),                                      %write('Rule number 14\n'),     write(N), write('\n\n\n\n\n\n'),
    %rule 15
    nextto(house(_,norwegian,_,_,_),house(blue,_,_,_,_),N).
    %norwaynexttoblue(N).


/*
?- neighborhood(N).
N = [house(yellow, norwegian, _6778, kool, fox), house(blue, ukrainian, tea, chesterfield, horse), house(red, english, milk, oldgold, snail), house(white, spanish, oj, luckystrike, dog), house(green, japanese, coffee, parliament, _6692)] .

?- who_owns_the_zebra(N).
N = japanese .

?- who_drinks_water(Person).
Person = norwegian .
*/