function Hingepose0=posedegredu(Hingepose)

    Hingepose_size=size(Hingepose,1);
    
    Hingepose(end,:)=-Hingepose(end,:)+pi;
    
    n_H=1;
    
    while n_H<=Hingepose_size-1
        
        if Hingepose(n_H,:)>0.5*pi
           Hingepose(n_H,:)=Hingepose(n_H,:)-pi;
           Hingepose(n_H+1:2:end-1,:)=-Hingepose(n_H+1:2:end-1,:);
           Hingepose(end,:)=Hingepose(end,:)-pi;
        
        
        elseif Hingepose(n_H,:)<-0.5*pi
           Hingepose(n_H,:)=Hingepose(n_H,:)+pi;
           Hingepose(n_H+1:2:end-1,:)=-Hingepose(n_H+1:2:end-1,:);
           Hingepose(end,:)=Hingepose(end,:)+pi;
           
        end
        
        
        if  Hingepose(end,:)>2*pi
            Hingepose(end,:)= Hingepose(end,:)-2*pi;
               
        elseif  Hingepose(end,:)<-2*pi
               Hingepose(end,:)= Hingepose(end,:)+2*pi;
        end
        
         n_H=n_H+2;
             
    end
        
    Hingepose0=Hingepose;

end