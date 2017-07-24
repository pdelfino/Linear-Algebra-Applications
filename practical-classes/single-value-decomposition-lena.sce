//a função recebe A, a matrix que representa a imagem e o parâmetro p
//o parâmetro p indica o percentual de valores positivos
//quanto maior esse percentual mais nítida é a imagem

function compressed_image=compress_im(A,b)
    //para limpar o "canvas" vou limpar o ambiente da imagem anterior
    // os comandos abaixo fazem isso e limpam o terminal
    close
    clear
    clc

    //chamo a função SVD em relação à matrix A
    //ela será "fatorada" em U,S e V
    [U,S,V]= svd(A)
    
    [row,col] = size(U);
    
    //faço uma contagem dos valores singulares positivos de A
    r = 0;
    for j=1:row //vou iterar em todas as linhas de U
        if U(j,j)>0 //cada elemento positivo da diagonal de U será contado
            r = r + 1;
        end 
    end
    //num de valores positivos - percentual vezes r total
    post_num = p*r;
    
    s = post_num
    //organizando as partes necessárias para o comando do enunciado que
    // irá encerrar a função de compressão
    U_part = U(:,1:s);
    S_part = S(1:s,1:s);
    V_t = V';
    V_t_part= V_t(1:s,:);
    
    compressed_image=U_part*S_part*V_t_part
    
endfunction

function A = visualization(A_matrix)
    
    A = A_matrix;
    m=512;
    n=512
    x=[1:m]
    y=[1:n]
    xset("colormap",graycolormap(256))
    isoview(0,512,0,512)
    disp_image = grayplot(x, y, A);
    
endfunction

A = read("lena.csv",m,n);
p=0.05;
K = compress_im(A,p);

//vou chamar a função visualização para "imprimir" a imagem comprimida
visualization(K);
