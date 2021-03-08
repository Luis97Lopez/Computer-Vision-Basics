% UASLP     FACULTAD DE INGENIERÍA    VISIÓN COMPUTACIONAL
%             SLIT SCANNING
% Autor:        Luis Alberto López Romero
% Fecha:        3 de marzo del 2021
% Descripción:  El siguiente código realiza el proceso de Slit Scanning 
%               al video que le indiquemos.
%               Lo que se hace es tomar de cada Frame una barra de tamaño que 
%               se le indique (por default es 3) y pegar todas las barras en 
%               una imagen de tamaño:
%                   height X (numeroDeFrames * anchoDeLineas)

function slitScan()
  pkg load video;
  
  % Variables modificables
  archivoDeVideo = 'C:\Users\lopez\Desktop\Vision\Videos\prueba7.mp4';
  anchoDeLineas = 7;
  
  
  % Se lee el video y se obtienen los datos necesarios.
  videoObj            = VideoReader(archivoDeVideo);
  nFrames             = videoObj.NumberOfFrames;
  vidHeight           = videoObj.Height;
  vidWidth            = videoObj.Width;
  
  % La coordenadaX inicial donde se leerá cada barra de cada frame.
  % Caso default se escoge el pixel de la mitad del video.
  coordenadaX         = uint8(videoObj.Width*0.5);

  % Creamos el Arreglo de Frames del video.
  videoEntrada(1:nFrames) = struct('frame', zeros(vidHeight, vidWidth, 3, 'uint8'));
  
  % Leemos cada Frame uno por uno y lo almacenamos en nuestro arreglo de Frames.
  for iFrames = 1:nFrames
    videoEntrada(iFrames).frame = readFrame(videoObj);
  end
  
  % Creamos la matriz (imagen) que va a almacenar cada barra de cada frame.
  outputImg = repmat(zeros(vidHeight, anchoDeLineas, 3, 'uint8'), [1 nFrames]);
  
  % Calcula la posición de cada frame en la imagen final.
  leftIdx              = 1:anchoDeLineas:(anchoDeLineas*(nFrames));
  rightIdx             = leftIdx + anchoDeLineas;
  
  fprintf('Slit-scanning processing...\n');
  for lastFrame       = 1:nFrames;
    % Se copia la barra del frame actual dentro de la imagen de salida
    outputImg(:,leftIdx(lastFrame):rightIdx(lastFrame),:) = ...
         videoEntrada(lastFrame).frame(:, coordenadaX:coordenadaX+anchoDeLineas, :);
  end
  
  fprintf('Slit-scanning done!\n');
  
  figure('name', 'Split Scanning - LUIS ALBERTO LÓPEZ ROMERO');
  imshow(outputImg);

endfunction
