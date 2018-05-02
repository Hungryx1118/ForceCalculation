
%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Copyright                           %
%     This code is developed by Jianhui Li     %
%%%%%%%%%%%%%%%%%%%%%%%%%

%% ���������ϵ�����������Իع�
% ����ת��Ϊ��ֵ6000rpm���ı�����ٶȣ��Ӷ�ʵ�ָı�ÿ�ݽ�������
clc
clear
close all

load force      % ����ʵ�����������ݣ�Ϊ.mat�ļ�����������5�鲻ͬÿ�ݽ������£�1s�ڵ�3������������

t1 = 0;         % ��ʼʱ��
t2 = 1;         % ����ʱ��
r = 0.0001;     % ����Ƶ��
t = t1:r:t2;    

% ע�ⷽ���Ƚ�����������ο���X�������Ӧ���жϴ�ʱ�Ĳ����Ƿ�����ο�����֮��Ĺ�ϵ
% ������������������ο������Ӧ��Ҫ��ţ��෴�Ĳ��ñ�ţ���Ϊ��ע���ڵ��ߣ�
% �������������뷴������֮��Ĺ�ϵ
% ��������ƽ�ţ��Ӳ�����β����ǰ����ƽ������ʳָָ���Լ���Ĵָ��ʳָ����ָ��Ϊ90�ȣ��ֱ��������ǵ�X��Y��Z������

% �����У����ڲ����ǰڷ�ԭ�򣬲ο�X����Ϊ������Y���򣬲ο�Y����Ϊ������X���򣬲ο�Z����Ϊ������Z����
% �������ı���ţ�ֻ��Ե�X��Y


%%   ʵ�ʲ���

% ��ʵ��ʵ�ʲ����У���ȡʵ�ʲ����źţ��������ƽ��ֵ
% ����Ϊ����ʾ���㣬�õ��Ǽ����źż���������ʵ���ź�
% ���Ժ��������ʵ������У�Ӧ��ȡʵ���źż������ľ�ֵ
% ��������ģ���㹻��ȷ������£����Եõ���Ϊ��ȷ����Ͻ��
% Ȼ����Ϻ��������ϵ����Ϊ�����������µ�������ϵ��
% ����ʵ�ʲ���Ӧ����ֱ�ӵ���ʵ�����ݼ���ƽ������Ȼ��ͨ�����Իع�ķ����õ�ϳ����ϵ��
% ������ѧģ����Ȼ�����������ϵ���Ĺ��̲��޹�ϵ�����侫ȷ��ģ����
% ������ϵ��ʶ��������ǰ��

% % % % % ������������
b = 3;                          % axial depth, mm �����������
FT = [0.025 0.05 0.075 0.1 0.125];  % feed per tooth values, mm/tooth ÿ�ݽ�������
% % % % 
% % % % %��ϳ
% % % % phis = 0;                       % cut start angle, deg
% % % % phie = 180;                     % cut exit angle, deg
% % % % 
% % % % % ���嵶�߲���
% % % % gamma = 45;   % helix angle, deg
% % % % d = 16;                         % cutter diameter, mm
Nt = 2;                         % number of teeth, int ���߳���
% % % % omega = 6000;                   % spindle speed, rpm
% % % % 
% % % % mean_Fx = zeros(1, length(FT));%ÿ��ʵ���ƽ����ֵ һ���������������ʵ��ֵ
% % % % mean_Fy = zeros(1, length(FT));
% % % % mean_Fz = zeros(1, length(FT));
% % % % 
% % % % mean_Fx(1) = mean(Fx_300); % ��¼ÿ��������������õ���ƽ����
% % % % mean_Fy(1) = mean(Fy_300);
% % % % mean_Fz(1) = mean(Fz_300);
% % % % 
% % % % mean_Fx(2) = mean(Fx_600); % ��¼ÿ��������������õ���ƽ����
% % % % mean_Fy(2) = mean(Fy_600);
% % % % mean_Fz(2) = mean(Fz_600);
% % % % 
% % % % mean_Fx(3) = mean(Fx_900); % ��¼ÿ��������������õ���ƽ����
% % % % mean_Fy(3) = mean(Fy_900);
% % % % mean_Fz(3) = mean(Fz_900);
% % % % 
% % % % mean_Fx(4) = mean(Fx_1200); % ��¼ÿ��������������õ���ƽ����
% % % % mean_Fy(4) = mean(Fy_1200);
% % % % mean_Fz(4) = mean(Fz_1200);
% % % % 
% % % % mean_Fx(5) = mean(Fx_1500); % ��¼ÿ��������������õ���ƽ����
% % % % mean_Fy(5) = mean(Fy_1500);
% % % % mean_Fz(5) = mean(Fz_1500);

