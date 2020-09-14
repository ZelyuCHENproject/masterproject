%% path


    [res,bottom]=vrep.simxGetObjectHandle(clientID,'Bottom',vrep.simx_opmode_blocking);
    
    


    
%% block

[res,block1_c]=vrep.simxGetCollisionHandle(clientID,'Collision1',vrep.simx_opmode_blocking);
[res,block2_c]=vrep.simxGetCollisionHandle(clientID,'Collision2',vrep.simx_opmode_blocking);
[res,block3_c]=vrep.simxGetCollisionHandle(clientID,'Collision3',vrep.simx_opmode_blocking);
[res,block4_c]=vrep.simxGetCollisionHandle(clientID,'Collision4',vrep.simx_opmode_blocking);
[res,block5_c]=vrep.simxGetCollisionHandle(clientID,'Collision5',vrep.simx_opmode_blocking);
[res,block6_c]=vrep.simxGetCollisionHandle(clientID,'Collision6',vrep.simx_opmode_blocking);
[res,block7_c]=vrep.simxGetCollisionHandle(clientID,'Collision7',vrep.simx_opmode_blocking);
[res,block8_c]=vrep.simxGetCollisionHandle(clientID,'Collision8',vrep.simx_opmode_blocking);
[res,block9_c]=vrep.simxGetCollisionHandle(clientID,'Collision9',vrep.simx_opmode_blocking);

block_c=[block1_c block2_c block3_c block4_c block5_c block6_c ...
    block7_c block8_c block9_c];

block_CC=block_c;
 [res,block1]=vrep.simxGetObjectHandle(clientID,'Block1',vrep.simx_opmode_blocking);
 [res,block2]=vrep.simxGetObjectHandle(clientID,'Block2',vrep.simx_opmode_blocking);
 [res,block3]=vrep.simxGetObjectHandle(clientID,'Block3',vrep.simx_opmode_blocking);
 [res,block4]=vrep.simxGetObjectHandle(clientID,'Block4',vrep.simx_opmode_blocking);
 [res,block5]=vrep.simxGetObjectHandle(clientID,'Block5',vrep.simx_opmode_blocking);
 [res,block6]=vrep.simxGetObjectHandle(clientID,'Block6',vrep.simx_opmode_blocking);
 [res,block7]=vrep.simxGetObjectHandle(clientID,'Block7',vrep.simx_opmode_blocking);
 [res,block8]=vrep.simxGetObjectHandle(clientID,'Block8',vrep.simx_opmode_blocking);
 [res,block9]=vrep.simxGetObjectHandle(clientID,'Block9',vrep.simx_opmode_blocking);

block_d=[block1;block2;block3;block4; ...
    block5;block6;block7;block8;...
    block9];

%% speed
    [res,robt1_lw]=vrep.simxGetObjectHandle(clientID,'Wheel_A_Motor',vrep.simx_opmode_blocking);
    [res,robt1_rw]=vrep.simxGetObjectHandle(clientID,'Wheel_B_Motor',vrep.simx_opmode_blocking);
    [res,robt2_lw]=vrep.simxGetObjectHandle(clientID,'Wheel_A_Motor#0',vrep.simx_opmode_blocking);
    [res,robt2_rw]=vrep.simxGetObjectHandle(clientID,'Wheel_B_Motor#0',vrep.simx_opmode_blocking);
    [res,robt3_lw]=vrep.simxGetObjectHandle(clientID,'Wheel_A_Motor#1',vrep.simx_opmode_blocking);
    [res,robt3_rw]=vrep.simxGetObjectHandle(clientID,'Wheel_B_Motor#1',vrep.simx_opmode_blocking);
    
    %% pose
    
    [res,robt1_pose]=vrep.simxGetObjectHandle(clientID,'main_Hinge',vrep.simx_opmode_blocking);
    [res,robt2_pose]=vrep.simxGetObjectHandle(clientID,'main_Hinge#0',vrep.simx_opmode_blocking);
    [res,robt3_pose]=vrep.simxGetObjectHandle(clientID,'main_Hinge#1',vrep.simx_opmode_blocking);
    % wheels
    
    %         [res,robt1_pose_l]=vrep.simxGetObjectHandle(clientID,'Wheel_A_Motor',vrep.simx_opmode_blocking);
    %         [res,robt1_pose_r]=vrep.simxGetObjectHandle(clientID,'Wheel_B_Motor',vrep.simx_opmode_blocking);
    %         [res,robt2_pose_l]=vrep.simxGetObjectHandle(clientID,'Wheel_A_Motor#0',vrep.simx_opmode_blocking);
    %         [res,robt2_pose_r]=vrep.simxGetObjectHandle(clientID,'Wheel_B_Motor#0',vrep.simx_opmode_blocking);
    %         [res,robt3_pose_l]=vrep.simxGetObjectHandle(clientID,'Wheel_A_Motor#1',vrep.simx_opmode_blocking);
    %         [res,robt3_pose_r]=vrep.simxGetObjectHandle(clientID,'Wheel_B_Motor#1',vrep.simx_opmode_blocking);
    
    %% gripper
    
    [res,robt_gripper]=vrep.simxGetObjectHandle(clientID,'RG2_openCloseJoint',vrep.simx_opmode_blocking);
    [res,gripper_signal]=vrep.simxGetIntegerSignal(clientID,'RG2_open',vrep.simx_opmode_blocking);
    
    %%
    %%
    %%
    %% camera
    
    [res,Mapcam]=vrep.simxGetObjectHandle(clientID,'Map_cam',vrep.simx_opmode_blocking);
    
    
        [startTime, currentTime]=timecounter();
    
    while (currentTime-startTime < 2 )
        [res,bool_detect,auxData,auxPacketInfo]=vrep.simxReadVisionSensor(clientID,Mapcam,vrep.simx_opmode_blocking);
        [res,resolution,matrix_image]=vrep.simxGetVisionSensorImage2(clientID,Mapcam,0,vrep.simx_opmode_streaming);
        %         imshow(matrix_image)
        %         drawnow;
        currentTime=timecounter();
    end
    
    
    
    