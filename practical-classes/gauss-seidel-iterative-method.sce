
function [iter_x,norm_dif,k,residual_norm] = gauss_seidel_algorithm(A,b,x_zero,E_tolerance,M)

L = tril(A)

U = triu(A) //U preliminar, precisa ter sua diagonal zerada

[nRows,nCols] = size(A)

U(1:(nRows+1):nRows*nCols) = 0

// A == L+U; teste para  checar se a separação foi correta

L_inverse = inv(L)

t_matrix = (-1)*L_inverse*U

c_matrix = L_inverse*b

iter_x = x_zero

k = 1

while ( k <= M ) //M é a variável de input c/ maximo de iterações
   
    iter_x_previous = iter_x
    iter_x = t_matrix*iter_x_previous + c_matrix
    k = k + 1
    norm_dif = norm(iter_x - iter_x_previous)
    if (norm_dif < E_tolerance) then
        break
        end
end

residual_norm = norm(b - A*iter_x)

endfunction

// Um exemplo com o código abaixo - basta retirar comentários

//[iter_x,norm_dif,k,residual_norm] = gauss_seidel_algorithm([16 3; 7 -11],[11; 13],[1;1],0.0000001,100)

// Outro exemplo baseado na figura 2.31 do Poole

//gauss_seidel_algorithm([4 -1 0; -1 4 -1; 0 -1 4], [250; 50; 200], [0;0;0],0.0000001, 1000)
