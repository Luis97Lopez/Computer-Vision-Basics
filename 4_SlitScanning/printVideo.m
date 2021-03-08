function printVideo(r)
  im = [];
  while (r.hasFrame())
   img = readFrame (r);
   if (isempty (im))
     im = image (img);
     axis off;
   else
     
     set (im, "cdata", img);
     img, im
   endif
   drawnow
 endwhile
endfunction
