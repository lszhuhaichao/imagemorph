function getpoint( imagefig, varargins )

global handles;
global cp1;
global cp2;

pt = get(gca,'currentpoint');
h = get(gca, 'children');
h = h(end);
pt = floor( pt(1,1:2) );
pt = [pt(2) pt(1)];
plot(pt(2), pt(1),'*');

if(isempty(find(handles==h, 1)))
    
    handles(end+1) = h;
    
    if(length(handles)==1)
        cp1 = [cp1; pt];
    else
        cp2 = [cp2; pt];
    end
else
    if(find(handles==h)==1)
        cp1 = [cp1;pt];
    elseif(find(handles==h)==2)
        cp2 = [cp2;pt];
    end
end