   inpath=('Amunt.ravi');
   myVid= VideoReader(inpath);
   numFrames= myVid.NumberOfFrames;
   i= 2000;
   while i<= numFrames
   currentFrame= read(myVid,i); 
   combinedString=strcat(int2str(i-1),'.jpg');
   combinedStringA=strcat(int2str(i-1),'A.jpg');
   combinedStringB=strcat(int2str(i-1),'B.jpg');
   combinedStringC=strcat(int2str(i-1),'C.jpg');
   currentFrame=double(currentFrame);
   imIR=currentFrame(:,:,1) + currentFrame(:,:,2) + currentFrame(:,:,3);
   %    imshow(currentFrame);
   imIR=uint8((2^8).*(imIR/max(max(imIR)))); % pasamos a uint8
   imwrite(imIR,combinedString);
    imwrite(currentFrame(:,:,1),combinedStringA);
    imwrite(currentFrame(:,:,2),combinedStringB);
    imwrite(currentFrame(:,:,3),combinedStringC);
   i=i+1;
   end
   