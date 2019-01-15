
clear; clc; tic;

num_games = 5;
roles = assign_roles(2);
player_deck = get_PlayerCards;
infect_deck = get_InfectDeck;

infect_rates = [2 2 2 3 3 4 4];
global outbreaks = 0;

(hands, player_deck, infect_deck, infect_discard, map) = start_board(roles,player_deck,infect_deck);


% map should record the number of infection counters in each city, locations of research centers, and locations of each pawn

play = 1;
wins = 0; losses = 0;

for games = 1:num_games

while play == 1
	player = ; %pick a player
	actions = select_actions(hands(player),map,roles);
	(cures, map) = perform_actions(actions);
	hands(player) = draw_PlayerCards;
	if hands(player) %contains epidemic card
		(hands(player), infect_deck, player_discard, map) = EPIDEMIC(hands(player), infect_deck, infect_discard, map);
	end
	if hands(player) %contains more than 7 cards
		hands(player) = Discard_hand(hands(player), map);
	end
	(map, infect_deck, infect_discard) = Infect_cities(infect_deck, infect_rate, map);
	
	
	if outbreaks == 8 %and other conditions
		losses = losses + 1;
		play = 0;
	elseif numel(cures) == 4
		wins = wins + 1;
		play = 0;
	end

end 
end

toc


