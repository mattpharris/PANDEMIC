function [actions] = select_actions(pawn,hand,pawn_locs,infections,res_ctrs,cures)

%Move Types
    % 1 - Walk
    % 2 - Charter from pawn's current city with that city's Player Card
            % to any destination
    % 3 - Charter to a city using that city's Player Card
            % from any origin city
    % 4 - Share knowledge
    % 5 - Build Research Center
    % 6 - Heal Infection
    % 7 - Cure disease


options = [];
    
%Size of pawn's hand
num_cards = 0;
while strcmp(string(hand(pawn,i+1)),"NULL")==false
    num_cards = num_cards + 1;
end
    
%Append possible moves
col = 1;
    %Consider walking moves
    destinations = list_NeighborCities(pawn_locs(pawn));
    for i=1:numel(destinations)
        options(i,col) = [cellstr(sprintf("1__%s",destinations(i)))];
    end
    clear destinations
    
    %Consider Chartering from pawn's current city
    destinations = list_fully_infected(infections); %I'm imposing a condition that a pawn will only charter if that city has three infection counters
    if any(strcmp(pawn_locs(pawn), hand(pawn,1:num_cards)))
        for j = 1:numel(destinations)
            options(i+j,col) = [cellstr(sprintf("2_%s__%s", pawn_locs(pawn),destinations(j)))];
        end
        i = i+j;
    end
    clear destinations
    
   %Consider chartering to a city using that city's Player Card
   origins = hand(pawn,1:num_cards);
   targets = list_fully_infected(infections); %I'm imposing a condition that a pawn will only charter if that city has three infection counters
   priorities = strcmp(origins,targets);
   count = 0;
   for x=1:numel(priorities)
       if x == 1
           count = count + 1;
           destinations(count) = targets(x);
       end
   end
   for k = 1:numel(destinations)
       options(i+k,col) = [cellstr(sprintf("3__%s", destinations(k)))];
   end
   i=i+k;
   clear count destinations
   
   %Consider sharing knowledge
   
   
   %Consider building research center
   if (strcmp(pawn_locs(pawn),string(res_ctrs))==false) && any(strcmp(pawn_locs(pawn), hand(pawn,1:num_cards)))
      i=i+1;
      options(i,col) = [cellstr(sprintf("5__%s", string(pawn_locs(pawn))))];       
   end
   
   %Consider healing infection
   if any(strcmp(pawn_locs(pawn),infections(:,1)))
       i=i+1;
       options(i,col) = [cellstr(sprintf("6__%s", string(pawn_locs(pawn))))];  
   end
   
   %Consider curing disease
   if (num_cards >= 5) && any(strcmp(pawn_locs(pawn),string(res_ctrs)))
       i=i+1;
       [reds, blues, yellows, blacks] = list_HandColors(hand(pawn,1:num_cards));
       if (reds==5) && strcmp(string(cures(2,2)),"No")
            options(i,col) = [cellstr(sprintf("7_red__%s", string(pawn_locs(pawn))))]; 
       elseif (blues==5) && strcmp(string(cures(3,2)),"No")
           options(i,col) = [cellstr(sprintf("7_blue__%s", string(pawn_locs(pawn))))]; 
       elseif (yellows==5) && strcmp(string(cures(4,2)),"No")
           options(i,col) = [cellstr(sprintf("7_yellow__%s", string(pawn_locs(pawn))))]; 
       elseif (blacks==5) && strcmp(string(cures(5,2)),"No")
           options(i,col) = [cellstr(sprintf("7_black__%s", string(pawn_locs(pawn))))]; 
       end
   end
       
       
    
    
   %%%%%%%%%%%%%%%%%%%%%%%%
   %Consider moves 2-4
   for col = 2:4
       temp = options; dims = size(temp);
       clear options
       for z = 1:numel(dims(1))
           current_loc = extractAfter(string(temp(z,col)),"__");
           
           %Consider walking moves
           destinations = list_NeighborCities(current_loc);
           for ii=1:numel(destinations)
               options(ii,1:col-1) = temp(z,1:col-1);
               options(ii,col) = [cellstr(sprintf("1__%s",destinations(ii)))];
           end
           clear destinations
       
           %Consider Chartering from pawn's current city
           destinations = list_fully_infected(infections); %I'm imposing a condition that a pawn will only charter if that city has three infection counters
           if any(strcmp(current_loc, hand(pawn,:)))
                for jj = 1:numel(destinations)
                    options(ii+jj,1:col-1) = temp(z,1:col-1);
                    options(ii+jj,col) = [cellstr(sprintf("2_%s__%s", pawn_locs(pawn),destinations(jj)))];
                end
                ii = ii+jj;
           end
           clear destinations
           
           %Consider chartering to a city using that city's Player Card
           origins = hand(pawn,1:num_cards);
           targets = list_fully_infected(infections); %I'm imposing a condition that a pawn will only charter if that city has three infection counters
           priorities = strcmp(origins,targets);
           count = 0;
           for x=1:numel(priorities)
               if x == 1
                   count = count + 1;
                   destinations(count) = targets(x);
               end
           end
           for kk = 1:numel(destinations)
               options(ii+kk,1:col-1) = temp(z,1:col-1);
               options(ii+kk,col) = [cellstr(sprintf("3__%s", destinations(kk)))];
           end
           ii=ii+kk;
           clear count destinations
           
           
           %Consider sharing knowledge
   
   
           %Consider building research center
           if (strcmp(current_loc,string(res_ctrs))==false) && any(strcmp(current_loc, hand(pawn,1:num_cards)))
              ii=ii+1;
              options(ii,1:col-1) = temp(z,1:col-1);
              options(ii,col) = [cellstr(sprintf("5__%s", current_loc))];       
           end

           %Consider healing infection
           if any(strcmp(pawn_locs(pawn),infections(:,1)))
               ii=ii+1;
               options(ii,1:col-1) = temp(z,1:col-1);
               options(ii,col) = [cellstr(sprintf("6__%s", current_loc))];  
           end

           %Consider curing disease
           if (num_cards >= 5) && any(strcmp(pawn_locs(pawn),string(res_ctrs)))
               ii=ii+1;
               [reds, blues, yellows, blacks] = list_HandColors(hand(pawn,1:num_cards));
               if (reds==5) && strcmp(string(cures(2,2)),"No")
                    options(ii,col) = [cellstr("7_red")]; 
               elseif (blues==5) && strcmp(string(cures(3,2)),"No")
                   options(ii,col) = cellstr(sprintf("7_blue"); 
               elseif (yellows==5) && strcmp(string(cures(4,2)),"No")
                   options(ii,col) = cellstr(sprintf("7_yellow"); 
               elseif (blacks==5) && strcmp(string(cures(5,2)),"No")
                   options(ii,col) = cellstr(sprintf("7_black"); 
               end
           end
       
   
           %%%%%
           clear temp
       end
   end
    
actions = pick_best_option(pawn_locs(pawn),options);


end

