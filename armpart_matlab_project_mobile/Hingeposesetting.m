      
        l1=0; % speed for first top wheel
        r1=0; % speed for first bottom wheel
        l2=0; % speed for second top wheel
        r2=0; % speed for second bottom wheel
        l3=0; % speed for third top wheel
        r3=0; % speed for third bottom wheel

        Hingepos1=Hingepose(2); %first hinge
        Hingepos2=Hingepose(4); %second hinge
        Hingepos3=Hingepose(6); %third hinge
        % wheels
        Hingepos1_l=0; %first top wheel
        Hingepos1_r=Hingepose(1); %first bottom wheel
        Hingepos2_l=0; %second top wheel
        
        Hingepos2_r=Hingepose(3); %second bottom wheel
        Hingepos3_l=Hingepose(7); %third top wheel
        Hingepos3_r=Hingepose(5); %third bottom wheel
        

        motorForce=200;
        upper_limit_j=100*pi/180;