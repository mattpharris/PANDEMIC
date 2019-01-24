
clear; clc; tic;

num_games = 5;

global outbreaks = 0;
wins = 0; losses = 0;

for games = 1:num_games
    play_game = 1; 
    cures = cellstr(["Disease" "Cured?"; "Red" "No"; "Blue" "No"; "Yellow" "No"; "Black" "No"]);
    infect_rates = [2 2 2 3 3 4 4];
    
    roles = assign_roles(2);
    player_deck = get_PlayerCards;
    infect_deck = get_PlayerCards;
    [hands, pawn_locs, res_ctrs, infections, player_deck, infect_deck, infect_discard] = start_board(roles,player_deck,infect_deck);
    game_turn = 1;
    
while play_game == 1
	pawn = mod(game_turn, numel(roles)) +1; %pick a player
	actions = select_actions(pawn,hands,pawn_locs,infections,res_ctrs,cures);
    
	[cures, pawn_locs, infections] = perform_actions(actions);
    
	hands(pawn,1:9) = draw_PlayerCards(hands(pawn,:);
	if any(strcmp(string(hands(pawn,:)),"EPIDEMIC")) %contains epidemic card
		[hands(pawn), infect_deck, player_discard] = EPIDEMIC(hands(player), infect_deck, infect_discard);
	end
	if strcmp(string(hands(pawn,8)),"NULL")==false %contains more than 7 cards
		hands(pawn,1:9) = Discard_hand(hands(pawn), cures);
	end
	[infect_deck, infect_discard] = Infect_cities(infect_deck, infect_rate);
	
	
	if outbreaks == 8 %and other conditions
		losses = losses + 1;
		play_game = 0;
	elseif numel(cures) == 4
		wins = wins + 1;
		play_game = 0;
    end

    
    
    game_turn = game_turn + 1;
end 
end

toc


