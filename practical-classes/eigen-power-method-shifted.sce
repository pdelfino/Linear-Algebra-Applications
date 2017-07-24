
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


function [lambda_1,v_1,lambda_2,v_2] = Metodo_potencia_deslocad(A,initial_vector,epsilon)

    //eu uso a função do exercício 1 para encontrar o AUTO VALOR DOMINANTE
    //Além disso, uso a função para achar o auto vetor relacionado a esse autor valor dominante
    [lambda_1,v_1] = Metodo_potencia(A,initial_vector,epsilon)
    
    [A_row_num,A_col_num] = size(A)
    
    //crio uma matriz identidade com dimensão nxn igual à matriz A recebida
    identity_matrix= eye(A_row_num,A_col_num)
    
    //multiplico o auto valor DOMINANTE pela matrix identidade
    lambda_times_I = lambda_1*(identity_matrix)
    
    //faço a subtração de A pelo produto acima
    A = A - lambda_times_I
    
    //dou início ao primeiro valor da variável de estador x_iter
    x_iter = A*initial_vector
    
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
    
    //aqui entra algo diferente
    //lambda_2 será o valor do auto valor dominante mais o ESCALAR M do método scaling
    lambda_2 = lambda_1 + m
    
    //o segundo auto_vetor será o vetor Y iterativo após a estabilização
    v_2 = y_iter
    
endfunction

epsilon = 8.882D-16;

A_poole_2 = [0 5 -6; -4 12 -12; -2 -2 10]
    
initial_vector_2 = [1; 1; 1]
    
[lambda_1,v_1,lambda_2,v_2] = Metodo_potencia_deslocad(A_poole_2,initial_vector_2,epsilon)

