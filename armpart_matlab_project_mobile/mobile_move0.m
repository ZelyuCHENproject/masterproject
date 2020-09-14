[res,positon_bottom]=vrep.simxGetObjectPosition(clientID,bottom,-1,vrep.simx_opmode_blocking);    

movespeed=0.2;


% movedistance=movedistance-(MNn-1)*blockHeight;





for i=1:(movedistance0/movespeed*100)
    
    [res]=vrep.simxSetObjectPosition(clientID,bottom,-1,[positon_bottom(:,1)-(movespeed/100)*i,positon_bottom(:,2),positon_bottom(:,3)],vrep.simx_opmode_blocking);
    pause(0.01)
    
end