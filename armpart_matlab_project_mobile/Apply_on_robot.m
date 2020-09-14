
    if l1==0
        vrep.simxSetObjectIntParameter(clientID,robt1_lw,2001,1,vrep.simx_opmode_blocking);
        vrep.simxSetObjectFloatParameter(clientID,robt1_lw,2017,upper_limit_j,vrep.simx_opmode_blocking);
    else
        vrep.simxSetObjectIntParameter(clientID,robt1_lw,2001,0,vrep.simx_opmode_blocking);
    end
    
    if l2==0
        vrep.simxSetObjectIntParameter(clientID,robt2_lw,2001,1,vrep.simx_opmode_blocking);
        vrep.simxSetObjectFloatParameter(clientID,robt2_lw,2017,upper_limit_j,vrep.simx_opmode_blocking);
    else
        vrep.simxSetObjectIntParameter(clientID,robt2_lw,2001,0,vrep.simx_opmode_blocking);
    end
    
    if l3==0
        vrep.simxSetObjectIntParameter(clientID,robt3_lw,2001,1,vrep.simx_opmode_blocking);
        vrep.simxSetObjectFloatParameter(clientID,robt3_lw,2017,upper_limit_j,vrep.simx_opmode_blocking);
    else
        vrep.simxSetObjectIntParameter(clientID,robt3_lw,2001,0,vrep.simx_opmode_blocking);
    end
    
    if r1==0
        vrep.simxSetObjectIntParameter(clientID,robt1_rw,2001,1,vrep.simx_opmode_blocking);
        vrep.simxSetObjectFloatParameter(clientID,robt1_rw,2017,upper_limit_j,vrep.simx_opmode_blocking);
    else
        vrep.simxSetObjectIntParameter(clientID,robt1_rw,2001,0,vrep.simx_opmode_blocking);
    end
    
    if r2==0
        vrep.simxSetObjectIntParameter(clientID,robt2_rw,2001,1,vrep.simx_opmode_blocking);
        vrep.simxSetObjectFloatParameter(clientID,robt2_rw,2017,upper_limit_j,vrep.simx_opmode_blocking);
    else
        vrep.simxSetObjectIntParameter(clientID,robt2_rw,2001,0,vrep.simx_opmode_blocking);
    end
    
    if r3==0
        vrep.simxSetObjectIntParameter(clientID,robt3_rw,2001,1,vrep.simx_opmode_blocking);
        vrep.simxSetObjectFloatParameter(clientID,robt3_rw,2017,upper_limit_j,vrep.simx_opmode_blocking);
    else
        vrep.simxSetObjectIntParameter(clientID,robt3_rw,2001,0,vrep.simx_opmode_blocking);
    end
    
    
    %% speed
    vrep.simxSetJointTargetVelocity(clientID,robt1_lw,l1,vrep.simx_opmode_blocking);
    vrep.simxSetJointTargetVelocity(clientID,robt1_rw,r1,vrep.simx_opmode_blocking);
    vrep.simxSetJointTargetVelocity(clientID,robt2_lw,l2,vrep.simx_opmode_blocking);
    vrep.simxSetJointTargetVelocity(clientID,robt2_rw,r2,vrep.simx_opmode_blocking);
    vrep.simxSetJointTargetVelocity(clientID,robt3_lw,l3,vrep.simx_opmode_blocking);
    vrep.simxSetJointTargetVelocity(clientID,robt3_rw,r3,vrep.simx_opmode_blocking);
    
    %% gripper
    
    vrep.simxSetJointForce(clientID,robt_gripper,motorForce,vrep.simx_opmode_blocking);
    vrep.simxSetJointTargetVelocity(clientID,robt_gripper,motorVelocity,vrep.simx_opmode_blocking);
    
    
    %% pose
     % wheels
     
     
    vrep.simxSetJointTargetPosition(clientID,robt3_lw,Hingepos3_l,vrep.simx_opmode_blocking);
    
    
    vrep.simxSetJointTargetPosition(clientID,robt1_lw,Hingepos1_l,vrep.simx_opmode_blocking);
    vrep.simxSetJointTargetPosition(clientID,robt1_rw,Hingepos1_r,vrep.simx_opmode_blocking);
     
    vrep.simxSetJointTargetPosition(clientID,robt2_lw,Hingepos2_l,vrep.simx_opmode_blocking);
    vrep.simxSetJointTargetPosition(clientID,robt2_rw,Hingepos2_r,vrep.simx_opmode_blocking);
     
    vrep.simxSetJointTargetPosition(clientID,robt3_rw,Hingepos3_r,vrep.simx_opmode_blocking);
    
    pause(7)
    vrep.simxSetJointTargetPosition(clientID,robt2_pose,Hingepos2,vrep.simx_opmode_blocking);
    pause(2)
    vrep.simxSetJointTargetPosition(clientID,robt1_pose,Hingepos1,vrep.simx_opmode_blocking);
    vrep.simxSetJointTargetPosition(clientID,robt3_pose,Hingepos3,vrep.simx_opmode_blocking);


    



    

    