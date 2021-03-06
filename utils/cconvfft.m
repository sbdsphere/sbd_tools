function [ out ] = cconvfft( X, adj, fftsz, realout )
%CCONVFFT  Cyclic convolution using FFT
%  Usage:  CCONVFFT( {X1, X2, ..., Xn}, adj, fftsz, realout )

% Process arguments
if nargin < 2
  adj = zeros(numel(X));
else
  assert(numel(adj) == numel(X), ...
    'Number of adjoint flags must equal number of vectors in X.');
end
if nargin < 3
  fftsz = max(cellfun(@(x) length(x), X));  
end
if nargin < 4;  realout = true; end


% Compute cyclic convolution
out = 1;
for i = 1:numel(X)
  xhat = fft(X{i}(:), fftsz);
  if adj(i);  xhat = conj(xhat);  end
  out = out .* xhat;
end

out = ifft(out);
if realout;  out = real(out);  end
  
end