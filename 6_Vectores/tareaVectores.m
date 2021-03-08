% UASLP     FACULTAD DE INGENIERÍA    VISIÓN COMPUTACIONAL
%             VECTORES
% Autor:        Luis Alberto López Romero
% Fecha:        8 de marzo del 2021
% Descripción:  El siguiente código realiza el proceso base de vectores.
%               Primero se crea una imagen muestra con 4 objetos. 
%               3 del mismo tipo y otro diferente con menos intensidad. 
%               Lo que realiza el algoritmo es obtener los objetos con mayor 
%               intensidad y almacenándolos en una estructura vector.

  pkg load image;
  
  f = zeros(31,31);
  g = zeros(31,31);
    
  [n,m] = size(f);
  
  % Objeto1
  f(5:7, 10:12) = 1;
  f(6,11) = 0;
  
  % Objeto2
  f(15:17, 20:22) = 1;
  f(16,21) = 0;
  
  % Objeto3
  f(20:22, 6:8) = 1;
  f(21,7) = 0;  
  
  %Objeto no deseado
  f(25:27, 20:20) = 1;
  f(26:26, 19:21) = 1;
  f(26,20) = 0;
  
  % Filtro a usar: Lleno de unos.
  filtro = ones(3);
  filtro(2,2) = 0;

  % Se aplica el filtro a nuestra imagen de salida G.
  g = imfilter(f, filtro); 
  
  % Obtenemos el valor máximo de nuestra imagen filtrada
  value = max(max(g));
  
  % Obtenemos los puntos máximos en la imagen G.
  [xMax, yMax] = find(g == value);
  
  % A partir de los puntos máximos obtenemos el número de vectores
  nVectors = size(xMax)(1);
  
  % Variable para determinar de qué tamaño vamos a recortar la imagen.
  cropSize = 2;

  % Creamos una estructura de vectores que almacenará el punto superior izq
  % de nuestro vector y también la matriz con las intensidades.
  vectors(1:nVectors) = struct('point', zeros(1,2), ...
                                'matrix', zeros(cropSize*2 +1));
  
  for i=1: nVectors
    % Obtenemos el punto 
    vectors(i).point = [yMax(i) - cropSize, xMax(i) - cropSize];
    
    % Obtenemos la matriz de intensidades
    vectors(i).matrix = imcrop(f, 
          [vectors(i).point(1),vectors(i).point(2), cropSize *2, cropSize *2]);
  endfor
 
