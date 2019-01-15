
function [roles] = assign_roles(number)

role_list = ["Scientist"; "QuarantineSpec"; "Researcher"; "Dispatcher"; "Medic"; "Ops"; "Contingency"];

roles = randi([1 numel(role_list)],1,number);

end
