function lenna_up = rotate(A)
   
    close
    clear
    clc
  
    m=512;
    n=512;
    A_t=A';
        
    x=[1:m];
    y=[1:n];
    xy = [x;y];
    
    //esse comando faz a imagem rotacionar 90°, o descobri pesquisando a documentação
//fiz algo semelhante ao ex da documentação 
    xy_rot = rotate(xy,%pi);
    
    new_x = xy_rot(1,:);

    new_y = xy_rot(2,:);
    
    xset("colormap",graycolormap(256));

    xy = [x;y];
 
    //mesmo colocando 90 como argumento da built-in rotate() eu não fazer a imager rotacionar 90°
    //para que o código funcionasse eu fiz a tranposta da matriz e depois apliquei o rotate()
    //isso funcionou, consegui a imagem como eu queria, no entanto, confesso que foi uma "gambiarra"

    xset("colormap",graycolormap(256));
    isoview(0,512,0,512)
    lenna_up = grayplot(new_x,new_y, A');
    
endfunction

K=read("lena.csv",m,n);

rotate(K)
