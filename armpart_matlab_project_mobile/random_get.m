function putPosition=random_get(c)

    ab=[0,0];
    grp_range0=ab(1)^2+ab(2)^2;
    grp_range1=(ab(1)+0.34)^2+ab(2)^2;
    grp_range2=(ab(1)-0.34)^2+ab(2)^2;
    grp_range3=ab(1)^2+(ab(2)+0.34)^2;
    grp_range4=ab(1)^2+(ab(2)-0.34)^2;

    while ~(grp_range0>0.225^2 && ...
            (grp_range0<0.25^2 || grp_range1<0.16^2 || grp_range2<0.16^2 || grp_range3<0.16^2 ...
            || grp_range4<0.16^2))

        ab=(randperm(120, 2)-50)/100;
        grp_range0=ab(1)^2+ab(2)^2;
        grp_range1=(ab(1)+0.34)^2+ab(2)^2;
        grp_range2=(ab(1)-0.34)^2+ab(2)^2;
        grp_range3=ab(1)^2+(ab(2)+0.34)^2;
        grp_range4=ab(1)^2+(ab(2)-0.34)^2;

    end

    putPosition=[ab,c];
end


