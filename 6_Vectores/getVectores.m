function vectors = getVectores(im, f)
  % Variable para determinar de qué tamaño vamos a recortar la imagen.
  cropSize = 30;
  
  [n,m] = size(im);
  
  % Filtramos la imagen
  g = imfilter(im, f);
  
  % Obtenemos el valor máximo de nuestra imagen filtrada
  value = max(max(g));
  
  % Obtenemos los puntos máximos en la imagen G.
  [xMax, yMax] = find(g == value);
  
  % A partir de los puntos máximos obtenemos el número de vectores
  nVectors = size(xMax)(1)
  
  % Creamos una estructura de vectores que almacenará el punto superior izq
  % de nuestro vector y también la matriz con las intensidades.
  vectors(1:nVectors) = struct('point', zeros(1,2), ...
                                'matrix', zeros(cropSize*2 +1));
  
  figure;
  
  for i=1: 1
    % Obtenemos el punto 
    vectors(i).point = [yMax(i) - cropSize, xMax(i) - cropSize];
    
    % Obtenemos la matriz de intensidades
    vectors(i).matrix = imcrop(im, 
          [vectors(i).point(1),vectors(i).point(2), cropSize *2, cropSize *2]);
          
    subplot(1,1, i), imshow(vectors(i).matrix);
  endfor
endfunction
