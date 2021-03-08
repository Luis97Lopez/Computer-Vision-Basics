function im = meanSustractor(im)
  for i=2:size(im)(1) - 1
    for j=2:size(im)(2) - 1
      sum = zeros(3,3);
      for ii=-1:1
        for jj=-1:1
          sum(2 + ii, 2 + jj) = im(i+ii, j+jj);
        endfor
      endfor
      im(i,j) -= mean(mean(sum));
    endfor
  endfor
endfunction
