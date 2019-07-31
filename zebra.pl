%
% 
% x = {house_color,nationality,drink,smoke,pet}
%   That is, for all X, X has a house_color,ationality, drink, smoke and pet
% D = { {yellow, blue, red, ivory, green},
%       {Norwegian, Ukrainian, English, Spaniard, Japanese},
%       {Water, Tea, Milk, OJ, Coffee},
%       {Kools, Chesterfields, Oldgold, Luckystrike, Parliament},
%       {Fox, Horse, Snails, Dog, Zeba} }
%


% _ are variables, as in the mathematical sense not the programming sense 
% knowing that we can make a predicate that the english man's house is red, and
% has three unknown variables:
% This is Rule 2:
%2.The Englishman lives in the red house.

englishhouse(H) :-
    member(house((red,
                  english,
                  _, %Don't know the drink
                  _, %don't know their smokes
                  _ %don't know their pet
                  )), H).

%Rule 3:
%3.The Spaniard owns the dog.
spaniardshouse(H) :-
    member(house((_, %don't know the color
                 spanish,
                 _, %dont know the drink
                 _, %don't know what they smoke
                 dog
                 )), H).

%4.Coffee is drunk in the green house.
coffeedrinkers(H) :-
        member(house((green, 
                     _, %don't know the nationality
                     coffee, %dont know the drink
                     _, %don't know what they smoke
                     _ % don't know the pet
                    )), H).

%5.The Ukrainian drinks tea.
ukrainianteadrinker(H) :-
    member(house((_, 
                 ukrainian,
                 tea,
                 _, %don't know what they smoke
                 _ % don't know the pet
                )), H).

%7.The Old Gold smoker owns snails.
oldgoldsnails(H) :-
    member(house((_, 
                 _,
                 _,
                 oldgold,
                 snail
                )), H).
%8.Kools are smoked in the yellow house.
koolyellow(H) :-
    member(house((yellow, 
                 _,
                 _,
                 kool,
                 _
                )), H).

%13.The Lucky Strike smoker drinks orange juice.
luckyoj(H) :-
    member(house((_, 
            _,
            oj,
            luckystrike,
            _
           )), H).
%14.The Japanese smokes Parliaments.
japaneseparliament(H) :-
    member(house((_, 
            japanese,
            _,
            parliament,
            _
           )), H).

% While some predicates are easy to make, 'the person who owns snails smokes cools'
% some are much more difficult
%6.The green house is immediately to the right of the ivory house.(yourright)
%9.Milk is drunk in the middle house.
%10.The Norwegian lives in the first house.
%11.The man who smokes Chesterfields lives in the house next to the man with the fox.
%12.Kools are smoked in the house next to the house where the horse is kept.
%15.The Norwegian lives next to the blue house


neighborhood(N) :-
    %rule 1
    %there are 5 houses,
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
    %rule 7
    oldgoldsnails(N),
    %rule 8
    koolyellow(N),
    %rule 9,
    %rule 10,
    %rule 11,
    %rule 12,
    %rule 13
    luckyoj(N),
    %rule 14
    japaneseparliament(N).
    %rule 15


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
N = [house((red, english, _6676, oldgold, snail)), house((green, spanish, coffee, _6710, dog)), house((yellow, ukrainian, tea, kool, _6768)), house((_6832, _6838, oj, luckystrike, _6852)), house((_6860, japanese, _6872, ..., ...))] 
*/