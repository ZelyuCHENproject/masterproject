clc,clear,close all

load point_joint.mat
load Hingeposeredu.mat
load block_position_real.mat

putPosition=[0,-0.5,0];


blockxy=block_position_real;

%%

body1=rigidBody('body1');
jnt1=rigidBodyJoint('jnt1','revolute');

tform1=[cos(Hingepose(1)) -sin(Hingepose(1)) 0 0; ...
        sin(Hingepose(1)) cos(Hingepose(1)) 0 0; ...
        0 0 1 .02; ...
        0 0 0 1];
    
setFixedTransform(jnt1,tform1)
body1.Joint=jnt1;


body2=rigidBody('body2');
jnt2=rigidBodyJoint('jnt2','revolute');
jnt2.JointAxis=[0 1 0];

tform2=[cos(Hingepose(2)) 0 sin(Hingepose(2)) 0; ...
        0 1 0 0; ...
        -sin(Hingepose(2)) 0 cos(Hingepose(2)) .065; ...
        0 0 0 1];
    
setFixedTransform(jnt2,tform2);
body2.Joint=jnt2;



body3=rigidBody('body3');
jnt3=rigidBodyJoint('jnt3','revolute');

tform3=[cos(Hingepose(3)) -sin(Hingepose(3)) 0 0; ...
        sin(Hingepose(3)) cos(Hingepose(3)) 0 0; ...
        0 0 1 .065; ...
        0 0 0 1];

setFixedTransform(jnt3,tform3);
body3.Joint=jnt3;    



body4=rigidBody('body4');
jnt4=rigidBodyJoint('jnt4','revolute');
jnt4.JointAxis=[0 1 0];

tform4=[cos(Hingepose(4)) 0 sin(Hingepose(4)) 0; ...
        0 1 0 0; ...
        -sin(Hingepose(4)) 0 cos(Hingepose(4)) .065; ...
        0 0 0 1];

setFixedTransform(jnt4,tform4);
body4.Joint=jnt4;


%%

body5=rigidBody('body5');
jnt5=rigidBodyJoint('jnt5','revolute');

tform5=[cos(Hingepose(5)) -sin(Hingepose(5)) 0 0; ...
        sin(Hingepose(5)) cos(Hingepose(5)) 0 0; ...
        0 0 1 .065; ...
        0 0 0 1];

setFixedTransform(jnt5,tform5);
body5.Joint=jnt5;


body6=rigidBody('body6');
jnt6=rigidBodyJoint('jnt6','revolute');
jnt6.JointAxis=[0 1 0];


tform6=[cos(Hingepose(6)) 0 sin(Hingepose(6)) 0; ...
        0 1 0 0; ...
        -sin(Hingepose(6)) 0 cos(Hingepose(6)) .065; ...
        0 0 0 1];

setFixedTransform(jnt6,tform6);
body6.Joint=jnt6;


%%
body7=rigidBody('body7');
jnt7=rigidBodyJoint('jnt7','revolute');

tform7=[cos(-Hingepose(7)) -sin(-Hingepose(7)) 0 0; ...
        sin(-Hingepose(7)) cos(-Hingepose(7)) 0 0; ...
        0 0 1 .065; ...
        0 0 0 1];


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

%%
block_position_ground=[block_position_real 0];
Vogb=block_position_ground-point_joint(5,:);
Logb=vecnorm(Vogb);

Vogrp=point_joint(5,:)-point_joint(4,:);
Vob=[Vogrp(1),Vogrp(2),0];
angOgb=acos(dot(Vob,Vogrp)/(norm(Vob)*norm(Vogrp)));
    

body9=rigidBody('body9');
jnt9=rigidBodyJoint('jnt9','fixed');

if abs(blockxy(2))>=abs(blockxy(1)) && blockxy(2)<=0

    tform9=[cos(angOgb) -sin(angOgb) 0 0; ...
            sin(angOgb) cos(angOgb) 0 0; ...
            0 0 1 0; ...
            0 0 0 1]* ...
            [cos(-0.5*pi) 0 sin(-0.5*pi) 0; ...
            0 1 0 0; ...
            -sin(-0.5*pi) 0 cos(-0.5*pi) 0; ...
            0 0 0 1]* ...
            [-1 0 0 0; ...
            0 -1 0 0; ...
            0 0 1 0; ...
            0 0 0 1]* ...
            trvec2tform(Vogb);
       
       
elseif abs(blockxy(2))>=abs(blockxy(1)) && blockxy(2)>0
    
        tform9=[cos(angOgb) -sin(angOgb) 0 0; ...
                sin(angOgb) cos(angOgb) 0 0; ...
                0 0 1 0; ...
                0 0 0 1]* ...
                [cos(-0.5*pi) 0 sin(-0.5*pi) 0; ...
                0 1 0 0; ...
                -sin(-0.5*pi) 0 cos(-0.5*pi) 0; ...
                0 0 0 1]* ...
                trvec2tform(Vogb);
             
             
elseif abs(blockxy(1))>=abs(blockxy(2)) && blockxy(1)<=0
    
        tform9=[cos(angOgb) -sin(angOgb) 0 0; ...   
                sin(angOgb) cos(angOgb) 0 0; ...
                0 0 1 0; ...
                0 0 0 1]* ...
                [cos(-0.5*pi) 0 sin(-0.5*pi) 0; ...
                0 1 0 0; ...
                -sin(-0.5*pi) 0 cos(-0.5*pi) 0; ...
                0 0 0 1]* ...
                [0 1 0 0; ...
                -1 0 0 0; ...
                0 0 1 0; ...
                0 0 0 1]* ...
                trvec2tform(Vogb);
        
        
elseif abs(blockxy(1))>=abs(blockxy(2)) && blockxy(1)>0
    
        tform9=[cos(angOgb) -sin(angOgb) 0 0; ...   
                sin(angOgb) cos(angOgb) 0 0; ...
                0 0 1 0; ...
                0 0 0 1]* ...
                [cos(-0.5*pi) 0 sin(-0.5*pi) 0; ...
                0 1 0 0; ...
                -sin(-0.5*pi) 0 cos(-0.5*pi) 0; ...
                0 0 0 1]* ...
                [0 -1 0 0; ...
                1 0 0 0; ...
                0 0 1 0; ...
                0 0 0 1]* ...
                trvec2tform(Vogb);
             
       
end
       
       
       
       


setFixedTransform(jnt9,tform9);
body9.Joint=jnt9;


%%

body10=rigidBody('body10');
setFixedTransform(body10.Joint, trvec2tform(putPosition));

%%
robot=rigidBodyTree;
addBody(robot,body1,'base');
addBody(robot,body2,'body1');
addBody(robot,body3,'body2');
addBody(robot,body4,'body3');
addBody(robot,body5,'body4');
addBody(robot,body6,'body5');
addBody(robot,body7,'body6');
addBody(robot,body8,'body7');
addBody(robot,body9,'body8');
addBody(robot, body10, robot.BaseName);

robot.DataFormat='row';

gik = generalizedInverseKinematics;
gik.RigidBodyTree=robot;






gik.ConstraintInputs = {'pose'};
poseConst = constraintPoseTarget('body9');
poseConst.ReferenceBody='body10';


poseConst.TargetTransform=[1 0 0 0; ...
                            0 1 0 0; ...
                            0 0 1 0; ...
                            0 0 0 1];
                        
q0 = homeConfiguration(robot);


[R5,solutionInfo] = gik(q0,poseConst);



