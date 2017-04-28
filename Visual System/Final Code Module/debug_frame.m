function [] = debug_frame( centers, radii, circle_type )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n_circles = length(radii);
[striker_rad,striker_idx] = max(radii);
disp('Carom seeds LOCATION (*scaledMatrix)\n');
for nc = 1:n_circles
    if(nc==striker_idx)
        disp('STRIKER ');
    end
    if(circle_type(nc)==1)
        disp('Black seed: ');
        fprintf('Center : %f %f  Radius: %f\n',centers(nc,1),centers(nc,2),radii(nc));
    elseif(circle_type(nc)==2)
        disp('Red seed: ');
        fprintf('Center : %f %f  Radius: %f\n',centers(nc,1),centers(nc,2),radii(nc));
    else
        disp('White seed: ');
        fprintf('Center : %f %f  Radius: %f\n',centers(nc,1),centers(nc,2),radii(nc));
    end
end


disp('Preparing Moves');

fprintf('Move striker from (%f, %f) to CALIBATRED point (*scaledMatrix)\n',centers(striker_idx,1),centers(striker_idx,2));

