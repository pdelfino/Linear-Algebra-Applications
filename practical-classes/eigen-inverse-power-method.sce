
function [lambda_min,eigen_vec_min] = Metodo_potencia_Inverso(A,initial_vector,epsilon)
    
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

    //ponto crucial no código - eu demorei a perceber inclusive
    //a variável M no contexto desse código NÃO é o LAMBDA - autovalor
    // na verdade o lambda é 1/m . Assim, preciso elevar ao expoente de -1
    //fazendo isso vou obter o AUTOVALOR MÍNIMO DESSA MATRIZ
    lambda_min = (m)**(-1)
    
    // o Autovetor correspondente ao MENOR autor-valor
    eigen_vec_min = y_iter
    
    disp(iterations_num, "número de iterações ")
    
endfunction

epsilon = 8.882D-16;

A_poole_2 = [0 5 -6; -4 12 -12; -2 -2 10];

initial_vector_2 = [1; 1; 1];

[lambda_min,eigen_vec_min] = Metodo_potencia_Inverso(A_poole_2, initial_vector_2, epsilon)
