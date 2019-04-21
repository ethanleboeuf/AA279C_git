function [q] = DCM_to_quart(DCM)
B4 = 1/4 * (1 + trace(DCM));
B1 = 1/4 * (1 + 2*DCM(1,1) - trace(DCM));
B2 = 1/4 * (1 + 2*DCM(2,2) - trace(DCM));
B3 = 1/4 * (1 + 2*DCM(3,3) - trace(DCM));
B = [B1 B2 B3 B4];
[M, I] = max(B);
q = zeros(4,1);
q(4) = sqrt(B(I));
if I == 4
    q(1) = (DCM(2,3) - DCM(3,2)) / 4 / q(4);
    q(2) = (DCM(3,1) - DCM(1,3)) / 4 / q(4);
    q(3) = (DCM(1,2) - DCM(2,1)) / 4 / q(4);
elseif I == 3
    q(2) = (DCM(2,3) + DCM(3,2)) / 4 / q(4);
    q(1) = (DCM(3,1) + DCM(1,3)) / 4 / q(4);
    q(3) = (DCM(1,2) - DCM(2,1)) / 4 / q(4);
elseif I == 2
    q(2) = (DCM(2,3) + DCM(3,2)) / 4 / q(4);
    q(3) = (DCM(3,1) - DCM(1,3)) / 4 / q(4);
    q(1) = (DCM(1,2) + DCM(2,1)) / 4 / q(4);
elseif I == 1
    q(3) = (DCM(2,3) - DCM(3,2)) / 4 / q(4);
    q(2) = (DCM(3,1) + DCM(1,3)) / 4 / q(4);
    q(1) = (DCM(1,2) + DCM(2,1)) / 4 / q(4);
end
q = q/norm(q);
end

