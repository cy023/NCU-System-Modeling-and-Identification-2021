function y = StateSpaceModel_response(A, B, C, D, u)
    q = size(u,1);  % number of output
    L = size(u,2);  % number of sampLe
    n = size(A,1);  % number of state
    
    x = zeros([n, L+1]);
    y = zeros([q, L]);
    
    for t = 1 : L
        x(:,t+1) = A * x(:,t) + B * u(:,t);
        y(:,t)   = C * x(:,t) + D * u(:,t);
    end
end