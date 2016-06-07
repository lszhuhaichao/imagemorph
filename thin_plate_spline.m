function [ output ] = thin_plate_spline( s )

ind = find(s~=0);
output = zeros(size(s));
output(ind) = s(ind) .* s(ind) .* log(s(ind));


end

