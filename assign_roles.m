
function [roles] = assign_roles(number)

role_list = ["Scientist"; "QuarantineSpec"; "Researcher"; "Dispatcher"; "Medic"; "Ops"; "Contingency"];

types = randi([1 numel(role_list)],1,number);

for i = 1:number
    roles(i) = role_list(types(i));    
end
roles = cellstr(roles);
end
