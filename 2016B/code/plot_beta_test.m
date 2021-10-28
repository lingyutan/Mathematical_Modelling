beta = 0 : 0.1 : 0.8;
Dt_beta = [0 40.5635 62.2275 94.0323 196.8760 371.7614 443.4536 479.1192 534.8220];
Dt0_beta = [0 65.0642 150.6432 208.7266 433.1610 635.8570 670.9200 689.5317 703.5961];
delta_Dt = Dt0_beta - Dt_beta;
plot(beta, Dt_beta, beta, Dt0_beta, 'LineWidth', 2);
hold on 
plot( beta, delta_Dt, ':', 'LineWidth', 2);
legend('开放小区', '不开放小区', '延时差值')
xlabel('车流量系数 beta');
ylabel('累积延时/s');