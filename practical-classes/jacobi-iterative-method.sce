
//function [iter_x,norm_dif,k,residual_norm] = jacobi_algorithm(A,b,x_zero,E_tolerance,M)

diagonal_elements = diag(A)
diagonal_matrix = diag(diagonal_elements)
inverse_diagonal = inv(diagonal_matrix)
[row_num,col_num]=size(A)
r_matrix=zeros(row_num,col_num)
r_matrix(row_num,1)=A(row_num,1)
r_matrix(1,col_num)=A(1,col_num)
r_matrix = -r_matrix
t_matrix = inverse_diagonal*r_matrix
c_matrix = inverse_diagonal*b
iter_x = [0;0;0]
k=1
M=1000
E_tolerance = 0.000001
while (k <= M)
    iter_x_previous = iter_x
    iter_x = t_matrix*iter_x + c_matrix
    norm_dif = norm(iter_x - iter_x_previous)    
    k = k + 1
    if (norm_dif < E_tolerance) then
        break
    end
end

residual_norm = norm(b - A*iter_x)

//endfunction



// Dois exemplos do Algoritmo de Jacobi -  basta retirar o comentário

// [iter_x,norm_dif,k,residual_norm] = jacobi_algorithm([2 1; 5 7],[11; 13],[1;1],0.0000001,1000)

// Os inputs do exemplo abaixo vem da matriz usada  livro do Poole

// [iter_x,norm_dif,k,residual_norm] = jacobi_algorithm([7 -1; 3 -5],[5; -7],[1;1],0.0000001,1000)

