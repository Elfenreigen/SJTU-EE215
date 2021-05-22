function state = check_sys(state_nodes)
%CHECK_SYS 调整节点工作模式，检查系统当前工作状态
%   此处显示详细说明
    PF = sum(state_nodes == 0);
    SO = sum(state_nodes == 1);
    DM = sum(state_nodes == 2);
    MO = sum(state_nodes == 3);
    DN = sum(state_nodes == 4);
    FB = sum(state_nodes == 5);
    if (FB >= 1)||(MO >= 2)||(PF + MO + DM == 0)||((PF + SO + ((MO + DM) > 0)) < 5)
        state = 0;
    elseif (FB == 0) && ((MO == 1 && PF + SO >= 4)||(MO == 0 && PF >= 1 && PF + SO >= 5)|| ...
            (MO == 0 && PF == 0 && DM >= 1 && SO >= 4)) 
        state = 1;
    elseif rand() <= (DM / (DM + PF))
        state = 1;
    else
        state = 0;
    end
end

