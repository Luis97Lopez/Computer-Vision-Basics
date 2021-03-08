function printAnimation(imgs)
  im = [];
  for i=1:size(imgs)(2)
   img = imgs(1,i).cdata;
   if (isempty (im))
     im = image (img);
   else
     set (im, "cdata", img);
   endif
   pause(0.03);
   drawnow
 endfor
endfunction