function [hands, pawn_locs, res_ctrs, infections, player_deck, infect_deck, infect_discard] = start_board(roles, player_deck, infect_deck)

%Distribute starting hands to each player
for i = 1:numel(roles)
    for card = 1:3
        hands(i,card) = player_deck(card);
    end
    player_deck = refresh_deck_index(card,player_deck);
end

%Insert epidemic cards into player deck
position = 1;
for card = 1:4
    position = randi([position+8-card position+round(numel(player_deck)/4)],1);
    for i = 1:numel(player_deck)
        if i < position
            new_deck(i) = player_deck(i);
        elseif i == position
            new_deck(i) = player_deck(i);
            new_deck(i+1) = cellstr("Epidemic");
        elseif i > position
            new_deck(i+1) = player_deck(i);
        end
    end
    player_deck = new_deck;
end
    
%Draw initial infections
infect_discard = infect_deck(1:9);

%Infect cities
infections = [cellstr("city") cellstr("counter")];
for i = 1:9
    if i <= 3
        infections = [infections; [infect_discard(i) cellstr("3")]];
    elseif (i > 3) && (i<7)
        infections = [infections; [infect_discard(i) cellstr("2")]];
    elseif i >= 7
        infections = [infections; [infect_discard(i) cellstr("1")]];
    end
end

%Update infection deck
infect_deck = refresh_deck_index(9,infect_deck);

%Assign research center locations and pawn locations
res_ctrs = [cellstr("Atlanta")];
for i = 1:numel(roles)
    pawn_locs(i) = [cellstr("Atlanta")];
end
end

