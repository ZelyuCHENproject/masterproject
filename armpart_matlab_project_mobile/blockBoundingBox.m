function [im, props] = blockBoundingBox(matrix_image)

%% Reading image

im=matrix_image;

dd1=(im(:,:,1)>=200&im(:,:,2)<=40&im(:,:,3)<=40);
[m,n]=size(dd1);
z=zeros(m,n);

im=(cat(3,dd1,z,z));
im=im2uint8(im);
% imshow(im);



%% Binarisation
bin_threshold = 0.1; % parameter to vary

bin_im = im2bw(im, bin_threshold);
% imshow(bin_im);

%% Extracting connected components
con_com = bwlabel(bin_im);
% imshow(label2rgb(con_com));

%% Computing objects properties
props = regionprops(con_com);

%% Drawing bounding boxes
n_objects = numel(props);
 imshow(im);
 hold on;
for object_id = 1 : n_objects
    rectangle('Position', props(object_id).BoundingBox, 'EdgeColor', 'b');
end
 hold off;

end



