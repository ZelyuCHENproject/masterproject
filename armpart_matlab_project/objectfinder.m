function [block_position_real0]=objectfinder(block_real_size,im,props)

    props_num=size(props,1);
    block_position_real0=ones(props_num,2);

    for num=1:props_num
        props(num).BoundingBox=floor(props(num).BoundingBox);
        a1=props(num).BoundingBox(1);
        a2=props(num).BoundingBox(2);
        a3=props(num).BoundingBox(3);
        a4=props(num).BoundingBox(4);
        matrix_image_block=im(a2:a2+a4,a1:a1+a3,:);
        
        r_image=double(matrix_image_block(:,:,1));
        g_image=double(matrix_image_block(:,:,2));
        b_image=double(matrix_image_block(:,:,3));
        
        [x_image,y_image]=find(r_image>=200 & g_image<=40 & b_image<=40);
        
        xy_image=[x_image y_image];

        [hypotenuse_block]=objectsizecompute(xy_image);


        Gain_real=floor(hypotenuse_block/(((block_real_size(1))^2+(block_real_size(1))^2))^0.5);

        block_centre=[floor(mean([a2:a2+a4])) floor(mean([a1:a1+a3]))];

        map_centre=floor([0.5*size(im,1) 0.5*size(im,2)]);
        
        block_position_real0(num,:)=(block_centre-map_centre)./Gain_real;
        
  
        
    end

    
end