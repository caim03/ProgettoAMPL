param file_tr symbolic;
param file_val symbolic;
param file_log symbolic;
param file_centroids symbolic;
param bestV symbolic;
param bestC symbolic;

param ingr;

param Ptr;
param xtr{1..Ptr, 1..ingr};
param ytr{1..Ptr};

param Pv;
param xv{1..Pv, 1..ingr};
param yv{1..Pv};

param nl, integer;
param gamma;
param sigma;

param best_nl;
param err_tr;
param err_v;
param loc_err_tr;
param loc_err_v;

param loc_loc_err_tr;
param loc_loc_err_v;

#param loc_loc_XV{1..Pv};
#param loc_loc_YV{1..Pv};

#param loc_XV{1..Pv};
#param loc_YV{1..Pv};

#param best_XV{1..Pv};
#param best_YV{1..Pv};

param nmax;
param stop_tr;
param n_repeat;

param boh;
param lb_f;
param ub_f;
param lb{1..ingr};
param ub{1..ingr};

param dmax;
param times;
param part_sum;

param kmeans;
param init_centroids{1..nl,1..ingr}; # Centri

param prec_err_tr;
param prec_err_v;
param epsilon;

param best_v{1..nl};
param best_c{1..nl,1..ingr};

param loc_best_v{1..nl};
param loc_best_c{1..nl,1..ingr};

param loc_loc_best_v{1..nl};
param loc_loc_best_c{1..nl,1..ingr};

param start_v{1..nl};
param start_c{1..nl,1..ingr}; 


# Variabili
var v{1..nl}; # Pesi in uscita
var c{1..nl,1..ingr}; # Centri

# Funzione obiettivo training (gaussiana)
#minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(sum{j in 1..nl}(v[j] * exp(-0.5*(nl/(dmax^2))*sum{k in 1..ingr}(xtr[p,k] - c[j,k])^2)) - ytr[p])^2
#+ (gamma/2.0)*sum{j in 1..nl,k in 1..ingr}(c[j,k]^2 + v[j]^2);

# Validation test
#minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(sum{j in 1..nl}(v[j] * exp(-0.5*(nl/(dmax^2))*sum{k in 1..ingr}(xv[p,k] - c[j,k])^2)) - yv[p]);

# Funzione obiettivo training (multiquadrica inversa)
minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
sum{j in 1..nl}(v[j] * sqrt(sum{k in 1..ingr}(xtr[p,k] - c[j,k])^2 + sigma))  - ytr[p])^2
+ (gamma/2.0)*sum{j in 1..nl,k in 1..ingr}(c[j,k]^2 + v[j]^2);

minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(
sum{j in 1..nl}(v[j] * sqrt(sum{k in 1..ingr}(xv[p,k] - c[j,k])^2 + sigma))  - yv[p]);





#minimize XV{p in 1..Pv}: sum{j in 1..nl}(v[j] * exp(-0.5*(nl/(dmax^2))*sum{k in 1..ingr}(xv[p,k] - c[j,k])^2));

#minimize YV{p in 1..Pv}: yv[p];
