function im = gammaCorrector(im, gamma)
  im = double(im);
  im ./= 256;
  im .^= gamma;
  im .*=256;
  im = uint8(im);
end