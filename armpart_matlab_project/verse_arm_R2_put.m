
clc,clear,close all

load point_joint_put.mat
point_joint=point_joint_put;
load R1.mat

Rp0=R1(1).JointPosition;
Rp1=R1(2).JointPosition;

%%

body1=rigidBody('body1');
jnt1=rigidBodyJoint('jnt1','fixed');

tform1=[cos(Rp0) -sin(Rp0) 0 0; ...
        sin(Rp0) cos(Rp0) 0 0; ...
        0 0 1 .02; ...
        0 0 0 1];
    
setFixedTransform(jnt1,tform1);
body1.Joint=jnt1;


body2=rigidBody('body2');
jnt2=rigidBodyJoint('jnt2','fixed');

tform2=[cos(Rp1) 0 sin(Rp1) 0; ...
        0 1 0 0; ...
        -sin(Rp1) 0 cos(Rp1) .065; ...
        0 0 0 1];
    
setFixedTransform(jnt2,tform2);
body2.Joint=jnt2;

%%

body3=rigidBody('body3');
jnt3=rigidBodyJoint('jnt3','revolute');
tform3=trvec2tform([0 0 .065]);
setFixedTransform(jnt3,tform3);
body3.Joint=jnt3;

body4=rigidBody('body4');
jnt4=rigidBodyJoint('jnt4','revolute');
jnt4.JointAxis=[0 1 0];
tform4=trvec2tform([0 0 .065]);
jnt4.PositionLimits=[-0.5*pi 0.5*pi];
setFixedTransform(jnt4,tform4);
body4.Joint=jnt4;

%%

body5=rigidBody('body5');
jnt5=rigidBodyJoint('jnt5','fixed');
tform5=trvec2tform([0 0 .128]);
setFixedTransform(jnt5,tform5);
body5.Joint=jnt5;

%%

robot=rigidBodyTree;
addBody(robot,body1,'base');
addBody(robot,body2,'body1');
addBody(robot,body3,'body2');
addBody(robot,body4,'body3');
addBody(robot,body5,'body4');

%%
gik = generalizedInverseKinematics;
gik.RigidBodyTree=robot;

gik.ConstraintInputs = {'aiming'};
aimCon = constraintAiming('body5');
aimCon.TargetPoint = point_joint(4,:);

q0 = homeConfiguration(robot);
[R2,solutionInfo] = gik(q0,aimCon);

% show(robot,R2);


save('R2','R2')

