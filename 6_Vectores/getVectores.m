function vectors = getVectores(im, f)
  % Variable para determinar de qu� tama�o vamos a recortar la imagen.
  cropSize = 30;
  
  [n,m] = size(im);
  
  % Filtramos la imagen
  g = imfilter(im, f);
  
  % Obtenemos el valor m�ximo de nuestra imagen filtrada
  value = max(max(g));
  
  % Obtenemos los puntos m�ximos en la imagen G.
  [xMax, yMax] = find(g == value);
  
  % A partir de los puntos m�ximos obtenemos el n�mero de vectores
  nVectors = size(xMax)(1)
  
  % Creamos una estructura de vectores que almacenar� el punto superior izq
  % de nuestro vector y tambi�n la matriz con las intensidades.
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
