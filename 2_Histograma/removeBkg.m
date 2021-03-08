% Se eliminar� el fondo bas�ndonos en los resultados obtenidos del histograma
% Podemos observar que el fondo maneja n�meros entre el 145 y 235
% Es por eso que lo eliminamos y ponemos el nuevo fondo blanco.

function im = removeBkg(im)
  for i=1:size(im)(1)
    for j=1:size(im)(2)
      if(im(i,j) >= 145 && im(i,j) <= 235 )
        im(i,j) = 255;
      endif  
    endfor
  endfor
endfunction
