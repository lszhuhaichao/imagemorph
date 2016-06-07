function k = computeWeights( y, x, y_prime, x_prime, kernel)

N = size( x, 1 );

% Radial basis function (part)
B = zeros(N);   %%%%%%% Thin-plate splines
for i=1:N
    s = bsxfun(@minus, [y x], [y(i) x(i)]);
    s = sqrt(sum(s.*s, 2));
    ind = find(s~=0);
    B(:,i) = kernel(s);
end

% Linear portion.
top = [y' 0 0 0; x' 0 0 0; ones(N,1)' 0 0 0];
right(:,1) = x;
right(:,2) = y;
right(:,3) = ones(N,1);

B = [top; B right];

% Solve the linear equation.
bi = [0; 0; 0; y_prime; 0; 0; 0; x_prime];

k = [B zeros(N+3); zeros(N+3) B]\bi;

end

