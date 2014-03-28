  function ShowSOR()
% Checks out the SOR method on a couple of problems.
Region = {'S','L','C','D','A','H', 'B'} ; 
GridSize = 20;
close all
for k=1:7
    figure
    AnalyzeThis(Region{k},GridSize)
end
    
  function AnalyzeThis(R,g)
% Displays how omega affects the spectral radius associated with the SOR
% iteration when it is applied to the Laplacian defined by region R and 
% gridsize g. Possible values for R are 'S','L','C','D','A','H', or 'B'
m = 20;
omega = linspace(1,2,m);
rho = zeros(1,m);
G = numgrid(R,g);
subplot(1,2,1)
spy(G)
title('The Region','fontsize',16)


A = delsq(G);
L = tril(A, -1);
D = diag(diag(A));

j = 0;
for i = omega
    Mw = D./i + L;
    Nw = (1./i - 1)*D - L';
    Z = Mw\Nw;
    j = j + 1;
    rho(j) = max(abs(eig(full(Z))));
end


subplot(1,2,2)
plot(rho, omega)
title('\omega vs \rho','fontsize',16)
xlabel('\rho')
ylabel('\omega')
set(gcf,'position',[100 100 1400 600])

