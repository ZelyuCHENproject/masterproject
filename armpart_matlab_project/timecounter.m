function [startTime currentTime]=timecounter()
    t=clock;
    startTime_s=t(6);
    startTime_m=t(5);
    startTime_h=t(4);
    startTime_d=t(3);
    startTime_th=t(2);
    startTime_y=t(1);
    currentTime_s=t(6);
    currentTime_m=t(5);
    currentTime_h=t(4);
    currentTime_d=t(3);
    currentTime_th=t(2);
    currentTime_y=t(1);
    
    currentTime=currentTime_m*60+currentTime_s+3600*currentTime_h+3600*24*currentTime_d+3600*24*30*currentTime_th+3600*24*30*365*currentTime_y;
    
    startTime=startTime_m*60+startTime_s+3600*startTime_h+3600*24*startTime_d+3600*24*30*startTime_th+3600*24*30*365*startTime_y;



end