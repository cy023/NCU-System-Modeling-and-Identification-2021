# System Modeling
Models for multiple degree of freedom mass-spring-damper system.
![](https://i.imgur.com/q8cxkBy.png =80%x)
## Derivation of one degree of freedom
- System variables

    $$x_1(t) = y(t) \\
    x_2(t) = \dot{y}(t)$$
    
    $$X(t) = 
    \begin{bmatrix}
    x_1(t) \\
    x_2(t)
    \end{bmatrix} \in \mathbb{R}^2$$

- Differential equation for each state variables
    $$
    \dot{x_1}(t) = \dot{y}(t) = x_2(t) \\
    \dot{x_2}(t) = \ddot{y}(t) = - \frac{b}{m} \dot{y}(t) - \frac{k}{m} y(t) + \frac{1}{m} u(t) \\
    = - \frac{b}{m} x_2(t) - \frac{k}{m} x_1(t) + \frac{1}{m} u(t)
    $$

- Vector Form
    $$
    \begin{bmatrix}
    \dot{x_1}(t) \\
    \dot{x_2}(t)
    \end{bmatrix} = 
    \begin{bmatrix}
    x_2(t) \\
    -\frac{b}{m} x_2(t) - \frac{k}{m} x_1(t) + \frac{1}{m} u(t)
    \end{bmatrix}
    $$

- Matrix Form
    $$
    \dot{X}(t) = 
    \begin{bmatrix}
    \dot{x_1}(t) \\
    \dot{x_2}(t)
    \end{bmatrix} =
    \begin{bmatrix}
    0 & 1 \\
    \frac{-k}{m} & \frac{-b}{m}
    \end{bmatrix}
    \begin{bmatrix}
    x_1(t) \\
    x_2(t)
    \end{bmatrix} + 
    \begin{bmatrix}
    0 \\
    \frac{1}{m}
    \end{bmatrix} u(t)
    $$

    $$
    y(t) = 
    \begin{bmatrix}
    1 & 0
    \end{bmatrix}
    \begin{bmatrix}
    x_1(t) \\
    x_2(t)
    \end{bmatrix} + 
    0u(t)
    $$

## Derivation of two degree of freedom

## Derivation of three degree of freedom