% % % figure(1)
% % % plot(tooth_angle, Force_x, 'r:', tooth_angle, Force_y, 'b--', tooth_angle, Force_z, 'k')
% % % axis([0 360 -600 1200])
% % % 
% % % grid on  
% % % 
% % % L1=legend('\fontsize{14}\fontname{Times New Roman}\itF_x ','\fontsize{14}\fontname{Times New Roman}\itF_y ','\fontsize{14}\fontname{Times New Roman}\itF_z ','location','northwest');
% % % set(L1,'Position',[0.47596812596395 0.620708350273608 0.117331854029425 0.269564407316218]);
% % % set(gca,'FontSize', 14 ,'FontName', 'Times New Roman')
% % % set(gcf,'unit','centimeters','position',[0 17 13.53 9.03],'color','white');%��Ӧword��13.5,9��
% % % title('\fontsize{14}Cutting Force')
% % % xlabel('\fontsize{14}\fontname{Times New Roman}\it\phi \rm/ ��')
% % % ylabel('\fontsize{14}\fontname{Times New Roman}\itF \rm/ N')
% % % hold on

%%
mean_Fx = zeros(1, length(FT));%ÿ��ʵ���ƽ����ֵ һ���������������ʵ��ֵ
mean_Fy = zeros(1, length(FT));
mean_Fz = zeros(1, length(FT));

mean_Fx(1) = mean(Fx_300); 
mean_Fy(1) = mean(Fy_300);
mean_Fz(1) = mean(Fz_300);

mean_Fx(2) = mean(Fx_600); 
mean_Fy(2) = mean(Fy_600);
mean_Fz(2) = mean(Fz_600);

mean_Fx(3) = mean(Fx_900);
mean_Fy(3) = mean(Fy_900);
mean_Fz(3) = mean(Fz_900);

mean_Fx(4) = mean(Fx_1200);
mean_Fy(4) = mean(Fy_1200);
mean_Fz(4) = mean(Fz_1200);

mean_Fx(5) = mean(Fx_1500); 
mean_Fy(5) = mean(Fy_1500);
mean_Fz(5) = mean(Fz_1500);

figure(1)
plot(t, Fx_300, 'r', t, Fy_300, 'g', t, Fz_300, 'b')
axis([0 0.1 -800 1000])
grid on  
L2=legend('\fontsize{14}\fontname{Times New Roman}\itF_x ','\fontsize{14}\fontname{Times New Roman}\itF_y ','\fontsize{14}\fontname{Times New Roman}\itF_z ','location','northwest');
set(L2,'Position',[0.777119887481565 0.611918206309045 0.117331854029425 0.269564407316218]);
set(gca,'FontSize', 14 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 11.8 13.53 9.03],'color','white');%��Ӧword��13.5,9��
title('\fontsize{14}\fontname{Times New Roman}Cutting Force    \itf_c\rm = 0.025mm')
xlabel('\fontsize{14}\fontname{Times New Roman}\itt \rm/ s')
ylabel('\fontsize{14}\fontname{Times New Roman}\itF \rm/ N')

hold on

figure(2)
plot(t, Fx_600, 'r', t, Fy_600, 'g', t, Fz_600, 'b')
axis([0 0.1 -800 1000])
grid on  
L2=legend('\fontsize{14}\fontname{Times New Roman}\itF_x ','\fontsize{14}\fontname{Times New Roman}\itF_y ','\fontsize{14}\fontname{Times New Roman}\itF_z ','location','northwest');
set(L2,'Position',[0.777119887481565 0.611918206309045 0.117331854029425 0.269564407316218]);
set(gca,'FontSize', 14 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[14 11.8 13.53 9.03],'color','white');%��Ӧword��13.5,9��
title('\fontsize{14}\fontname{Times New Roman}Cutting Force    \itf_c\rm = 0.05mm')
xlabel('\fontsize{14}\fontname{Times New Roman}\itt \rm/ s')
ylabel('\fontsize{14}\fontname{Times New Roman}\itF \rm/ N')
hold on

figure(3)
plot(t, Fx_900, 'r', t, Fy_900, 'g', t, Fz_900, 'b')
axis([0 0.1 -800 1000])
grid on  
L2=legend('\fontsize{14}\fontname{Times New Roman}\itF_x ','\fontsize{14}\fontname{Times New Roman}\itF_y ','\fontsize{14}\fontname{Times New Roman}\itF_z ','location','northwest');
set(L2,'Position',[0.777119887481565 0.611918206309045 0.117331854029425 0.269564407316218]);
set(gca,'FontSize', 14 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 0.6 13.53 9.03],'color','white');%��Ӧword��13.5,9��
title('\fontsize{14}\fontname{Times New Roman}Cutting Force    \itf_c\rm = 0.075mm')
xlabel('\fontsize{14}\fontname{Times New Roman}\itt \rm/ s')
ylabel('\fontsize{14}\fontname{Times New Roman}\itF \rm/ N')
hold on

