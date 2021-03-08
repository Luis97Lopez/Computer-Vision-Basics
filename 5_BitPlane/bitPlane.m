% UASLP     FACULTAD DE INGENIERÍA    VISIÓN COMPUTACIONAL
%             BIT PLANE SLICING
% Autor:        Luis Alberto López Romero
% Fecha:        3 de marzo del 2021
% Descripción:  El siguiente código realiza el proceso de Bit Plane Slicing  
%               a la imagen que se le indique.
%               Lo que realiza es calcular una imagen nueva a partir 
%               del número de bit. Más información del algoritmo en:
%               https://medium.com/@Dispersed_Knowl/bit-plane-slicing-for-discovery-c8d04ce1b142

function bitPlane()
  pkg load image;
  
  % Leer imagen
  im = imread('C:\Users\lopez\Desktop\Vision\Imagenes\llaves.jpg');
  
  % Modificamos la imagen a escala de grises
  im = rgb2gray(im);
  
  % Obtenemos tamaños
  [n m] = size(im);
  
  % Imprimimos la imagen original y las 8 modificaciones en una misma figura.
  figure('name', 'Bit Plane Slicing - LUIS ALBERTO L�PEZ ROMERO');

  subplot(2,5,1), imshow(im);
  
  for i=8:-1:1
    % Obtenemos la matriz Binaria del bit más significativo al menos significativo.
    B = bitget(im,i);
    subplot(2,5,8-i+2), imshow(B);
  end
  
endfunction
