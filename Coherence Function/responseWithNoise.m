% Markov Parameters
function yn = response(A, B, C, D, u)
    q = size(u,1);  % number of output
    m = size(u,1);  % number of input
    L = size(u,2);  % number of sampLe

    Y = zeros([q, m*L]);
    U = zeros([m*L, L]);
    noise  = zeros([2, L]);
    noiseU = zeros([m*L, L]);

    % Initial matrix Y and U.
    step = 1;
    i = 1
    while step < m*L
        if step == 1
            Y(:, step:step+m-1) = D;
        else
            Y(:, step:step+m-1) = C * (A^(i-2)) * B;
        end
        noiseU(step:step+m-1, i) = rand([2, 1]) * 10;
        U(step:step+m-1, i:L)    = u(:, 1:L+1-i);
        noise(:, i)              = noiseU(step:step+m-1, i);
        step = step + m;
        i = i + 1;
    end
    yn = Y * noiseU;
end