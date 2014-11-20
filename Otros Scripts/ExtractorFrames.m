   inpath=('2014_10_22_14_28_56.wmv');
   myVid= VideoReader(inpath);
   numFrames= myVid.NumberOfFrames;
   i= 1;
   while i<= numFrames
   currentFrame= read(myVid,i); 
   combinedString=strcat(int2str(i-1),'.jpg');
   imwrite(currentFrame,combinedString);
   i=i+1;
   end
   