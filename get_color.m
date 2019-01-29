function [outputColor] = get_color(city)

all_blues = ["Atlanta"; "Chicago"; "New York"; "Montreal"; "Washington DC"; "San Francisco"; ...
    "London"; "Paris"; "Madrid"; "Essen"; "Milan"; "St Petersburg"];

all_yellows = ["Los Angeles"; "Mexico City"; "Miami"; "Bogota"; "Lima"; "Santiago"; ...
    "Buenos Aires"; "Sao Paulo"; "Lagos"; "Kinshasa"; "Johannesburg"; "Khartoum"];

all_blacks = ["Algiers"; "Cairo"; "Istanbul"; "Baghdad"; "Riyadh"; "Moscow"; ...
    "Tehran"; "Karachi"; "Delhi"; "Mumbai"; "Chennai"; "Kolkata"];

all_reds = ["Beijing"; "Shanghai"; "Hong Kong"; "Bangkok"; "Jakarta"; ...
    "Ho Chi Minh City"; "Seoul"; "Tokyo"; "Osaka"; "Taipei"; "Manila"; "Sydney"];

city = string(city);
found = 0;
while found == 0
    for i=1:numel(all_blues)
        if strcmp(all_blues(i),city)
            outputColor = ("blue");
            found = 1;
        end
    end
    for i=1:numel(all_yellows)
        if strcmp(all_yellows(i),city)
            outputColor = ("yellow");
            found = 1;
        end
    end
    for i=1:numel(all_blacks)
        if strcmp(all_blacks(i),city)
            outputColor = ("black");
            found = 1;
        end
    end
    for i=1:numel(all_reds)
        if strcmp(all_reds(i),city)
            outputColor = ("red");
            found = 1;
        end
    end
end

end

