///////////// A função que faz a eliminação Gaussiana será chamada na Least Square

function v = Gaussian_Elimination_4(A, b)

    [n, n] = size(A); 
        
    [n, m] = size(b);
    
    v = zeros(n,m);
    
    for e = 1:n-1
        m = -A(e+1:n,e)/A(e,e); 
        A(e+1:n,:) = A(e+1:n,:) + m*A(e,:);
        b(e+1:n,:) = b(e+1:n,:) + m*b(e,:);
    end;
    
    v(n,:) = b(n,:)/A(n,n);
    
    for e = n-1:-1:1
        v(e,:) = (b(e,:) - A(e,e+1:n)*v(e+1:n,:))/A(e,e);
    end

endfunction

///////////// Limpar a plotagagem anterior com clf, se não dá pau

clf

///////////// Inputar os pontos em que o Método será aplicado e o grau do poli

pontos = [];

for i=0.1:0.1:6.2;
    pontos = [pontos; i,cos(i)]; poli_power = 4 // ISSO VAI VARIAR P/ CADA EXERCÍCIO
end;

poli_power = 4 // ISSO VAI VARIAR PARA CADA EXERCÍCIO - SÓ UM EXEMPLO

///////////////////////////////////////////////////////////////////////////////

///////////// Função Least Square Approx
///////////// Eu quero que ela retorne os novos pontos

function new_points = Least_Square_Approx(pontos,poli_power)
    
    ///////////// Separar as ordenadas e as abcissas dos pontos inputados
    
    X_coor = pontos(:,1);
    
    Y_coor = pontos(:,2);
    
    ///////////// Construção da Matrix A -  encontrar o seu tamanho
    
    [n_row,n_col]=size(pontos);
    
    ///////////// O Vetor b pega a última coluna da matriz Pontos
    
    vector_b = pontos(:,n_col);
    
    // A primeira coluna da Matriz é formada apenas por dígitos 1
    
    A_matrix_first_col = ones(n_row,1);
    
    //Da segunda coluna em diante fica complicado e precisa do grau do poli
    
    // Cria uma matriz vazia que, em breve, será apenada
    
    A_matrix = [];
    
    A_matrix = [A_matrix_first_col,A_matrix];
    
    for i= 1:poli_power;
        A_matrix = [A_matrix,X_coor.^i];
    end;
    
    ///////////// Encontrar a transposta de A
    
    transpose_A_matrix = (A_matrix)';
    
    ///////////// O produto entre A-transposta e A
    
    prod_A_trans_A = transpose_A_matrix*A_matrix;
    
    ///////////// O produto entre A-transposta e o vetor b
    
    prod_A_trans_b = transpose_A_matrix*vector_b;
    
    ///////////// Usar esses produtos como inputs para a Eliminação Gaussiana
    
    A_gauss = prod_A_trans_A;
    
    b_gauss = prod_A_trans_b;
    
    ///////////// Retorna os Coeficientes
    
    coef = Gaussian_Elimination_4(A_gauss,b_gauss);
    
    ///////////// Novos pontos gerados pelo meu polinômio de aproximação
    
    new_points = A_matrix*coef;
        
    disp("Imprimir na tela do Console o coeficiente e o grau do polinômio")
    disp("coef",coef)
    disp("poli_power",poli_power)
    
endfunction

///////////// Plotar os antigos pontos em um asterisco vermelho
///////////// Plotar os novos pontos gerado pela minha aproximação em bolinhas azuis
//////////// Plotar uma linha em AZUL unindo os pontos gerados pela minha aproximação

new_points = Least_Square_Approx(pontos,poli_power);

plot(pontos(:,1), new_points(:, 1), "ob-" );

plot(pontos(:,1), pontos(:, 2), "*r" );

a = gca();

a.data_bounds = [min(pontos, 'r') - 3; max(pontos, 'r') + 3];


