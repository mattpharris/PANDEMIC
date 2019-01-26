function [output] = pick_best_option(options)

dims = size(options);
points = zeros(1,dims(1));

for i=1:numel(dims(1))
    for j = 1:4
        points(i) = points(i) + str2double(extractBefore(string(options(i,j)),"_"));
    end
end

a = 1:numel(dims(1));
w = points;
N = 1;
R = a( sum( bsxfun(@ge, rand(N,1), cumsum(w./sum(w))), 2) + 1 );

output = options(R,:);
end