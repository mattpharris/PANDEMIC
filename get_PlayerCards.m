function [deck] = get_PlayerCards()

list = ["Atlanta"; "Chicago"; "New York"; "Montreal"; "Washington DC"; "San Francisco"; "London"; "Paris"; "Madrid"; "Essen"; "Milan"; "St Petersburg"; ...
    "Los Angeles"; "Mexico City"; "Miami"; "Bogota"; "Lima"; "Santiago"; "Buenos Aires"; "Sao Paulo"; "Lagos"; "Kinshasa"; "Johannesburg"; "Khartoum"; ...
    "Algiers"; "Cairo"; "Istanbul"; "Baghdad"; "Riyadh"; "Moscow"; "Tehran"; "Karachi"; "Delhi"; "Mumbai"; "Chennai"; "Kolkata"; ...
    "Beijing"; "Shanghai"; "Hong Kong"; "Bangkok"; "Jakarta"; "Ho Chi Minh City"; "Seoul"; "Tokyo"; "Osaka"; "Taipei"; "Manila"; "Sydney"];

list = cellstr(list);

deck = list(randperm(numel(list)));

end

