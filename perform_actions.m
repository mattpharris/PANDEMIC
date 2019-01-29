function [cures, res_ctrs, hands, pawn_locs, infections] = perform_actions(pawn,hands,pawn_locs,cures,res_ctrs,infections,actions)

for i = 1:4
    move_type = str2double(extractBefore(string(actions(i)),"_"));
    if move_type <= 3     %Travel
        pawn_locs(pawn) = cellstr(extractAfter(string(actions(i)),"__"));
        if move_type == 2
            origin = extractAfter(extractBefore(string(actions(i)),"__"),"_");
            for x = 1:9
                if strcmp(hands(pawn,x),origin)
                    hands(pawn,x) = cellstr("NULL");
                    temp = hands(pawn,:);
                end
            end
        elseif move_type == 3
            destination = extractAfter(string(actions(i)),"__");
            for x = 1:9
                if strcmp(hands(pawn,x),destination)
                    hands(pawn,x) = cellstr("NULL");
                    temp = hands(pawn,:);
                end
            end
        end
        if exist(temp) > 0 %Re-sort pawn's hand
            for x = 1:9
                if strcmp(string(temp(x)),"NULL")
                    for y = x:8
                        temp(y) = temp(y+1);
                    end
                    temp(9) = cellstr("NULL");
                end
            end
            hands(pawn,:) = temp;
        end
    
    elseif move_type == 5 %Build research center
        res_ctrs = [res_ctrs; cellstr(extractAfter(string(actions(i)),"__"))];
    
    elseif move_type == 6 %Heal
        dims = size(infections);
        for j = 1:dims(1)
            if strcmp(string(infections(j,1)),extractAfter(string(actions(i)),"__"))
                counter = str2double(infections(j,2));
                counter = counter - 1;
                if counter == 0 %Remove entry from infections list
                    temp = infections;
                    for k = 1:dims(1)-1
                        if k < j 
                            temp(k,:) = infections(k,:);
                        elseif k >= j
                            temp(k,:) = infections(k+1,:);
                        end
                    end
                    clear infections
                    infections = temp;
                else            %Reduce infection counters
                    new_counter = cellstr(int2str(counter));
                    infections(j,2) = new_counter;                    
                end
            end
        end
        
    elseif move_type == 7 %Cure
        color = extractAfter(string(actions(i)),"_");
        for x = 1:numel(hands(pawn,:))
            card_color = get_color(hands(pawn,x));
            if strcmp(color,card_color)
                hands(pawn,x) = cellstr("NULL");
            end
        end
        temp = hands(pawn,:);
        for x = 1:9
            if strcmp(string(temp(x)),"NULL")
                for y = x:8
                    temp(y) = temp(y+1);
                end
                temp(9) = cellstr("NULL");
            end
        end
        hands(pawn,:) = temp;   
    end

end

