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

param lb_f;
param ub_f;
param lb{1..ingr};
param ub{1..ingr};

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

# Funzione obiettivo training - sigmoid
#minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
#sum{j in 1..nl}(v[j]/
#(1+exp(-(sum{k in 1..ingr}win[k,j]*xtr[p,k]-win[ingr+1,j]))))-ytr[p])^2 +0.5*gamma*sum{i in 1..ingr+1, j in 1..nl}(win[i,j]^2+v[j]^2);

# Validation test
#minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(
#sum{j in 1..nl}(v[j]/
#(1+exp(-(sum{k in 1..ingr}win[k,j]*xv[p,k]-win[ingr+1,j])))) -yv[p]);

# Tangente iperbolica
#minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
#sum{j in 1..nl}(v[j]*1.7159*
#(tanh(0.666667 * (sum{k in 1..ingr}win[k,j]*xtr[p,k]-win[ingr+1,j]))))-ytr[p])^2 +0.5*gamma*sum{i in 1..ingr+1, j in 1..nl}(win[i,j]^2+v[j]^2);

# Validation test
#minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(
#sum{j in 1..nl}(v[j]*1.7159*
#(tanh(0.666667 * (sum{k in 1..ingr}win[k,j]*xv[p,k]-win[ingr+1,j])))) -yv[p]);

# Bipolar Sigmoid
#minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
#sum{j in 1..nl}(v[j] * (-1 + 1/
#(1+exp(-(sum{k in 1..ingr}win[k,j]*xtr[p,k]-win[ingr+1,j])))))-ytr[p])^2 +0.5*gamma*sum{i in 1..ingr+1, j in 1..nl}(win[i,j]^2+v[j]^2);

# Validation test
#minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(
#sum{j in 1..nl}(v[j] * (-1 + 1/
#(1+exp(-(sum{k in 1..ingr}win[k,j]*xv[p,k]-win[ingr+1,j]))))) -yv[p]);

# RELU
minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
sum{j in 1..nl}(v[j]*
log(1+exp((sum{k in 1..ingr}win[k,j]*xtr[p,k]-win[ingr+1,j]))))-ytr[p])^2 +0.5*gamma*sum{i in 1..ingr+1, j in 1..nl}(win[i,j]^2+v[j]^2);

# Validation RELU
minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(
sum{j in 1..nl}(v[j]*
log(1+exp((sum{k in 1..ingr}win[k,j]*xv[p,k]-win[ingr+1,j])))) -yv[p]);

# BENT IDENTITY
#minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
#sum{j in 1..nl}(v[j]*
#((sqrt((sum{k in 1..ingr}win[k,j]*xtr[p,k]-win[ingr+1,j])^2 + 1)-1)*0.5 +
#sum{k in 1..ingr}win[k,j]*xtr[p,k]-win[ingr+1,j]))-ytr[p])^2 +
#0.5*gamma*sum{i in 1..ingr+1, j in 1..nl}(win[i,j]^2+v[j]^2);

# Validation BENT
#minimize Error_v: 1/(2.0*Pv)*sum{p in 1..Pv}abs(
#sum{j in 1..nl}(v[j]*
#((sqrt((sum{k in 1..ingr}win[k,j]*xv[p,k]-win[ingr+1,j])^2 + 1)-1)*0.5 +
#sum{k in 1..ingr}win[k,j]*xv[p,k]-win[ingr+1,j]))-yv[p])
