function morphImage(img1,img2, cp1,cp2, n_step, output_name)

% Find the values of the weights.
N = size(cp1, 1); 
maxSz = max(size(img1), size(img2));

sz1 = size(img1);
Isz = maxSz - sz1;
pad_images1 = padarray(img1, [max(Isz(1), 0) max(Isz(2), 0)], 'post');
sz2 = size(img2);
Isz = maxSz - sz2;
pad_images2 = padarray(img2, [max(Isz(1), 0) max(Isz(2), 0)], 'post');

[height, width, ~] = size(pad_images1);

% Scale down to 0.0 - 1.0 range
cp1(:,1) = cp1(:,1) / width;
cp1(:,2) = cp1(:,2) / height;
cp2(:,1) = cp2(:,1) / width;
cp2(:,2) = cp2(:,2) / height;

% Create an interpolated x and y
steps = 1/(n_step + 1);

% Compare each of the images with all others.
x1 = cp1(:,1);
y1 = cp1(:,2);

x2 = cp2(:,1);
y2 = cp2(:,2);

len = length(steps:steps:0.99);
tic;
num = 0;
for t=steps:steps:0.99
    num = num + 1;
    disp(['t=' mat2str(t) ', ' int2str(num) '/' int2str(len)]);
    % Interpolate control points.
    yt = (1 - t) * y1 + t * y2;
    xt = (1 - t) * x1 + t * x2;

    kernel = @thin_plate_spline;
    %kernel = @(s) ( exp( -kw * (s * s) ) );

    % Calculate weights
    k1 = computeWeights( yt, xt, y1, x1, kernel);
    k2 = computeWeights( yt, xt, y2, x2, kernel);
    
    % Generate new morphed images
    I1 = interpolateImage( yt, xt, k1, pad_images1, kernel);

    I2 = interpolateImage( yt, xt, k2, pad_images2, kernel);

    % Interpolate images and write.
    If = (1 - t) * I1 + t * I2;

    imwrite(If, [output_name '_' mat2str(t) '.png']);
end
toc