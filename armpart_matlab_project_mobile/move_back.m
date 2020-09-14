    [res,positon_bottom]=vrep.simxGetObjectPosition(clientID,bottom,-1,vrep.simx_opmode_blocking);
for i=1:(movedistance1/movespeed*100)
    
    [res]=vrep.simxSetObjectPosition(clientID,bottom,-1,[positon_bottom(:,1)+(movespeed/100)*i,positon_bottom(:,2),positon_bottom(:,3)],vrep.simx_opmode_blocking);
    pause(0.01)
    
end