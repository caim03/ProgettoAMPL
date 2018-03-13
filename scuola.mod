param file_tr symbolic;
param file_val symbolic;
param file_log symbolic;

param ingr;

param Ptr;
param xtr{1..Ptr, 1..ingr};
param ytr{1..Ptr};

param Pv;
param xv{1..Pv, 1..ingr};
param yv{1..Pv};

param nl, integer;
param gamma;
param best_nl;
param err_tr;
param err_v;
param loc_err_tr;
param loc_err_v;
param nmax;
param stop_tr;

# Variabili
var v{1..nl}; # Pesi in uscita
var win{1..ingr + 1, 1..nl}; # Pesi in ingresso

# Funzione obiettivo training
minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
sum{j in 1..nl}(v[j]/
(1+exp(-(sum{k in 1..ingr}win[k,j]*xtr[p,k]-win[ingr+1,j]))))-ytr[p])^2 +0.5*gamma*sum{i in 1..ingr+1, j in 1..nl}(win[i,j]^2+v[j]^2);

# Validation test
minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(
sum{j in 1..nl}(v[j]/
(1+exp(-(sum{k in 1..ingr}win[k,j]*xv[p,k]-win[ingr+1,j])))) -yv[p]);
