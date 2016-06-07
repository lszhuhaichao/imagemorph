function [ output ] = interpolateImage( cy, cx, k, I, kernel)

[height, width, channels] = size( I );
output = zeros( height, width, channels );

N = size(cx,1);
% For each pixel in the final image...

temp = zeros(height, width);
[py, px] = find(temp==0);
pos = [py/height px/width];
dist = zeros(size(px,1), size(cy,1));
for i=1:size(cy,1)
    ds = bsxfun(@minus, pos, [cy(i) cx(i)]) ;
    ds = sqrt(sum(ds.^2,2));
    dist(:,i) = ds;    
end
dist = kernel(dist);
npos1 = dist*k(1:N);                                                   %sum(bsxfun(@times, dist, k(1:N)'),2);
npos2 = dist*k(N+4:2*N+3);                                             %sum(bsxfun(@times, dist, k(N+4:2*N+3)'),2);
npos1 = npos1 + k(N+1)*pos(:,2) + k(N+2) * pos(:,1)  + k(N+3);         %npos(1) = npos(1) + k(N+1) * x + k(N+2) * y + k(N+3);
npos2 = npos2 + k(N+N+4)*pos(:,2)  + k(N+N+5) * pos(:,1)  + k(N+N+6);  %npos(2) = npos(2) + k(N+N+4) * x + k(N+N+5) * y + k(N+N+6);
npos1 = npos1*height;
npos2 = npos2*width;

idx = find(((npos1<height).*(npos1>1).*(npos2<width).*(npos2>1))>0);   %ntersect(intersect(find(npos1<=height)&&(npos1>0))),find(npos2<=width&&npos1>0));
tx = zeros(size(npos1));
ty = zeros(size(npos1));
tx(idx) = npos1(idx) - floor(npos1(idx));
ty(idx) = npos2(idx) - floor(npos2(idx));

tx = reshape(tx',[height, width]);
ty = reshape(ty',[height, width]);

yval = [floor(npos1) ceil(npos1)];
xval = [floor(npos2) ceil(npos2)];

ind1 = sub2ind([height, width], yval(idx,1), xval(idx,1));
ind2 = sub2ind([height, width], yval(idx,1), xval(idx,2));
ind3 = sub2ind([height, width], yval(idx,2), xval(idx,1));
ind4 = sub2ind([height, width], yval(idx,2), xval(idx,2));

for d = 1:channels
    imm = double(I(:,:,d));
    v1 = imm;
    v2 = imm;
    imm1 = imm(ind1).*(1-tx(idx)) + imm(ind2).*tx(idx);
    imm2 = imm(ind3).*(1-tx(idx)) + imm(ind4).*tx(idx);
    v1(idx) = imm1;
    v2(idx) = imm2;
    output(:,:,d) = v1 .* (1 - ty) + v2 .* ty;
end
% Scale it back down for visualization.
output = ((output)/(max(output(:))));

end
