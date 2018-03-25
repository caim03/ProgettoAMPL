#DECLARE VARIABLES
#Length of input vectors
param ingr;
#Number of rows in the data set
param Ptr;
#Number of clusters
param nl;
#Point matrix
param xtr{1..Ptr, 1..ingr};
param ytr{1..Ptr};
#Distance matrix
param distance_matrix {i in {1..Ptr}, j in {1..Ptr}};

param file_tr symbolic;
param output symbolic;

param lb{1..ingr};
param ub{1..ingr};

param c{1..nl,1..ingr};
#Corresponding binary matrix
var binary_matrix {i in 1..Ptr, j in 1..Ptr} binary;



#DECLARE OBJECTIVE FUNCTION
minimize Distance: sum {i in 1..Ptr, j in 1..Ptr} distance_matrix[i,j] * binary_matrix[i,j];

#DECLARE CONSTRAINTS
#Each point should belong to exactly one cluster
subject to c1 {i in 1..Ptr}: sum{j in 1..Ptr} binary_matrix[i,j] = 1;
#Exactly k clusters should exist
subject to c2 : sum{i in 1..Ptr} binary_matrix[i,i] = nl;
#A point can only belongs to an EXISTING cluster
subject to c3 {i in 1..Ptr, j in 1..Ptr}: binary_matrix[j,j] >= binary_matrix[i,j]
