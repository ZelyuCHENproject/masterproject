clc,clear,close all

load point_joint_pick.mat
    point_joint=point_joint_pick;
load R1.mat
load R2.mat
load R3.mat

Rp0=R1(1).JointPosition;
Rp1=R1(2).JointPosition;
Rp12=R2(1).JointPosition;
Rp2=R2(2).JointPosition;
Rp23=R3(1).JointPosition;
Rp3=R3(2).JointPosition;


%%

body1=rigidBody('body1');
jnt1=rigidBodyJoint('jnt1','fixed');

tform1=[cos(Rp0) -sin(Rp0) 0 0; ...
        sin(Rp0) cos(Rp0) 0 0; ...
        0 0 1 .02; ...
        0 0 0 1];
    
setFixedTransform(jnt1,tform1)
body1.Joint=jnt1;


body2=rigidBody('body2');
jnt2=rigidBodyJoint('jnt2','fixed');

tform2=[cos(Rp1) 0 sin(Rp1) 0; ...
        0 1 0 0; ...
        -sin(Rp1) 0 cos(Rp1) .065; ...
        0 0 0 1];
    
setFixedTransform(jnt2,tform2);
body2.Joint=jnt2;



body3=rigidBody('body3');
jnt3=rigidBodyJoint('jnt3','fixed');

tform3=[cos(Rp12) -sin(Rp12) 0 0; ...
        sin(Rp12) cos(Rp12) 0 0; ...
        0 0 1 .065; ...
        0 0 0 1];

setFixedTransform(jnt3,tform3);
body3.Joint=jnt3;    



body4=rigidBody('body4');
jnt4=rigidBodyJoint('jnt4','fixed');

tform4=[cos(Rp2) 0 sin(Rp2) 0; ...
        0 1 0 0; ...
        -sin(Rp2) 0 cos(Rp2) .065; ...
        0 0 0 1];

setFixedTransform(jnt4,tform4);
body4.Joint=jnt4;


%%

body5=rigidBody('body5');
jnt5=rigidBodyJoint('jnt5','fixed');

tform5=[cos(Rp23) -sin(Rp23) 0 0; ...
        sin(Rp23) cos(Rp23) 0 0; ...
        0 0 1 .065; ...
        0 0 0 1];

setFixedTransform(jnt5,tform5);
body5.Joint=jnt5;


body6=rigidBody('body6');
jnt6=rigidBodyJoint('jnt6','fixed');

tform6=[cos(Rp3) 0 sin(Rp3) 0; ...
        0 1 0 0; ...
        -sin(Rp3) 0 cos(Rp3) .065; ...
        0 0 0 1];

setFixedTransform(jnt6,tform6);
body6.Joint=jnt6;


%%
body7=rigidBody('body7');
jnt7=rigidBodyJoint('jnt7','revolute');
tform7=trvec2tform([0 0 .065]);
setFixedTransform(jnt7,tform7);
body7.Joint=jnt7;

%%

body8=rigidBody('body8');
jnt8=rigidBodyJoint('jnt8','fixed');

tform8=trvec2tform([0 0 .175])* ...
       [1 0 0 0; ...
        0 0 -1 0; ...
        0 1 0 0; ...
        0 0 0 1];

setFixedTransform(jnt8,tform8);
body8.Joint=jnt8;

robot=rigidBodyTree;
addBody(robot,body1,'base');
addBody(robot,body2,'body1');
addBody(robot,body3,'body2');
addBody(robot,body4,'body3');
addBody(robot,body5,'body4');
addBody(robot,body6,'body5');
addBody(robot,body7,'body6');
addBody(robot,body8,'body7');



gik = generalizedInverseKinematics;
gik.RigidBodyTree=robot;

gik.ConstraintInputs = {'aiming'};
aimCon = constraintAiming('body8');

pj5=point_joint(5,:);


if abs(pj5(1))>=abs(pj5(2)) && pj5(1)>=0
   aimCon.TargetPoint = [0 100000 0];
elseif abs(pj5(1))>=abs(pj5(2)) && pj5(1)<0
   aimCon.TargetPoint = [0 -100000 0];
elseif abs(pj5(1))<=abs(pj5(2)) && pj5(2)>=0
   aimCon.TargetPoint = [-100000 0 0];
elseif abs(pj5(1))<=abs(pj5(2)) && pj5(2)<0
   aimCon.TargetPoint = [100000 0 0];
end


q0 = homeConfiguration(robot);
[R4,solutionInfo] = gik(q0,aimCon);


% load arm_path_comp.mat
%  show(robot,R4);
%  hold on
%  BOX = collisionBox(0.07,0.07,0.07);
% BOX.Pose=[1 0 0 blockxy(1); 0 1 0 blockxy(2); 0 0 1 0; 0 0 0 1];
% show(BOX)

