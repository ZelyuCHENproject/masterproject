clc,clear,close all

load point_joint_pick1.mat
load point_joint_put1.mat

load point_joint_pick2.mat
load point_joint_put2.mat

Vz=[0 0 1];

V_O34_pick=O3_d_pick-O4_pick;
V_O34_put=O3_d_put-O4_put;


for N_pick_o34pick=1:size(V_O34_pick,1)
    
    angO34pick(N_pick_o34pick,:)=acos(dot(V_O34_pick(N_pick_o34pick,:),Vz)/(norm(V_O34_pick(N_pick_o34pick,:))*norm(Vz)));
    
    
end


for N_pick_o34put=1:size(V_O34_put,1)
    
    angO34put(N_pick_o34put,:)=acos(dot(V_O34_put(N_pick_o34put,:),Vz)/(norm(V_O34_put(N_pick_o34put,:))*norm(Vz)));
    
    
end


for np1=1:size(angO34pick,1)
    for np2=1:size(angO34put,1)
        ang(np1,np2)=angO34pick(np1,:)-angO34put(np2,:); 
        
    end
end

[ang_k,ang_l]=find(abs(ang)==min(min(abs(ang))));



O3_ang_pick=O3_d_pick(ang_k,:);
O2_ang_pick=O2_d_pick(ang_k,:);

O3_ang_put=O3_d_put(ang_l,:);
O2_ang_put=O2_d_put(ang_l,:);

% condition 1, filting the lowest point 2, get the No of point 

O23_con1_pick=find(O2_ang_pick(:,3)==min(O2_ang_pick(:,3)));
O23_con1_put=find(O2_ang_put(:,3)==min(O2_ang_put(:,3)));

O3_conp_pick=O3_ang_pick(O23_con1_pick,:);
O2_conp_pick=O2_ang_pick(O23_con1_pick,:);


O3_conp_put=O3_ang_put(O23_con1_put,:);
O2_conp_put=O2_ang_put(O23_con1_put,:);


% the distance from the point o2 to z_axis

Lo2_con2_pick=(O2_conp_pick(:,1).^2+O2_conp_pick(:,2).^2).^0.5;
Lo2_con2_put=(O2_conp_put(:,1).^2+O2_conp_put(:,2).^2).^0.5;



% condition 2, longest o2d distance, and get the No
O23_con2_pick=find(Lo2_con2_pick==min(Lo2_con2_pick));
O23_con2_put=find(Lo2_con2_put==min(Lo2_con2_put));


O3_conp2_pick=O3_conp_pick(O23_con2_pick,:);
O2_conp2_pick=O2_conp_pick(O23_con2_pick,:);


O3_conp2_put=O3_conp_put(O23_con2_put,:);
O2_conp2_put=O2_conp_put(O23_con2_put,:);



% the distance from the point o3 to z_axis
Lo3_con3_pick=(O3_conp2_pick(:,1).^2+O3_conp2_pick(:,2).^2).^0.5;
Lo3_con3_put=(O3_conp2_put(:,1).^2+O3_conp2_put(:,2).^2).^0.5;

% condition 3, shortest distance and get the No
O23_con3_pick=find(Lo3_con3_pick==max(Lo3_con3_pick));
O23_con3_put=find(Lo3_con3_put==max(Lo3_con3_put));

% the final point getten 

O2_fp_pick=O2_conp2_pick(O23_con3_pick(1),:);
O3_fp_pick=O3_conp2_pick(O23_con3_pick(1),:);


O2_fp_put=O2_conp2_put(O23_con3_put(1),:);
O3_fp_put=O3_conp2_put(O23_con3_put(1),:);


point_joint_pick=[O0_pick;O1_pick;O2_fp_pick;O3_fp_pick;O4_pick];
point_joint_put=[O0_put;O1_put;O2_fp_put;O3_fp_put;O4_put];
save('point_joint_pick','point_joint_pick')
save('point_joint_put','point_joint_put')

tf0=1;



