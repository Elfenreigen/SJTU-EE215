function state = check_sys(state_nodes)
%CHECK_SYS �����ڵ㹤��ģʽ�����ϵͳ��ǰ����״̬
%   �˴���ʾ��ϸ˵��
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

