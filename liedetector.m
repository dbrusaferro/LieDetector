clear all, clc
global debug
debug = false;

% List the available cards, in setup:
Deck = ["KC", "KH", "KS", "KD", "QC", "QH", "QS", "QD"];

% User prompt
fprintf("Choose a card from: %s %s %s %s %s %s %s %s\n\n", Deck)

% Split the deck with a bottom deal
[Stack, Pile] = bottomDeal(Deck);
if(debug)
    fprintf('Stack: %s %s %s %s\n', Stack);
    fprintf('Pile:  %s %s %s %s\n', Pile);
end

% Reveal pile, prompt for containment
fprintf('Is your card one of: %s %s %s %s ?\n', Pile )
response = input("(Y/N) ", "s")

switch(response)
    % If Yes, put pile on top
    case {"y", "Y"}
        Deck = combine(Pile, Stack);
    % If No, put pile on bottom
    case {"n", "N"}
        Deck = combine(Stack, Pile);
    % Error checking
    otherwise
        error('Please enter Y or N.');
end

% Split the second time
[Stack, Pile] = bottomDeal(Deck);

% Reveal the second pile and prompt for containment
fprintf('Is your card one of: %s %s %s %s ?\n', Pile);
response = input("(Y/N) ", "s");

switch(response)
    % If Yes, put pile on bottom
    case {"n", "N"}
        Deck = combine(Pile, Stack);
    % If No, put pile on top
    case {"y", "Y"}
        Deck = combine(Stack, Pile);
    % Error checking
    otherwise
        error('Please enter Y or N.');
end

% Split the third time
[Stack, Pile] = bottomDeal(Deck);

% Reveal the third pile and prompt for containment
fprintf('Is your card one of: %s %s %s %s ?\n', Pile);
response = input("(Y/N) ", "s");

switch(response)
    % If Yes, put pile on top
    case {"y", "Y"}
        Deck = combine(Pile, Stack);
    % If No, put pile on bottom
    case {"n", "N"}
        Deck = combine(Stack, Pile);
    % Error checking
    otherwise
        error('Please enter Y or N.');
end

% Split into detector 1
[Pile, Detector1] = topDeal(Deck);

% Split into detector 2
[Pile, Detector2] = topDeal(Pile);

% Split into detector 3
[Ans, Detector3] = topDeal(Pile);

% Long readout
fprintf('Your card is %s.\n', Ans);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function for dealing from the bottom of the deck
function [P,S] = bottomDeal(D)
deckSize = length(D);
pileSize = deckSize / 2;
for i = 0 : pileSize - 1
    P(pileSize - i) = D(2 * pileSize - 2*i);
    S(pileSize - i) = D(2 * pileSize - 2 * i - 1);
end
end

% Function for dealing from the top of the deck
function [P, S] = topDeal(D)
deckSize = length(D);
pileSize = deckSize / 2;
for i = 0 : pileSize - 1
    P(pileSize-i) = D(2*i+1);
    S(pileSize-i) = D(2*i+2);
end
end

% Function for recombining the pile and stack into the deck
function D = combine(T,B)
global debug
% D(1:4) = T;
% D(5:8) = B;
if(debug)
fprintf('Top cards: %s %s %s %s\n', T)
end
D = [T,B];
if(debug)
    fprintf('Returning deck: %s %s %s %s %s %s %s %s\n', D)
end
end