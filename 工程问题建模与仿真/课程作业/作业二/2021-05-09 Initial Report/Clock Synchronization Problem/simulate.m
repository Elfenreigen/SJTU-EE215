status_A = rand(n_samples, n);
status_B = (rand(n_samples, n) > 0.35) + 1;
status_A(status_A > 0.52) = 3;
status_A(status_A <= 0.26) = 1;
status_A(status_A < 1) = 2;
state_nodes = zeros(n_samples, n);
broken_A = exprnd(mu_A, n_samples, n);
broken_B = exprnd(mu_B, n_samples, n);
A = zeros(n_samples, n);
B = zeros(n_samples, n);
for s = 1 : n_samples
    event_A = [1 : n; broken_A(s, :); status_A(s, :); zeros(1, n)]';
    event_B = [1 : n; broken_B(s, :); status_B(s, :); ones(1, n)]';
    events_queue = sortrows([event_A; event_B], 2);
    for idx = 1 : 2 * n
        event = events_queue(idx, :);
        if event(2) >= max_life
            Life(s) = max_life;
            break;
        end
        if event(4) == 1
            B(s, event(1)) = event(3);
        else
            A(s, event(1)) = event(3);
        end
        state_nodes(s, event(1)) = combo(A(s, event(1)) + 1, B(s, event(1)) + 1);
        state_sys = check_sys(state_nodes(s, :));
        if state_sys == 0
            Life(s) = event(2);
            if sum(state_nodes(s, :) == 3) >= 1 || sum(state_nodes(s, :) == 5) >= 1
                FB_count = FB_count + 1;
            end
            break;
        end
    end
end