clc,clear,close all
%%we now know the point of block position
%%the position of root of arm is fixed
%%Hence, two points are known.
%%The first joint only can conduct the function of 
%%revolute with z_axis.
%%Hence, This point is also known
%%and can be considered as a fixed point
load arm_path_comp.mat

MNn=mod(Nn,3);
if MNn~=0
blockxy=put_position(MNn,:);
elseif MNn==0
blockxy=put_position(3,:);
end

HNn=ceil(Nn/3);

block_position=[blockxy,blockHeight*HNn]; 
% position of block
% if Nn<=3
% block_position=[blockxy,blockHeight];
% elseif Nn==4
% block_position=[blockxy,blockHeight*2];  
% end





% length of each part 
l1=0.02+0.065;
l2=0.065+0.065;
l3=0.065+0.065;
l4=0.065+0.175;

l_arm=l1+l2+l3+l4;

% root  O0
x0=0; y0=0; z0=0;
O0=[x0,y0,z0];

% the first joint O1
x1=0; y1=0; z1=l1;
O1=[x1,y1,z1];

% the gripper O4

if abs(blockxy(1))>=abs(blockxy(2)) && blockxy(1)>=0
    O4=[block_position(1)-0.07*0.5,block_position(2),block_position(3)];
elseif abs(blockxy(1))>=abs(blockxy(2)) && blockxy(1)<0
    O4=[block_position(1)+0.07*0.5,block_position(2),block_position(3)];
elseif abs(blockxy(1))<abs(blockxy(2)) && blockxy(2)>=0
    O4=[block_position(1),block_position(2)-0.07*0.5,block_position(3)];
elseif abs(blockxy(1))<abs(blockxy(2)) && blockxy(2)<0
    O4=[block_position(1),block_position(2)+0.07*0.5,block_position(3)];   
end




% the wrist of gripper O3
X3=(-l2-l1-l3:0.0005:l2+l1+l3)';
if abs(O4(1))>=abs(O4(2))
    y3=O4(2);
    [x_3,z_3]=ndgrid(X3);
    O3=[x_3(:),y3*ones(size(x_3(:),1),1),z_3(:)];
    O3=O3((find(abs(O3(:,1))<=l2+l3 & abs(O3(:,2))<=l2+l3)),:);
else
    x3=O4(1);
    [y_3,z_3]=ndgrid(X3);
    O3=[x3*ones(size(y_3(:),1),1),y_3(:),z_3(:)];
    O3=O3((find(abs(O3(:,1))<=l2+l3 & abs(O3(:,2))<=l2+l3)),:);
end


% the wrist should higher than the root 
O3=O3((find(O3(:,3)>=l1)),:);
O3_size=size(O3,1);

if isempty(O3)==1
    disp('CAN NOT TOUCH THE BLOCK')
    tf0=0;
    return
end


%%
% compute the vector of the gripper
Vo34=O3-O4;

for n_o3=1:O3_size
    
    Lo34(n_o3,:)=vecnorm(Vo34(n_o3,:)); % compute the length of each possiable 
                                        % joint 3 and joint 4 points
    
end

% the length is l4 and the error should control in +- 0.0001
% update the point of joint 3
O3=O3((find(Lo34>=l4-0.0001 & Lo34<=l4+0.0001)),:);

%%
if isempty(O3)==1
    disp('CAN NOT TOUCH THE BLOCK')
    tf0=0;
    return
end
%%


% compute the length from the 0 point to joint 3 point
for n_o3o=1:size(O3,1)
    
    Lo3(n_o3o,:)=vecnorm(O3(n_o3o,:));
    
end

% the point of joint 3 should less than l1+l2+l3
O3=O3((find(Lo3<=l1+l2+l3+0.0001)),:);


%%
if isempty(O3)==1
    disp('CAN NOT TOUCH THE BLOCK')
    tf0=0;
    return
end
%%

% compute the vector of O31
Vo31=O3-O1;

% compute the euclidean length of vector O31 
for n_o31=1:size(O3,1)
    
    Lo31(n_o31,:)=vecnorm(Vo31(n_o31,:));
    
end

% this length should less than l2+l3 and longer than the hypotenous of the
% right triangle 
O3=O3((find(Lo31<=l2+l3+0.0001 & Lo31>=(l2^2+l3^2)^0.5)),:);


%%
if isempty(O3)==1
    disp('CAN NOT TOUCH THE BLOCK')
    tf0=0;
    return
end
%%


%%
% O2 the second joint 


