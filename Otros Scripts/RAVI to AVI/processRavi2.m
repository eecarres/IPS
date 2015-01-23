function processRavi2(maxTemp,filename)


initialMaxTemp=maxTemp;
% Set the sizes of the video and initialize the matrix
imCols = 382;
imRows = 288;
frame = zeros(imRows,imCols);


% Retrieve the name of the video
[path,name,~] = fileparts(filename); 

% Initialize the video writer object
writerObj = VideoWriter([path,'\AVI_2\',name,'.avi']);
writerObj.FrameRate = 20;
open(writerObj);

tempChanged = 0;

raviData = fread(fopen(filename));
column = 0;

N = length(raviData)-1;
x = 1;
tic
for n = 1:N
    if(raviData(n) == 0)
        column = column + 1;
    else
        column = 0;
    end
    if(column==676 && raviData(n+1)~=0)
        n= n + 1;
        for i = 1:imRows
            for j = 1:imCols
                ind = n + 2*(j-1)+2*imCols*(i-1);
                num = raviData(ind) + 256*raviData(ind+1);
                if(num>54038)
                    frame(i,j) = num*343/11960 - 1822.9;
                else
                    frame(i,j) = num*204/12337 + 55.3867;
                    if(frame(i,j)>124.9)
                       frame(i,j) = 124.9;
                    end
                end
            end
        end
        
        M(:,:,x) = frame;
        x = x + 1;
        n = n + 2*imCols*imRows;
        
        if(n>length(raviData))
            return
        end
        
%     minValue=min(min(frame));
         maxValue=max(max(frame));
        if maxValue>maxTemp
            maxTemp=maxValue;
            tempChanged=1;
        elseif maxValue  < initialMaxTemp
            
                maxTemp=initialMaxTemp;
         elseif maxValue  < maxTemp
            
               maxTemp=maxTemp;
        end
        % Evita menores que 0
        frame(find(frame<0))=0;
        
        % Restringe los valores a 0-1
        frame= frame/maxTemp;
        
        writeVideo(writerObj,frame);
        
        
    end
   
end
toc
close(writerObj);
if tempChanged==1
    disp(['Max temp has changed to ', int2str(maxValue)]);
end
end