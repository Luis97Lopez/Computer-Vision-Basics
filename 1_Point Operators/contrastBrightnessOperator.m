function im = contrastBrightnessOperator(im, ct, br)
  im .*= ct;
  im .+= br;
  mod(im, 256);
end