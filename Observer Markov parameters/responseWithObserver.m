% Markov Parameters
function yn = responseWithObserver(A, B, C, D, u)
    addpath("D:\Project\SysID\Markov parameters")

    q = size(u,1);  % number of output
    m = size(u,1);  % number of input
    L = size(u,2);  % number of sampLe
    n = size(A,1);  % number of state

    p1 =  0.0000000001 - 0.0000000001i;
    p2 =  0.0000000001 + 0.0000000001i;
    p3 = -0.0000000001 + 0.0000000001i;
    p4 = -0.0000000001 - 0.0000000001i;
    G = place(A', -C', [p1, p2, p3, p4])';
    A_bar = [A + G*C];
    B_bar = [B + G*D, -G];
    % Bd_bar = [B + Gd * D - Gd]
    eig(A_bar)

    % y = zeros([q, m*L]);
    % step = 1;
    % while step < m*L
    %     if step == 1
    %         y(:, step:step+m-1) = D;
    %     else
    %         y(:, step:step+m-1) = C * (A^(((step-1)/m+1)-2)) * B;
    %     end
    %     step = step + m;
    % end

    y = response(A, B, C, D, u)

    Y_bar = zeros([q, (q+m)*(L-1)+m]);
    V     = zeros([(q+m)*(L-1)+m, L]);

    step = 1;
    i = 1;
    while step < (q+m)*(L-1)+m
        if step == 1
            Y_bar(:, step:step+m-1) = D;
            % V(step:step+m-1, i:L) = u(:, 1:L+1-i);
            V(step:step+m-1, i) = [1; 1;];
            step = step + m;
        else
            Y_bar(:, step:step+2*m-1) = C * A_bar^(i-2) * B_bar;
            V(step:step+2*m-1, i:L) = [u(:, 1:L+1-i); y(:, 1:L+1-i)];
%             V(step:step+2*m-1, i) = [1; 1; 0; 0;];
            step = step + n;
        end
        i = i + 1;
    end
    Y_bar
    V
    yn = Y_bar * V
end