function saveControlPoints(filename)

global cp1;
global cp2;

if(isempty(cp1)||isempty(cp2))
    disp('Error');
    return;
end


if(size(cp1,1)~=size(cp2,1))
    disp('The sizes of two point lists are not matched!');
    return;
end

save(filename,'cp1','cp2');
