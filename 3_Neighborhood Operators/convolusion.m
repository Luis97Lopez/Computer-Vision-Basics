function g = convolusion(im, h)
  width = size(im)(1);
  height = size(im)(2);
  
  im = double(im) ./ 255;
  
  g = zeros(width, height);
  for i=2:width - 1
    for j=2:height - 1
      sum = 0;
      for ii=-1:1
        for jj=-1:1
          sum += im(i+ii, j+jj) * h(ii + 2, jj + 2);
        endfor
      endfor
      g(i,j) = sum;
    endfor
  endfor
endfunction
