% Markov Parameters
function Y = response(A, B, C, D, u)
    DOF = size(A,1)/2
    
    C = [eye(DOF) zeros(DOF); zeros(DOF) zeros(DOF)];
    y = zeros(2*DOF, size(u,2));
    for t = 1 : size(u,2)
        if (t == 1)
            y(:,t) = zeros(2*DOF,1);
        else
            for i = 1 : (t-1)
                y(:,t) = y(:,t) + C * A^(i-1) * B * u(:,t-i);
            end
        end
    end
    Y = y(1:2,:);
end