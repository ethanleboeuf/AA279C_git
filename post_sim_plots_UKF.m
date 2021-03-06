%% Plotting Results from Sim with UKF
close all
n = length(t);
set(0,'DefaultLineMarkerSize',5)

mu_UKF(:, 1:4) = quat_corr(mu_UKF(:,1:4));
mu_p_UKF(:, 1:4) = quat_corr(mu_p_UKF(:, 1:4));
q_det = quat_corr(q_det_UKF);
[q] = quat_corr(q_out_UKF(:, 1:4));

t_UKF = t(1:(dt_UKF/dt):end);
for ii = 1:size(mu_UKF, 1)
    z4(:,:,ii) = error_ellipse(0, sigma_UKF(4,4,ii), .95);
    z_high4(ii) = max(z4(2, :, ii)) + mu_UKF(ii, 4);
    z_min4(ii) = min(z4(2, :, ii))+ mu_UKF(ii, 4);
    
    z1(:,:,ii) = error_ellipse(0, sigma_UKF(1,1,ii), .95);
    z_high1(ii) = max(z1(2, :, ii)) + mu_UKF(ii, 1);
    z_min1(ii) = min(z1(2, :, ii))+ mu_UKF(ii, 1);
    
    z2(:,:,ii) = error_ellipse(0, sigma_UKF(2,2,ii), .95);
    z_high2(ii) = max(z2(2, :, ii)) + mu_UKF(ii, 2);
    z_min2(ii) = min(z2(2, :, ii))+ mu_UKF(ii, 2);
    
    z3(:,:,ii) = error_ellipse(0, sigma_UKF(3,3,ii), .95);
    z_high3(ii) = max(z3(2, :, ii)) + mu_UKF(ii, 3);
    z_min3(ii) = min(z4(2, :, ii))+ mu_UKF(ii, 3);
end

figure()
subplot(4,1,1)
plot(t_UKF, [mu_UKF(:, 1)])
hold on
plot(t, q(:, 1),'--')
% plot(t(1:end), z_high1(1:end), 'b', 'HandleVisibility', 'off')
% plot(t(1:end), z_min1(1:end), 'b')
% plot(t(2:end), q_det(1:end-1, 1), 'b:')
grid on
ylabel('q_1')
hold off


subplot(4,1,2)
plot(t_UKF, [mu_UKF(:, 2)])
hold on
plot(t, q(:, 2),'--')
% plot(t(2:end), q_det(1:end-1, 2), 'b:')
grid on
ylabel('q_2')
hold off

subplot(4,1,3)
plot(t_UKF, [mu_UKF(:, 3)])
hold on
plot(t, q(:, 3),'--')
% plot(t(2:end), q_det(1:end-1, 3), 'b:' )
grid on
ylabel('q_3')
hold off

subplot(4,1,4)
plot(t_UKF, [mu_UKF(:, 4)])
hold on
plot(t, q(:, 4),'--')
% plot(t(2:end), q_det(1:end-1, 4), 'b:')
grid on
xlabel('time, seconds')
ylabel('q_4')
sgtitle('{\color{orange}Ground Truth Quaternion} and {\color{blue}Estimated Quaternion} vs. time'...
    ,'fontsize', 24)
hold off



figure()
% scatter([t; t(end)+dt], [NaN; mu_p(:, 4)], 'filled')
scatter(t_UKF, [mu_p_UKF(:, 2)], 'filled')
hold on
% scatter([t; t(end)+dt], [NaN; mu_UKF(:, 4)], 'filled')
scatter(t_UKF, [mu_UKF(:, 2)], 'filled')
plot(t, q(:, 2), 'k')
% plot(t, q_det(:, 4), 'b')
plot(t_UKF, z_high2(1:end), 'b', 'HandleVisibility', 'off')
plot(t_UKF, z_min2(1:end), 'b')
% for ii = 1:size(z, 3)-1
%     plot(z(1, :, ii) + t(ii+1), z(2, :, ii) + mu_UKF(ii,4))
% end
grid on
xlabel('time, seconds')
ylabel('q_2')
legend('Pre-fit', 'Post-fit', 'Ground Truth', '95% Confidence Bound')
hold off

figure()
plot(t(1:end), abs(q_det(1:end, 4) - q(1:end, 4)))
hold on
plot(t_UKF, abs(mu_UKF(1:end, 4) - q(1:dt_UKF/dt:end, 4)))
xlabel('time, seconds')
ylabel('Absolute Error')
if att_det_method == 1
    legend('q - method', 'UKF')
else
    legend('Deterministic Method', 'UKF')
end
hold off
% err_mean = [err_mean mean(abs(mu_UKF(1:end, 4) - q(1:dt_UKF/dt:end, 4)))];

figure()
plot(t, q_out(:, 5), 'k', t, q_out(:, 6), 'k', t, q_out(: ,7), 'k', 'LineWidth', 10)
hold on
plot(t_UKF, mu_UKF(:, 5),t_UKF, mu_UKF(:, 6), t_UKF, mu_UKF(:, 7))
legend('\omega_{x}', '\omega_{y}', '\omega_{z}', '\mu_{\omega_{x}}','\mu_{\omega_{y}}','\mu_{\omega_{z}}')
grid on
xlabel('time, seconds')
ylabel('$\mathbf{\vec{\omega}}, \mathrm{\frac{rad}{s}}$', 'Interpreter', 'latex')
title('$\mathbf{\vec{\omega}} \;\mathrm{over \;time}$', 'Interpreter', 'latex')
hold off

