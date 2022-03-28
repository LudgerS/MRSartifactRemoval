function w = Fadeeva_weideman(z, N)
% modified from A. Weideman's code
% http://appliedmaths.sun.ac.za/~weideman/research/cef.html
% which is based on J.A.C. Weideman, "Computation of the Complex Error 
% Function", SIAM J. Numer. Anal., Vol. 31, pp. 1497-1518 (1994)
%
% computes w(z) = exp(-z^2)*erfc(-iz) = exp(-z^2)*(1 - erf(-iz))
% works for complex z but imag(z) must be >= 0
% no corresponding assertion to improve computation speed

M = 2*N;  
M2 = 2*M;                                           % M2 = no. of sampling points
k = ((-M + 1):1:(M - 1))';    

L = sqrt(N/sqrt(2));                                % Optimal choice of L.

theta = k*pi/M; 
t = L*tan(theta/2);

f = [0; exp(-t.^2).*(L^2 + t.^2)];                  % Function to be transformed

a = real(fft(fftshift(f)))/M2;                      % Coefficients of transform
a = flipud(a(2:N+1));                               % Reorder coefficients

Z = (L + 1i*z)./(L - 1i*z);                         % Transform of input
p = polyval(a, Z);                                  % Polynomial evaluation.

w = 2*p./(L - 1i*z).^2 + (1/sqrt(pi))./(L - 1i*z);  % Evaluate w(z).




