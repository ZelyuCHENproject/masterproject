function [posefile,Hingeposefile]=armpose_computer(blockHeight,blockxy,Nn,put_position)
    
    save('arm_path_comp.mat','blockHeight','blockxy','Nn','put_position')

    run verse_arm_Rpick.m
    run verse_arm_Rput_mobile.m
    
    if tf0==0
        posefile=[];
        Hingeposefile=[];
        return
    else
        run verse_arm_R0.m
        run verse_arm_R1.m
        run verse_arm_R2.m
        run verse_arm_R3.m
        run verse_arm_R4.m

        % show(robot,R4);
        Rp34=R4(1).JointPosition;

        save('Rp_arm.mat','Rp0','Rp1','Rp12','Rp2','Rp23','Rp3','Rp34');
        Hingepose=[Rp0;Rp1;Rp12;Rp2;Rp23;Rp3;Rp34];

        save('Hingepose.mat','Hingepose')

        posefile='Rp_arm.mat';
        Hingeposefile='Hingepose.mat';
    end
end

% z0=[0 0 1];
%
% Vo54=point_joint(5,:)-point_joint(4,:);
%
% ang5z=acos(dot(Vo54,z0)/(norm(Vo54)*norm(z0)));

