clear;
pkg load image;

% Leemos la imagen y la convertimos a gris
imO = imread('ejemplo.png');
imG = rgb2gray(imO);
[xx yy] = size(imG);



% Checamos el histograma para ver qué color es el fondo para eliminarlo
##imhist(imG);
  
% Eliminamos el fondo y lo hacemos negro
for i=1:xx
  for j=1:yy
    if(imG(i,j) > 190)
      imG(i,j) = 0;
    endif
  endfor
endfor


% Obtenemos una moneda para hacer el filtro
imRec = imcrop(imG, [55,84, 36,35]);
##imRec = imcrop(imG, [190,110, 100,35]);

% Hacemos el filtrado
imAns = imfilter(double(imG), double(imRec));

% Observamos la gráfica mesh
##mesh(imAns);

% Obtenemos los valores máximos
maxValue = max(imAns(:));

% Buscamos el valor máximo dentro de la imagen filtrada
[xMax, yMax] = find(imAns >= maxValue);

% Pintamos los vectores que tienen el valor máximo
for i=1:size(xMax)
  imG(xMax(i)-1:xMax(i)+1, yMax(i)-1:yMax(i)+1) = 255;
endfor

imshow(imG);
