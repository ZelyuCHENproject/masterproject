clc;clear;close all

run API_connect_the_vrep.m
%%
%% main loop
%%
if (clientID>-1)
    
    disp('Connected to remote API server');
    
    % Now try to retrieve data in a blocking fashion (i.e. a service call):
    [res,objs]=vrep.simxGetObjects(clientID,vrep.sim_handle_all,vrep.simx_opmode_blocking);
    if (res==vrep.simx_return_ok)
        fprintf('Number of objects in the scene: %d\n',length(objs));
    else
        fprintf('Remote API function call returned with error code: %d\n',res);
    end
    
    run Initial_setting.m
    
    
    disp('initial setting has been implemented')
    
    %%
    %%
    %%
    %% read the image
    block_real_size=[0.07 0.07]; % real size 0.07m 0.07m
    blockHeight=0.07; %block real height 0.07m
    [im, props] = blockBoundingBox(matrix_image);
    [block_position_real0]=objectfinder(block_real_size,im,props); % position of block
   
    
    load alp.mat
    block_position_real0=block_position_real0(inShape(alp,[block_position_real0,0.07*ones(size(block_position_real0,1),1)]),:);
    num_blk=size(block_position_real0,1);
    
    for Np=1:num_blk
        ver_b(Np,:)=vecnorm(block_position_real0(Np,:));
    end
    
   [ver_k,ver_l]=sort(ver_b);
   
   block_position_real0=block_position_real0(ver_l,:);
   

   
 
   
    %     putPosition0=random_get(0.005); % random get a put position in an a area
    
    %% put position
    %     putPosition0=[0,-0.35,0.005];
    %
    %     Mn=1;
    %     while Mn<=num_blk
    %
    %         if norm(putPosition0(:,1:2)-block_position_real0(Mn,:))<=0.15*2^0.5
    %             putPosition0=random_get(0.005);
    %             Mn=1;
    %         else
    %             Mn=Mn+1;
    %         end
    %
    %     end
    
    %%
    for Nn=1:num_blk
        
        put_position=[0 0.3;0 0.37;0 0.44];
        
        
        block_position_real=block_position_real0(Nn,:);
        
        save('block_position_real.mat','block_position_real');
        
        %         putPosition=[putPosition0(1),putPosition0(2),putPosition0(3)+(Nn-1)*blockHeight*1.2];
        
        [posefile,Hingeposefile]=armpose_computer(blockHeight,block_position_real,Nn,put_position);
        
        if isempty(posefile)==1 || isempty(Hingeposefile)==1
            
            
            
        else
            load(posefile);
            load(Hingeposefile);
            
            Hingepose=posedegredu(Hingepose);
            
            save('Hingeposeredu.mat','Hingepose');
            
            disp('path has been computed')
            
            
            run Hingeposesetting.m
            run open_the_gripper.m
            
            run Apply_on_robot.m
            
            pause(6);
            
            run close_the_gripper.m
            
            pause(6);
            
            run back_to_original_pose.m
            
            disp('The block has been grabbed')
            
            
            %%
            n_coll=1;
            for N_coll=block_c
                [res,collisionState]=vrep.simxReadCollision(clientID,N_coll,vrep.simx_opmode_blocking);
                if collisionState~=0
                    block_num=n_coll;
                end
                n_coll=n_coll+1;
            end
            
            
            [posefile_put,Hingeposefile_put]=armpose_computer_put(blockHeight,block_position_real,Nn,put_position);
            
            if isempty(posefile_put)==1 || isempty(Hingeposefile_put)==1
                
                
            else
                
                load(posefile_put);
                load(Hingeposefile_put);
                
                Hingepose=posedegredu(Hingepose);
                
                save('Hingeposeredu.mat','Hingepose');
                
                disp('path has been computed')
                
                run Hingeposesetting.m
                
                run Apply_on_robot.m
                
                pause(6);
                
                run open_the_gripper.m
                
                pause(6);
                
                
                
                run not_dynamic.m
                run back_to_original_pose.m
                                 
                
            end
            
            
            
            disp('Has been put on the position')
            
        end
        
    end
    
    
    
    
    
    %%
else
    disp('Failed connecting to remote API server');
end
vrep.delete(); % call the destructor!
%
disp('Program ended');