# Discretization
Transfer a continuous time state space to discrete time state space.

## Formula
$$
\begin{cases}
  A_d = A_c e^{A_c\Delta t} \\
  B_d = A_c^{-1} (A_d - I) B_c \\
  C_d = C_c \\
  D_d = D_c
\end{cases}
$$

## Matlab Function
```matlab
function [Ad, Bd, Cd, Dd] = css2dss(Ac, Bc, Cc, Dc, Ts)
    DOF = size(Ac,1)/2

    Ad = expm(Ac .* Ts)
    Bd = Ac^(-1) * (Ad-eye(2*DOF)) * Bc
    Cd = Cc
    Dd = Dc
end
```