function [cities] = list_fully_infected(infections)

dims = size(infections);
count = 0;
for i=1:dims(1)
    if string(infections(i,2)) == string("3")
        count = count+1;
        cities(count) = infections(i);
    end
end
cities = string(cities);

end

