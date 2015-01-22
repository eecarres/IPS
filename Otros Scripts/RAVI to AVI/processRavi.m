function processRavi(filename)

% Set the sizes of the video and initialize the matrix
imCols = 382;
imRows = 288;
frame = zeros(imRows,imCols);

% Retrieve the name of the video
[~,name,~] = fileparts(filename); 

% Initialize the video writer object
writerObj = VideoWriter([name,'.avi']);
open(writerObj);


raviData = fread(fopen(filename));

column = 0;
tic
for n = 1:size(raviData,1)-1
    
    if(raviData(n) == 0)
        column = column + 1;
    else
        column = 0;
    end
    if(column==676 && raviData(n+1)~=0)
        
        n = n + 1;
        for row = 1:imRows
                frame(row,:) = raviData(n:2:n+2*(imCols-1)) + 256*raviData(n+1:2:n+1+2*(imCols-1));
                n = n + 2*imCols;
        end
        
         %         minVideoValue(n)=min(min(frame));
        %         maxVideoValue(n)=max(max(frame));
        minValue=min(min(frame));
        maxValue=max(max(frame));
        frame= ( (frame- minValue) ) / (maxValue-minValue);
        %frame=histeq(frame);
        writeVideo(writerObj,frame);
        toc
    end
end

