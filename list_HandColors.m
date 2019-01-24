function [reds,blues,yellows,blacks] = list_HandColors(cards)

%"cards" is a 1xn cell array enumerating a player's hand

all_blues = ["Atlanta"; "Chicago"; "New York"; "Montreal"; "Washington DC"; "San Francisco"; ...
    "London"; "Paris"; "Madrid"; "Essen"; "Milan"; "St Petersburg"];

all_yellows = ["Los Angeles"; "Mexico City"; "Miami"; "Bogota"; "Lima"; "Santiago"; ...
    "Buenos Aires"; "Sao Paulo"; "Lagos"; "Kinshasa"; "Johannesburg"; "Khartoum"];

all_blacks = ["Algiers"; "Cairo"; "Istanbul"; "Baghdad"; "Riyadh"; "Moscow"; ...
    "Tehran"; "Karachi"; "Delhi"; "Mumbai"; "Chennai"; "Kolkata"];

all_reds = ["Beijing"; "Shanghai"; "Hong Kong"; "Bangkok"; "Jakarta"; ...
    "Ho Chi Minh City"; "Seoul"; "Tokyo"; "Osaka"; "Taipei"; "Manila"; "Sydney"];

reds = 0; blues = 0; yellows = 0; blacks = 0;

for i = 1:numel(cards)
    for j = 1:numel(all_blues)
        if strcmp(cards(i),all_blues(j))
            blues = blues+1;
        end
    end
    for j = 1:numel(all_yellows)
        if strcmp(cards(i),all_yellows(j))
            yellows = yellows+1;
        end
    end
    for j = 1:numel(all_blacks)
        if strcmp(cards(i),all_blacks(j))
            blacks = blacks+1;
        end
    end
    for j = 1:numel(all_reds)
        if strcmp(cards(i),all_reds(j))
            reds = reds+1;
        end
    end
end



end

