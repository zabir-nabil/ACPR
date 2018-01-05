% Constants
R_MIN = 8; % Minimum radius of circle for detection in imfindcircles()
R_MAX = 26; % Maximum radius of circle for detection in imfindcircles()

DRK_RNG = 50; % DARK / Black Threshold
RED_RAT = 1.5; % Red component ratio threshold

RNG_PXL = 8; % Pixel range to normaize

%GUI Code goes here

%----------------------------------------!!!!!!!!!!!!!!!!

% After reading one frame
copyFrame = imread('data3.jpg'); % Will be copied from baseFrame

extraCop = copyFrame;

% We need to convert it to gray from rgb

cF_RGB = rgb2gray(copyFrame);

% Now we will detect the edges [HPF]

cF_EDGE = edge(cF_RGB,'canny'); % canny works fine

% After edge detection we are ready to detect circles (carom seeds) using
% Hough transform

[centers, radii] = imfindcircles(cF_EDGE,[R_MIN R_MAX]); % Other parameters removed for now, as default behaviour is doing pretty good.

% We have saved all the centers and radii of the circles detected

n_circles = length(radii);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If n_circles = 0, we have to do something (Later)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Now we will mark these circles in the copied_Frame 

% As we want to process the circles one by one we will add new changes to
% already changed version

cF_ACM = copyFrame; % Copying again

for n_c = 1:n_circles % For all detected circles
    
    % Color detection by analyzing RGB components
    
    color_CRC;
   
    n_points = 0;
    
    cX = round(centers(n_c,1));
    cY = round(centers(n_c,2));
    
%     for npx = (cX - RNG_PXL:cX + RNG_PXL)
%         for npy = (cY - RNG_PXL:cY + RNG_PXL)
%             R_component = R_component + copyFrame(npx,npy,1);
%             G_component = G_component + copyFrame(npx,npy,2);
%             B_component = B_component + copyFrame(npx,npy,3);
%             
%             n_points = n_points + 1;
%             
%         end
%     end
    
    % Normalizing / Averaging
    
    R_component = extraCop(cY,cX,1) %= R_component/n_points;
    G_component = extraCop(cY,cX,2) %= G_component/n_points;
    B_component = extraCop(cY,cX,3) %= B_component/n_points;
    
    
    % Too dark
    
    if (R_component <= DRK_RNG && G_component <= DRK_RNG && B_component <= DRK_RNG)
        color_CRC = 'Balck';
    % Red color
    elseif (R_component/G_component > RED_RAT && R_component/B_component > RED_RAT)
        color_CRC = 'Red';
    % By default White color
    else
        color_CRC = 'White';
    end
    
    
    
    
    % color_CRC = get_COL(cF_ACM, centers(n_c:n_c,:)); % Sending the center of current circle
    
    
   
    % Drawing the circles in the locations where we detected
    
    idx = num2str(n_c);

    
    cF_ACM = insertText(cF_ACM,[centers(n_c,1) centers(n_c,2)],['Color ' idx ': ' color_CRC]);
    
    % Accumulator Effect
    
    cF_ACM = insertShape(cF_ACM,'circle',[centers(n_c,1) centers(n_c,2) radii(n_c)]);
    
    copyFrame = cF_ACM;
end

figure(1), imshow(copyFrame); % title('Visual System')



    
    
    
     