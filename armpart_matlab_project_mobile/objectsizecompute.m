function [hypotenuse_block]=objectsizecompute(xy_image)

    for i=1:size(xy_image,1)
        for j=1:size(xy_image,1)
            distanceall(j,:)=abs(norm(xy_image(i,:)-xy_image(j,:)));
        end
            distancemax(i,:)=max(distanceall(find(distanceall~=0)));  
    end
    
    hypotenuse_block=max(distancemax);
    

end