param file_tr symbolic; #File di training
param file_val symbolic; #File di validation
param file_test symbolic;
param file_log symbolic; #File di log
#param file_centroids symbolic; #
param bestV symbolic; #File in cui vengono salvati i pesi V migliori (iniziali)
param bestC symbolic; #File in cui vengono salvati i centri C migliori (iniziali)
param best_weigth symbolic;
param best_centr symbolic;

param ingr; #Ingressi

#Training set
param Ptr;
param xtr{1..Ptr, 1..ingr};
param ytr{1..Ptr};

#Validation Set
param Pv;
param xv{1..Pv, 1..ingr};
param yv{1..Pv};

#Test set
param Ptest;
param xtest{1..Ptest, 1..ingr};
param ytest{1..Ptest};


param nl, integer; #Numero di neuroni utilizzati
param gamma; #Parametro di regolarizzazione gamma

#RBF Multiquadrica inversa
param sigma; #Parametro sigma utilizzato nella rbf multiquadrica inversa

#RBF Gaussiana
param dmax; #Parametro delta utilizzato nella rbf gaussiana, calcolato tramite la distanza massima tra i centroidi
param times;
param part_sum;

#Lower/Upper bound di ogni ingresso.
param lb_f;
param ub_f;
param lb{1..ingr};
param ub{1..ingr};


#Tuning dei parametri:
param best_nl;  #Miglior numero di neuroni trovato durante il tuning

param err_tr; #Errore di training migliore in assoluto (durante il tuning)
param err_v; #Errore di validation migliore in assoluti (durante il tuning)

param loc_err_tr; #Errore di training migliore tra le nmax iterazioni con il numero di neuroni fissato (durante il tuning)
param loc_err_v; #Errore di validation migliore tra le nmax iterazioni con il numero di neuroni fissato (durante il tuning)

param loc_loc_err_tr; #Errore di training migliore tra le iterazioni dell'algoritmo di decomposizione delle RBF (durante il tuning)
param loc_loc_err_v; #Errore di validation migliore tra le iterazioni dell'algoritmo di decomposizione delle RBF (durante il tuning)

param nmax; #numero di iterazioni da effettuare con ogni nl
param stop_tr; #condizione di stop del traing
param n_repeat; #condizione di stop della decomposizione

param app;

#Decomposizione supervisionata a due blocchi
param prec_err_tr; #Mantiene il precedente errore di training, per valutare la distanza tra il nuovo e vecchio errore da inserire nella condizione di stop
#param prec_err_v; #Mantiene il precedente errore di validation (non serve)
param epsilon; #Parametro epsilon per la condizione di stop

#Migliori centri e pesi
#I seguenti parametri servono a tener traccia dei migliori centri e pesi iniziali utilizzati durante il tuning dei parametri.
param best_v{1..nl};
param best_c{1..nl,1..ingr};

param loc_best_v{1..nl};
param loc_best_c{1..nl,1..ingr};

param loc_loc_best_v{1..nl};
param loc_loc_best_c{1..nl,1..ingr};

param start_v{1..nl};
param start_c{1..nl,1..ingr};

#Parametri utilizzati per il test dell'addestramento non supervisionato, utilizzando il kmeans. Dato che AMPL non ammette più funzioni obiettivo durante un run
#Abbiamo prima applicato il kmeans per ottenere i centroidi dei cluster, ed inserito su file. Comunque non dà buoni risultati
#param kmeans;
#param init_centroids{1..nl,1..ingr}; # Centri

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------#

# Variabili
var v{1..nl}; # Pesi in uscita
var c{1..nl,1..ingr}; # Centri

# Funzione obiettivo training (multiquadrica diretta)
minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(
sum{j in 1..nl}(v[j] * sqrt(sum{k in 1..ingr}(xtr[p,k] - c[j,k])^2 + sigma))  - ytr[p])^2
+ (gamma/2.0)*sum{j in 1..nl,k in 1..ingr}(c[j,k]^2 + v[j]^2);

#Decommentare se si vuole effettuare il tuning
#minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(
#sum{j in 1..nl}(v[j] * sqrt(sum{k in 1..ingr}(xv[p,k] - c[j,k])^2 + sigma))  - yv[p]);



# Funzione obiettivo training (gaussiana)
#minimize Error_tr: 1/(2.0*Ptr)*sum{p in 1..Ptr}(sum{j in 1..nl}(v[j] * exp(-0.5*(nl/(dmax^2))*sum{k in 1..ingr}(xtr[p,k] - c[j,k])^2)) - ytr[p])^2
#+ (gamma/2.0)*sum{j in 1..nl,k in 1..ingr}(c[j,k]^2 + v[j]^2);

# Validation test
#minimize Error_v: (1/Pv)*sum{p in 1..Pv}abs(sum{j in 1..nl}(v[j] * exp(-0.5*(nl/(dmax^2))*sum{k in 1..ingr}(xv[p,k] - c[j,k])^2)) - yv[p]);
