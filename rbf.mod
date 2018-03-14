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
param rho1;
param rho2;
param sigma;
param best_nl;
param err_tr;
param err_v;
param loc_err_tr;
param loc_err_v;
param nmax;
param stop_tr;

param lb_f;
param ub_f;
param lb{1..ingr};
param ub{1..ingr};

# Variabili
var v{1..nl}; # Pesi in uscita
var c{1..nl}; # Centri

# Funzione obiettivo training (gaussiana)
minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
sum{j in 1..nl}(v[j] * exp(-(sum{k in 1..ingr}(xtr[p,k]) - c[j])^2)) - ytr[p])^2 +
(rho1/2.0)*sum{j in 1..nl}(v[j]^2) + (rho2/2.0)*sum{j in 1..nl}(c[j]^2);

# Validation test
minimize Error_v: 1/(2.0*Pv)*sum{p in 1..Pv}abs(
sum{j in 1..nl}(v[j] * exp(-(sum{k in 1..ingr}(xv[p,k]) - c[j])^2)) - yv[p])

#Multiquadrica inversa
#minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
#sum{j in 1..nl}(v[j] * (sum{k in 1..ingr}((xtr[p,k]-c[j])^2 + sigma^2)^(-1/2)) - ytr[p]))^2 +
#(rho1/2.0)*sum{j in 1..nl}(v[j]^2) + (rho2/2.0)*sum{j in 1..nl}(c[j]^2);

# Validation test
#minimize Error_v: 1/(2.0*Pv)*sum{p in 1..Pv}abs(
#sum{j in 1..nl}(v[j] * (sum{k in 1..ingr}((xv[p,k]-c[j])^2 + sigma^2)^(-1/2)) - yv[p]))

# Thin plate spline (training)
#minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
#sum{j in 1..nl}(v[j] * (sum{k in 1..ingr}(xtr[p,k]) - c[j])^2 * log(abs(sum{k in 1..ingr}(xtr[p,k]) - c[j]))
#- ytr[p])^2 + (rho1/2.0)*sum{j in 1..nl}(v[j]^2) + (rho2/2.0)*sum{j in 1..nl}(c[j]^2));

# Validation test
#minimize Error_v: 1/(2.0*Pv)*sum{p in 1..Pv}abs(
#sum{j in 1..nl}(v[j] * (sum{k in 1..ingr}(xv[p,k]) - c[j])^2 * log(abs(sum{k in 1..ingr}(xv[p,k]) - c[j])))
#- yv[p]);
