% https://en.wikipedia.org/wiki/Perlin_noise
% https://mrl.nyu.edu/~perlin/doc/oscar.html#noise

function value = PerlinNoise(x, y, Gradient)

% Determine grid cell coordinates
x0 = floor(x);
x1 = x0 + 1;
y0 = floor(y);
y1 = y0 + 1;

% Determine interpolation weights
sx = s_curve(x - x0);
sy = s_curve(y - y0);

% Interpolate between grid point gradients
n0 = dotGridGradient(x0, y0, x, y, Gradient);
n1 = dotGridGradient(x1, y0, x, y, Gradient);
ix0 = lerp(n0, n1, sx);

n0 = dotGridGradient(x0, y1, x, y, Gradient);
n1 = dotGridGradient(x1, y1, x, y, Gradient);
ix1 = lerp(n0, n1, sx);

value = lerp(ix0, ix1, sy);
end

function ret = lerp(a0, a1, w)
ret = a0 + w*(a1 - a0);
end

function ret = dotGridGradient(ix, iy, x, y, Gradient)
% Compute the distance vector
dx = x - ix;
dy = y - iy;

% Compute the dot-product
ret =  (dx*Gradient(iy, ix, 1) + dy*Gradient(iy, ix, 2));

end

function ret = s_curve(t)
ret = t * t * (3 - 2 * t);
end