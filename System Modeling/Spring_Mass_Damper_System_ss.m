function [A, B, C, D] = Spring_Mass_Damper_System_ss(DOF, m, b, k)
    % Calculate A matrix in state space
    if DOF > 1
        A_K = zeros(DOF);
        A_C = zeros(DOF);

        index = 1;
        for row = 1 : DOF
            for col = 1 : DOF
                mass = m(index);
                if row == 1
                    if col == index
                        A_K(row, col) = -k(index)/mass;
                        A_C(row, col) = -b(index)/mass;
                    elseif col == index + 1
                        A_K(row, col) = k(index)/mass;
                        A_C(row, col) = b(index)/mass;
                    end
                elseif row == DOF
                    if col == index
                        A_K(row, col) = -(k(index) + k(index-1))/mass;
                        A_C(row, col) = -(b(index) + b(index-1))/mass;
                    elseif col == index - 1
                        A_K(row, col) = k(index-1)/mass;
                        A_C(row, col) = b(index-1)/mass;
                    end
                else
                    if col == index
                        A_K(row, col) = -(k(index) + k(index-1))/mass;
                        A_C(row, col) = -(b(index) + b(index-1))/mass;
                    elseif col == index - 1
                        A_K(row, col) = k(index-1)/mass;
                        A_C(row, col) = b(index-1)/mass;
                    elseif col == index + 1
                        A_K(row, col) = k(index)/mass;
                        A_C(row, col) = b(index)/mass;
                    end
                end
            end
            index = index + 1;
        end
        A = [zeros(DOF) eye(DOF); A_K A_C]
    else
        A =[0 1;-k/m -b/m]
    end

    % Calculate B matrix in state space
    B = zeros(2*DOF, DOF);
    for i = 1 : DOF
        B(DOF+i, i) = 1/m(DOF);
    end

    % Calculate C matrix in state space
    C = zeros(2*DOF, DOF)
    C = [ones(1, DOF) zeros(1, DOF); zeros(1, DOF) ones(1, DOF)]

    % Calculate D matrix in state space
    D = zeros(DOF, DOF)
end