    motorVelocity=-0.1;


   vrep.simxSetJointForce(clientID,robt_gripper,motorForce,vrep.simx_opmode_blocking);
   vrep.simxSetJointTargetVelocity(clientID,robt_gripper,motorVelocity,vrep.simx_opmode_blocking);
   
   