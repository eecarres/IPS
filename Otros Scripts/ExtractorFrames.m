   inpath=('Sabadell 1.ravi');
   myVid= VideoReader(inpath);
   numFrames= myVid.NumberOfFrames;
   i= 2000;
   while i<= numFrames
   currentFrame= read(myVid,i); 
   combinedString=strcat(int2str(i-1),'.jpg');
   imshow(currentFrame);
   imwrite(currentFrame,combinedString);
   i=i+1;
   end
   