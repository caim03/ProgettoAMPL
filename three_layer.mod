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

param nl1, integer;
param nl2, integer;
param gamma;
param best_nl1;
param best_nl2;
param err_tr;
param err_v;
param loc_err_tr;
param loc_err_v;
param nmax;
param stop_tr1;
param stop_tr2;

# Variabili
var v{1..nl2}; # Pesi in uscita
var win{1..ingr + 1, 1..nl1}; # Pesi in ingresso
var l{1..nl1 + 1, 1..nl2}; # Pesi tra due strati nascosti

# Funzione obiettivo training
minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
sum{j in 1..nl2}(v[j]/
(1+exp(-(sum{i in 1..nl1}(l[i,j])/(1+exp(-(sum{k in 1..ingr}(xtr[p,k]*win[k,i]) - win[ingr+1, i]))) - l[nl1+1, j]))))
-ytr[p])^2 +0.5*gamma*sum{i in 1..ingr+1, j in 1..nl1, k in 1..nl2}(win[i,j]^2+v[j]^2 + l[j,k]);

# Validation test
minimize Error_v: 1/(2.0*Pv)*sum{p in 1..Pv}abs(
sum{j in 1..nl2}(v[j]/
(1+exp(-(sum{i in 1..nl1}(l[i,j])/(1+exp(-(sum{k in 1..ingr}(xv[p,k]*win[k,i]) - win[ingr+1, i]))) - l[nl1+1, j]))))
-yv[p]);
