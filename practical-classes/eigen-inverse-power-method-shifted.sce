function [lambda,eigen_vec] = Metodo_pot_desloc_inv(A,initial_vector,epsilon,alfa)
    
    [row_num,col_num] = size(A)
    
    I = eye(row_num,col_num)
    
    //parte crucial do método, redefinindo a matriz A 
    //A passa a ser A menos o produto de alfa vezes a matriz identidade
    A = A - (alfa*I)
     
    //fazer a inversa de A
    //decidi não seguir pelo caminho da eliminação gaussiana
    A = inv(A)
    
    x_iter = initial_vector
    
    y_iter = initial_vector
    
    //procedimento semelhante ao método da potência, no entanto, uso a inversa
    x_iter = A*y_iter
    
    y_iter = x_iter
    
    diff_y = 1;
    
    //contador de iterações
    iterations_num = 1
    
    while (diff_y>epsilon)
        
        old_y = norm((y_iter),1);
    
        x_iter = A*y_iter
        
        [max_abs_val, index] = max(abs(x_iter));
        
        m = x_iter(index)
        
        //scaling method para evitar integrer overflow        
        y_iter = (1/m)*x_iter
        
        new_y = norm((y_iter),1);
        
        diff_y = abs(new_y - old_y)
        
        iterations_num = iterations_num + 1;
        
    end

    // parte crucial do método "shifted inverse power"
    //a variável M que o processo iterativo irá quando chegar no equilíbrio não é o autovalor desejado
    //é preciso fazer a manipulação abaixo para chegar no valor correto de Lambda
    lambda = alfa + 1/(m)
    
    //a variável de estado y_iter, no equilíbrio, será o auto-vetor associado ao auto-valor encontrado
    eigen_vec = (y_iter)
    
    disp(iterations_num, "número de iterações ")

    disp("  ")
    
    disp(alfa, "alfa ")
    
    disp("  ")

endfunction

epsilon = 8.882D-16;

A_poole_1 = [1 1; 2 0];

initial_vector_1 = [1; 0];

[lambda,eigen_vec] =  Metodo_pot_desloc_inv(A_poole_1, initial_vector_1, epsilon,-2)
