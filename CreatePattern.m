clear
close all

%% SIZE OF PATTERN [mm]
Lx = 1000;
Ly = 200;

%% SIZE OF CAMERA PIXEL ON PATTERN [mm]
p = 1;

%% Amount of white/black
% -0.5 < threshold < 0.5
% threshold = 0 -> 50% white/black (recommended)
% threshold > 0 -> less white/more black
% threshold < 0 -> more white/less black
threshold = 0;

%% DETERMINE SIZE OF PERLIN NOISE GRID
% For a DIC pattern, features need to be at least 3 pixels (to avoid
% aliasing) and less than ~7 pixels (to have a small enough resolution).
% The grid force to have a black spot at each of its vertex. As a result
% features are on the order of the spacing of the grid.
d = 6*p;

% Size of grid
Nx = ceil(Lx/d)+2; %(Take one more point to solve the last row/column)
Ny = ceil(Ly/d)+2; %(Take one more point to solve the last row/column)

%% CALCULATE RANDOM GRADIENTS OF PERLIN GRID
% Create gradient
Gradient = zeros(Ny, Nx, 2);
for IIx = 1:Nx
    for IIy = 1:Ny
        Gradient(IIy, IIx,:) = 2*rand(2,1) - 1; % (uniform) random vector
        Gradient(IIy, IIx,:) = Gradient(IIy, IIx,:)/sqrt(sum(Gradient(IIy, IIx,:).^2)); % normalized
    end
end

%% CALCULATE PERLIN NOISE
[x,y] = meshgrid(linspace(1,Nx-1,ceil(Lx/p)+1), linspace(1,Ny-1,ceil(Ly/p)+1));

pixel = zeros(size(x));
for IIx = 1:size(x,2)
    for IIy = 1:size(x,1)
        pixel(IIy, IIx) = PerlinNoise(x(IIy, IIx), y(IIy, IIx), Gradient);
    end
end

%% EXTRACT COORDINATES AND PIXEL VALUE
x = (x-1)/(Nx-2)*Lx;
y = (y-1)/(Ny-2)*Ly;

pixel(pixel>threshold) = 1;
pixel(pixel<threshold) = 0;

%% PLOT CUTTING PATTER
figure('Position',[0 0 Lx Ly]);
axes('Units', 'normalized', 'Position', [0 0 1 1])
colormap gray
contour(x,y,pixel,1)
axis equal
axis off
drawnow
set(gcf,'renderer','Painters')

%% PLOT PATTERN
figure;
colormap gray
contourf(x,y,pixel,1)
axis equal
drawnow

fprintf('Amount of white = %.2f %% \n Amount of black = %.2f %% \n', sum(sum(pixel))/size(pixel,1)/size(pixel,2)*100, 100-sum(sum(pixel))/size(pixel,1)/size(pixel,2)*100)
