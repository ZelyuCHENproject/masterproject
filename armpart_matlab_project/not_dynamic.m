block_NMM=find(blockOO==block_c);
B_n_d=block_d(block_NMM,:);
[res]=vrep.simxSetModelProperty(clientID,B_n_d,vrep.sim_modelproperty_not_dynamic,vrep.simx_opmode_blocking);