% X2=(-l2-l1:0.001:l2+l1)';
% [x_2,y_2,z_2]=ndgrid(X2);
% O2=[x_2(:),y_2(:),z_2(:)];
% O2=O2((find(O2(:,3)>=l1)),:);
% O2=O2((find(abs(O2(:,1))<=l2)),:);
% O2=O2((find(abs(O2(:,2))<=l2)),:);
% O2_size=size(O2,1);
% 
% % compute the vector from the first joint to the scond joint 
% 
% Vo21=O2-O1;
% 
% % the length of vector O21
% for n_o2=1:O2_size
%     
%     Lo21(n_o2,:)=vecnorm(Vo21(n_o2,:));
%     
% end
% 
% % the length of VO21 should be l2, the error is 0.0001
% O2=O2((find(Lo21>=l2-0.0001 & Lo21<=l2+0.0001)),:);
% 
% %%
% if isempty(O2)==1
%     disp('CAN NOT TOUCH THE BLOCK')
%     tf0=0;
%     return
% end
% %%
% 
% % compute the euclidean length from the 0 point to the second joint 
% for n_o2o=1:size(O2,1)
%     
%     Lo2(n_o2o,:)=vecnorm(O2(n_o2o,:));
%     
% end
% 
% % this length should less than l1+l2, larger than the hypotenuse of a right triangle
% % because of the largest angle is 0.5*pi
% O2=O2((find(Lo2<=l1+l2+0.0001 & Lo2>=(l1^2+l2^2)^0.5)),:);

load O2.mat

%%
if isempty(O2)==1
    disp('CAN NOT TOUCH THE BLOCK')
    tf0=0;
    return
end
%%


% compute the vector of O24
Vo24=O2-O4;

% compute the euclidean length of vector O24
for n_o24=1:size(Vo24,1)
    
    Lo24(n_o24,:)=vecnorm(Vo24(n_o24,:));
    
end

% this length should less than l3+l4 and longer than the hypotenous of the
% right triangle 
O2=O2((find(Lo24<=l3+l4+0.0001 & Lo24>=(l3^2+l4^2)^0.5)),:);

%%
if isempty(O2)==1
    disp('CAN NOT TOUCH THE BLOCK')
    tf0=0;
    return
end
%%

%% O3,O2 determine

% compute euclidean length of each joint 2 point to each joint 3 point
for n_O32=1:size(O3,1)
    
    for n_O23=1:size(O2,1)
    
    Lo32(n_O32,n_O23)=vecnorm(O3(n_O32,:)-(O2(n_O23,:)));
    
    end

end

% the length should be l3
[O3_j,O2_k]=find((Lo32<=(l3+0.0001)) & (Lo32>=(l3-0.0001)));


%%
if isempty(O3_j)==1 || isempty(O2_k)==1
    disp('CAN NOT TOUCH THE BLOCK')
    tf0=0;
    return
end
%%


% compute vector 32 and vector 21
Vo32=O3(O3_j,:)-O2(O2_k,:);

Vo32_21=O2(O2_k,:)-O1;

Vo32_size=size(Vo32,1);

% compute the angle of each pair of vector
for n_Vo32=1:Vo32_size
    
    ang32(n_Vo32,:)=acos(dot(Vo32(n_Vo32,:),Vo32_21(n_Vo32,:))/(norm(Vo32(n_Vo32,:))*norm(Vo32_21(n_Vo32,:))));
    
end

% angle should less than 0.5*pi and larger than 0
O3_num=O3_j((find(ang32<=0.5*pi & ang32>=0)),:);
O2_num=O2_k((find(ang32<=0.5*pi & ang32>=0)),:);

%%
if isempty(O3_num)==1 || isempty(O3_num)==1
    disp('CAN NOT TOUCH THE BLOCK')
    tf0=0;
    return
end
%%



% new point 3 and 2
O3r=O3(O3_num,:);
O2r=O2(O2_num,:);

% filting point 3 should higher than O2  
num_O32=find(O3r(:,3)>=O2r(:,3));

% new 3 and 2
O3_d=O3r(num_O32,:);
O2_d=O2r(num_O32,:);



%%

O0_put=O0;
O4_put=O4;
O1_put=O1;
O2_d_put=O2_d;
O3_d_put=O3_d;


point_joint_put1=[O0_put;O1_put;O4_put];
point_joint_put2=[O2_d_put;O3_d_put];

save('point_joint_put1','O0_put','O1_put','O4_put')
save('point_joint_put2','O2_d_put','O3_d_put')

tf0=1;