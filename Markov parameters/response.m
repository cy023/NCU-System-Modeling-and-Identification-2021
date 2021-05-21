% Markov Parameters
function yn = response(A, B, C, D, u)
    q   = size(u,1);    % number of output
    m   = size(u,1);    % number of input
    L   = size(u,2);    % number of sampLe

    Y = zeros([q, m*L]);
    U = zeros([m*L, L]);

    % Initial matrix Y and U.
    step = 1;
    while step < m*L
        if step == 1
            Y(:, step:step+m-1) = D;
        else
            Y(:, step:step+m-1) = C * (A^(((step-1)/m+1)-2)) * B;
        end
        U(step:step+m-1, ((step-1)/m+1):L) = u(:, 1:L+1-((step-1)/m+1));
        step = step + m;
    end
    yn = Y * U;
end