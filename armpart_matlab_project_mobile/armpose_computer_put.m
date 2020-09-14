function [posefile,Hingeposefile]=armpose_computer_put(blockHeight,blockxy,Nn,put_position)

        
        run verse_arm_R1_put.m
        run verse_arm_R2_put.m
        run verse_arm_R3_put.m
        run verse_arm_R4_put.m

        % show(robot,R4);
        Rp34=R4(1).JointPosition;

        save('Rp_arm_put.mat','Rp0','Rp1','Rp12','Rp2','Rp23','Rp3','Rp34');
        Hingepose=[Rp0;Rp1;Rp12;Rp2;Rp23;Rp3;Rp34];

        save('Hingepose_put.mat','Hingepose')

        posefile='Rp_arm_put.mat';
        Hingeposefile='Hingepose_put.mat';



end