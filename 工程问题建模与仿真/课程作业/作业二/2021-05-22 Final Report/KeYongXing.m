clc;

PA0 = exp(-25000 / 37000);
PB0 = exp(-25000 / 480000);
PA1 = 0.26 * (1 - PA0);
PA2 = 0.26 * (1 - PA0);
PA3 = 0.48 * (1 - PA0);
PB1 = 0.35 * (1 - PB0);
PB2 = 0.65 * (1 - PB0);

PPF = PA0 * PB0;
PMO = (PA0 + PA2) * PB1;
PSO = PA0 * PB2 + PA1 * PB0 + PA1 * PB2;
PFB = PA1 * PB1;
PDM = PA2 * PB0;
PDN = PA2 * PB2 + PA3;

KeYongXing = zeros(1, 20);

for n = 5 : 20
    Node = zeros(1, n);
    for k1 = 0 : n
        for k2 = 0 : (n - k1)
            for k3 = 0 : (n - k1 - k2)
                for k4 = 0 : (n - k1 - k2 - k3)
                    for k5 = 0 : (n - k1 - k2 - k3 - k4)
                        k6 = n - k1 - k2 - k3 - k4 - k5;
                        if (k4 >= 1)||(k2 >= 2)||(k1 + k2 + k5 == 0)||(k1 + k3 + sum(k2 + k5 > 0) < 5)
                            continue;
                        end
                        if (k2 == 1 && k1 + k3 >= 4)||(k2 == 0 && k1 >= 1 && k1 + k3 >= 5)||(k2 == 0 && k1 == 0 && k5 >= 1 && k3 >= 4) 
                            KeYongXing(n) = KeYongXing(n) + nchoosek(n, k1) * nchoosek(n-k1, k2) * nchoosek(n-k1-k2, k3) * ...
                                nchoosek(n-k1-k2-k3, k4) * nchoosek(n-k1-k2-k3-k4, k5) * nchoosek(n-k1-k2-k3-k4-k5, k6) * ...
                                PPF^(k1) * PMO^(k2) * PSO^(k3) * PFB^(k4) * PDM^(k5) * PDN^(k6);
                        else
                            KeYongXing(n) = KeYongXing(n) + nchoosek(n, k1) * nchoosek(n-k1, k2) * nchoosek(n-k1-k2, k3) * ...
                                nchoosek(n-k1-k2-k3, k4) * nchoosek(n-k1-k2-k3-k4, k5) * nchoosek(n-k1-k2-k3-k4-k5, k6) * ...
                                PPF^(k1) * PMO^(k2) * PSO^(k3) * PFB^(k4) * PDM^(k5) * PDN^(k6) * k5 / (k5 + k1);
                        end
                    end
                end
            end
        end
    end
end

KeYongXing
