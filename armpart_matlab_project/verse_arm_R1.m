clc, clear, close all

load point_joint_pick.mat
point_joint=point_joint_pick;

%%
body1=rigidBody('body1');
jnt1=rigidBodyJoint('jnt1','revolute');
tform1=trvec2tform([0 0 .02]);
setFixedTransform(jnt1,tform1);
body1.Joint=jnt1;

body2=rigidBody('body2');
jnt2=rigidBodyJoint('jnt2','revolute');
jnt2.PositionLimits=[-0.5*pi 0.5*pi];
jnt2.JointAxis=[0 1 0];
tform2=trvec2tform([0 0 .065]);
setFixedTransform(jnt2,tform2);
body2.Joint=jnt2;
%%

body3=rigidBody('body3');
jnt3=rigidBodyJoint('jnt3','fixed');
tform3=trvec2tform([0 0 .128]);
setFixedTransform(jnt3,tform3);
body3.Joint=jnt3;

%%
robot=rigidBodyTree;
addBody(robot,body1,'base');
addBody(robot,body2,'body1');
addBody(robot,body3,'body2');

%%
gik = generalizedInverseKinematics;
gik.RigidBodyTree=robot;

gik.ConstraintInputs = {'aiming'};
aimCon = constraintAiming('body3');
aimCon.TargetPoint = point_joint(3,:);

q0 = homeConfiguration(robot);
[R1,solutionInfo] = gik(q0,aimCon);

% load arm_path_comp.mat
%  show(robot,R1);
%  hold on
%  BOX = collisionBox(0.07,0.07,0.07);
% BOX.Pose=[1 0 0 blockxy(1); 0 1 0 blockxy(2); 0 0 1 0; 0 0 0 1];
% show(BOX)


save('R1','R1');