figure(4)
plot(t, Fx_1200, 'r', t, Fy_1200, 'g', t, Fz_1200, 'b')
axis([0 0.1 -800 1000])
grid on  
L2=legend('\fontsize{14}\fontname{Times New Roman}\itF_x ','\fontsize{14}\fontname{Times New Roman}\itF_y ','\fontsize{14}\fontname{Times New Roman}\itF_z ','location','northwest');
set(L2,'Position',[0.777119887481565 0.611918206309045 0.117331854029425 0.269564407316218]);
set(gca,'FontSize', 14 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[14 0.6 13.53 9.03],'color','white');%��Ӧword��13.5,9��
title('\fontsize{14}\fontname{Times New Roman}Cutting Force    \itf_c\rm = 0.1mm')
xlabel('\fontsize{14}\fontname{Times New Roman}\itt \rm/ s')
ylabel('\fontsize{14}\fontname{Times New Roman}\itF \rm/ N')
hold on

figure(5)
plot(t, Fx_1500, 'r', t, Fy_1500, 'g', t, Fz_1500, 'b')
axis([0 0.1 -800 1000])
grid on  
L2=legend('\fontsize{14}\fontname{Times New Roman}\itF_x ','\fontsize{14}\fontname{Times New Roman}\itF_y ','\fontsize{14}\fontname{Times New Roman}\itF_z ','location','northwest');
set(L2,'Position',[0.777119887481565 0.611918206309045 0.117331854029425 0.269564407316218]);
set(gca,'FontSize', 14 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[28 0.6 13.53 9.03],'color','white');%��Ӧword��13.5,9��
title('\fontsize{14}\fontname{Times New Roman}Cutting Force    \itf_c\rm = 0.125mm')
xlabel('\fontsize{14}\fontname{Times New Roman}\itt \rm/ s')
ylabel('\fontsize{14}\fontname{Times New Roman}\itF \rm/ N')
hold on

% nΪʵ������ 

% linear regression�����Իع�
n = length(FT);  
a1x = (n*sum(FT.*mean_Fx) - sum(FT)*sum(mean_Fx))/(n*sum(FT.^2) - (sum(FT))^2);
a0x = mean(mean_Fx) - a1x*mean(FT);

Ktc_fit = 4*a1x/(Nt*b)              %���ռ����ϵ��
Kte_fit = pi*a0x/(Nt*b)

a1y = (n*sum(FT.*mean_Fy) - sum(FT)*sum(mean_Fy))/(n*sum(FT.^2) - (sum(FT))^2);
a0y = mean(mean_Fy) - a1y*mean(FT);
Krc_fit = -4*a1y/(Nt*b)
Kre_fit = -pi*a0y/(Nt*b)
% ��ʽ�ο�Altintas�ġ�Manufacturing Automation�� P47
% ���ڴ˴�X��Y���򻥻������Թ�ʽ�е�ϵ����Ӧ����

a1z = (n*sum(FT.*mean_Fz) - sum(FT)*sum(mean_Fz))/(n*sum(FT.^2) - (sum(FT))^2);
a0z = mean(mean_Fz) - a1z*mean(FT);
Kac_fit = pi*a1z/(Nt*b)
Kae_fit = 2*a0z/(Nt*b)

figure(6)
plot(FT, mean_Fx, 'ro', FT, mean_Fy, 'gs', FT, mean_Fz, 'b^')
hold on
% axis([0 0.3 -125 525])
% xlabel('f_t (mm/tooth)')
% ylabel('Mean Force (N)')
% best fit lines
plot(FT, a0x+a1x*FT, 'r', FT, a0y+a1y*FT, 'g', FT, a0z+a1z*FT, 'b')

grid on  
L3=legend('\fontsize{14}\fontname{Times New Roman}\itx ','\fontsize{14}\fontname{Times New Roman}\ity ','\fontsize{14}\fontname{Times New Roman}\itz ','location','northwest');
set(L3,'Position',[0.790098857533526 0.686580607467004 0.0976562494761311 0.208211137926823]);
set(gca,'FontSize', 14 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[28 11.8 13.53 9.03],'color','white');%��Ӧword��13.5,9��
title('\fontsize{14}Average Cutting Force')
xlabel('\fontsize{14}\fontname{Times New Roman}\it f_t \rm/ mm��tooth^{-1}')
ylabel('\fontsize{14}\fontname{Times New Roman}\itFm \rm/ N')

% coefficients of determination �������Իع�ĺû�
rx2 = (sum((mean_Fx - mean(mean_Fx)).^2) - sum((mean_Fx - a0x - a1x*FT).^2))/(sum((mean_Fx - mean(mean_Fx)).^2)) %�������Իع�û���ϵ��
ry2 = (sum((mean_Fy - mean(mean_Fy)).^2) - sum((mean_Fy - a0y - a1y*FT).^2))/(sum((mean_Fy - mean(mean_Fy)).^2))
rz2 = (sum((mean_Fz - mean(mean_Fz)).^2) - sum((mean_Fz - a0z - a1z*FT).^2))/(sum((mean_Fz - mean(mean_Fz)).^2))
