param file_tr symbolic;
param file_val symbolic;
param file_log symbolic;

param ingr1;
param ingr2;

param Ptr;
param xtr1{1..Ptr, 1..ingr1};
param xtr2{1..Ptr, 1..ingr2};
param ytr{1..Ptr};

param Pv;
param xv1{1..Pv, 1..ingr1};
param xv2{1..Pv, 1..ingr2};
param yv{1..Pv};

param lb_f;
param ub_f;

param lb1{1..ingr1};
param ub1{1..ingr1};
param lb2{1..ingr2};
param ub2{1..ingr2};

param nl1, integer;
param nl2, integer;
param gamma1;
param gamma2;
param best_nl1;
param best_nl2;
param err_tr;
param err_v;
param loc_err_tr;
param loc_err_v;
param nmax;
param stop_tr;

param best_v1{1..nl1}; # Pesi in uscita
param best_win1{1..ingr1 + 1, 1..nl1}; # Pesi in ingresso
param best_v2{1..nl2}; # Pesi in uscita
param best_win2{1..ingr2 + 1, 1..nl2}; # Pesi in ingresso
param best_z{1..2}; #Peso tra le due reti

# Variabili
var v1{1..nl1}; # Pesi in uscita
var win1{1..ingr1 + 1, 1..nl1}; # Pesi in ingresso
var v2{1..nl2}; # Pesi in uscita
var win2{1..ingr2 + 1, 1..nl2}; # Pesi in ingresso
var z{1..2}; #Peso tra le due reti

#minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
#sum{j in 1..nl}(v[j] * (-1 + 1/
#(1+exp(-(sum{k in 1..ingr1}win[k,j]*xtr[p,k]-win[ingr1+1,j])))))-ytr[p])^2 +0.5*gamma*sum{i in 1..ingr+1, j in 1..nl}(win[i,j]^2+v[j]^2);

#Prima rete:
#sum{j in 1..nl1}(v1[j]/(1+exp(-(sum{k in 1..ingr1}win1[k,j]*xtr1[p,k]-win[ingr1+1,j]))));

#Seconda rete:
#sum{j in 1..nl2}(v2[j]/(1+exp(-(sum{k in 1..ingr2}win2[k,j]*xtr2[p,k]-win[ingr2+1,j]))));

minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(

z[1] * (-1 + 1/(1+exp(-(sum{j in 1..nl1}v1[j] * (-1 + 1/(1+exp(-(sum{k in 1..ingr1}win1[k,j]*xtr1[p,k]-win1[ingr1+1,j]))))))))
+
z[2] * (-1 + 1/(1+exp(-(sum{j in 1..nl2}v2[j] * (-1 + 1/(1+exp(-(sum{k in 1..ingr2}win2[k,j]*xtr2[p,k]-win2[ingr2+1,j]))))))))
-ytr[p])^2

+ 0.5*gamma1*sum{i in 1..ingr1+1, j in 1..nl1}(win1[i,j]^2+v1[j]^2) + 0.5 * gamma2 * sum{k in 1..ingr2+1, l in 1..nl2}(win2[k,l]^2+v2[l]^2) ;

minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(

z[1] * (-1 + 1/(1+exp(-(sum{j in 1..nl1}v1[j] * (-1 + 1/(1+exp(-(sum{k in 1..ingr1}win1[k,j]*xv1[p,k]-win1[ingr1+1,j]))))))))
+
z[2] * (-1 + 1/(1+exp(-(sum{j in 1..nl2}v2[j] * (-1 + 1/(1+exp(-(sum{k in 1..ingr2}win2[k,j]*xv2[p,k]-win2[ingr2+1,j]))))))))
-yv[p]);

#BENT IDENTITY

#minimize Error_tr:  1/(2.0*Ptr)*sum{p in 1..Ptr}(


#z[1] * ((sqrt(((sum{j in 1..nl1}v1[j] * ((sqrt((sum{k in 1..ingr1}win1[k,j]*xtr1[p,k]-win1[ingr1+1,j])^2 + 1)-1)*0.5 +sum{k in 1..ingr1}win1[k,j]*xtr1[p,k]-win1[ingr1+1,j]))^2
#+ 1)-1)*0.5 + (sum{j in 1..nl1}v1[j] * ((sqrt((sum{k in 1..ingr1}win1[k,j]*xtr1[p,k]-win1[ingr1+1,j])^2 + 1)-1)*0.5 +sum{k in 1..ingr1}win1[k,j]*xtr1[p,k]-win1[ingr1+1,j]))))
#+
#z[2] * ((sqrt(((sum{j in 1..nl2}v2[j] * ((sqrt((sum{k in 1..ingr2}win2[k,j]*xtr2[p,k]-win2[ingr2+1,j])^2 + 1)-1)*0.5 + sum{k in 1..ingr2}win2[k,j]*xtr2[p,k]-win2[ingr2+1,j]))^2
#+ 1)-1)*0.5 + (sum{j in 1..nl2}v2[j] * ((sqrt((sum{k in 1..ingr2}win2[k,j]*xtr2[p,k]-win2[ingr2+1,j])^2 + 1)-1)*0.5 + sum{k in 1..ingr2}win2[k,j]*xtr2[p,k]-win2[ingr2+1,j]))))
#-ytr[p])^2

#+ 0.5*gamma1*sum{i in 1..ingr1+1, j in 1..nl1}(win1[i,j]^2+v1[j]^2) + 0.5 * gamma2 * sum{k in 1..ingr2+1, l in 1..nl2}(win2[k,l]^2+v2[l]^2);

#minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(
#z[1] * ((sqrt(((sum{j in 1..nl1}v1[j] * ((sqrt((sum{k in 1..ingr1}win1[k,j]*xv1[p,k]-win1[ingr1+1,j])^2 + 1)-1)*0.5 +sum{k in 1..ingr1}win1[k,j]*xv1[p,k]-win1[ingr1+1,j]))^2
#+ 1)-1)*0.5 + (sum{j in 1..nl1}v1[j] * ((sqrt((sum{k in 1..ingr1}win1[k,j]*xv1[p,k]-win1[ingr1+1,j])^2 + 1)-1)*0.5 +sum{k in 1..ingr1}win1[k,j]*xv1[p,k]-win1[ingr1+1,j]))))
#+
#z[2] * ((sqrt(((sum{j in 1..nl2}v2[j] * ((sqrt((sum{k in 1..ingr2}win2[k,j]*xv2[p,k]-win2[ingr2+1,j])^2 + 1)-1)*0.5 + sum{k in 1..ingr2}win2[k,j]*xv2[p,k]-win2[ingr2+1,j]))^2
#+ 1)-1)*0.5 + (sum{j in 1..nl2}v2[j] * ((sqrt((sum{k in 1..ingr2}win2[k,j]*xv2[p,k]-win2[ingr2+1,j])^2 + 1)-1)*0.5 + sum{k in 1..ingr2}win2[k,j]*xv2[p,k]-win2[ingr2+1,j]))))
#-yv[p]);
