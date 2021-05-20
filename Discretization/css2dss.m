% Discretization of linear state space models
function [Ad, Bd, Cd, Dd] = css2dss(Ac, Bc, Cc, Dc, Ts)
    DOF = size(Ac,1)/2

    Ad = expm(Ac .* Ts)
    Bd = Ac^(-1) * (Ad-eye(2*DOF)) * Bc
    Cd = Cc
    Dd = Dc
end