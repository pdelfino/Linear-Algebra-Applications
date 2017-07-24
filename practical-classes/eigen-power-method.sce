//minha função vai precisar receber A, initial_vector

A_poole_1 = [1 1; 2 0]

A_poole_2 = [0 5 -6; -4 12 -12; -2 -2 10]

initial_vector_1 = [1; 0]

initial_vector_2 = [1; 1; 1]

epsilon = 8.882D-16

function [eigen_val_dom,eigen_vect_dom] = Metodo_potencia(A,initial_vector,epsilon)
    
    //a variável x atua como variável de estado variando seu valor a cada iteração
    x_iter = A*initial_vector
    
    //a variável y atua como variável de estado para efetivar o método do "Scaling"
    //com um escalar M sendo usado para manter os vetores com valores pequenos
    //evitando integrer overflow
    y_iter = initial_vector
    
    //contador de iterações
    iterations_num = 1
    
    // diif_y é uma variável para representar a diferença yk - y(k-1)
    diff_y = 1

    while (diff_y>epsilon)
        //guardar o valor de yk antes da iteração    
        old_y = norm((y_iter),1);
        
        //encontrar o índice do maior valor absoluto
        [max_abs_val, index] = max(abs(x_iter));

        //definir m como o maior valor absoluto preservando o seu sinal
        //se o maior número em módulo for NEGATIVO, a variável m precisa ser negativa
        m = x_iter(index);
        
        //criar o valor de y usando o método chamado de scaling
        y_iter = (1/m)*x_iter;

        x_iter = A*y_iter;
        
        //guardar o novo valor de Y após a iteração
        new_y = norm((y_iter),1);

        //fazer a diferença entre yk - y(k-1), quando essa diferença for muito pequena
        //é um sinal que a aproximação do auto-valor está boa o suficiente
        diff_y = abs(new_y - old_y);

        //contar o número de iterações
        iterations_num = iterations_num + 1;

end

    //o m representa o auto-valor dominante
    eigen_val_dom = m
    
    //quando a aproximação já é boa o suficiente, a variáveld de estado com as iterações de x
    //irá guardar o auto-velor referente ao auto-valor dominante 
    eigen_vect_dom = x_iter

endfunction

A_poole_1 = [1 1; 2 0];

initial_vector_1 = [1; 0];

A_poole_2 = [0 5 -6; -4 12 -12; -2 -2 10]

initial_vector_2 = [1; 1; 1]

[lambda,v] = Metodo_potencia(A_poole_2,initial_vector_2,epsilon)

