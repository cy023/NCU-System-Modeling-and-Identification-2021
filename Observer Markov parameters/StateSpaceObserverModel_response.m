% Observer Model with deadbeat observer gain
function y = StateSpaceObserverModel_response(A, B, C, D, u)
    q = size(u,1);  % number of output
    m = size(u,1);  % number of input
    L = size(u,2);  % number of sampLe
    n = size(A,1);  % number of state

    p1 =  0.0000000001 - 0.0000000001i;
    p2 =  0.0000000001 + 0.0000000001i;
    p3 = -0.0000000001 + 0.0000000001i;
    p4 = -0.0000000001 - 0.0000000001i;
    G = place(A', -C', [p1, p2, p3, p4])';
    A_bar = A + G*C;
    B_bar = [B + G*D, -G];
    eig(A_bar)

    x = zeros([n, L+1]);
    v = zeros([n, L]);
    y = zeros([q, L]);
    v(:,1) = [u(:,1); y(:,1)];
    
    for t = 1 : L
        x(:,t+1) = A_bar * x(:,t) + B_bar * v(:,t);
        y(:,t)   =     C * x(:,t) +     D * u(:,t);
    end
end