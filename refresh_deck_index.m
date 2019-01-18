function [deck] = refresh_deck_index(cards_used,old_deck)
%This function resets the indexing of a deck after any number of cards have
%been drawn from it

for i = 1:numel(old_deck)-cards_used
   deck(i) = old_deck(i+cards_used);    
end

end

