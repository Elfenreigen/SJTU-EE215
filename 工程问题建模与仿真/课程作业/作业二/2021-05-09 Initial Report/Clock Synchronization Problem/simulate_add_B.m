for s = 1 : n_samples
    A = zeros(1, n);
    B = zeros(1, n);
    status_A = rand(1, n);
    status_B_1 = (rand(1, n) > 0.35) + 1;
    status_B_2 = (rand(1, n) > 0.35) + 1;
    state_nodes = zeros(1, n);
    status_A(status_A > 0.52) = 3;
    status_A((status_A > 0.26) & (status_A <= 0.52)) = 2;
    status_A(status_A <= 0.26) = 1;
    broken_A = exprnd(mu_A, 1, n);
    broken_B_1 = exprnd(mu_B, 1, n);
    broken_B_2 = exprnd(mu_B, 1, n);
    event_A = [1 : n; broken_A; status_A; zeros(1, n)]';
    event_B = [1 : n; zeros(2, n); ones(1, n)]';
    for idx = 1 : n
        if broken_B_1(idx) < broken_B_2(idx)
            if status_B_1(idx) == 1
                event_B(idx, 2) = broken_B_2(idx);
                event_B(idx, 3) = status_B_2(idx);
            else
                event_B(idx, 2) = broken_B_1(idx);
                event_B(idx, 3) = status_B_1(idx);
            end
        else
            if status_B_2(idx) == 1
                event_B(idx, 2) = broken_B_1(idx);
                event_B(idx, 3) = status_B_1(idx);
            else
                event_B(idx, 2) = broken_B_2(idx);
                event_B(idx, 3) = status_B_2(idx);
            end
        end
    end
    events_queue = sortrows([event_A; event_B], 2);
    
    for idx = 1 : 2 * n
        event = events_queue(idx, :);
        if event(2) > 9e4
            break;
        end
        if event(4)
            B(event(1)) = event(3);
        else
            A(event(1)) = event(3);
        end
        state_nodes(event(1)) = combo(A(event(1)) + 1, B(event(1)) + 1);
        state_sys = check_sys(state_nodes);
        if ~state_sys
            if sum(state_nodes == 3) >= 1 || sum(state_nodes == 5) >= 1
                FB_count = FB_count + 1;
            end
            break;
        end
    end
    if state_sys
        Life(s) = max_life;
    else
        Life(s) = min(event(2), max_life);
    end
end