%% Using linear regression method to Calculate Cutting Coefficient
% The spindle speed is constant, change the feed speed that change the feed per toot
% Only for flat-end milling

% Reference：
% Schmitz, T. L., & Smith, K. S. (2009). Machining Dynamics.
% (Intergovernmental Panel on Climate Change, Ed.), 
% springer. Boston, MA: Springer US. 
% https://doi.org/10.1007/978-0-387-09645-2
% P165

clc
clear
close all

load force   % Import cutting force data .mat generated by readdata.m which include 5 groups 3-direction force in different feed speed.

t1 = 0;         % Start time
t2 = 1;         % End time
r = 0.0001;     % Sampling time s , Depend on the measured data.
t = t1:r:t2;    

% Note! The Direction. 
% First, Take the feeding direction as the reference X direction, 

% Put the dynometer on the table flatwise, look from the cable side,
% Raise right hand, stretch out the thumb, forefinger and midfinger
% orthogonally，which represent the positive X, Y and Z direction of Dynometer, respectively.
% So, some changes should be made to keep the results correctly, including
% the sign of the value.

%%  Real Operation

% Obtain the measured force signal and calculate the average cutting force

% Define the cutting parameter, spindle speed×tooth number×feed per tooth = feeding speed
a = 3;                              % Axial cutting depth mm
FT = [0.025 0.05 0.075 0.1 0.125];  % Tooth number(ascending order) mm/tooth
Nt = 2;                             % Tooth number

%% The average force of each group
mean_Fx = zeros(1, length(FT));
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

%% Plot five groups cutting foeces
figure(1)
plot(t, Fx_300, 'r', t, Fy_300, 'g', t, Fz_300, 'b')
axis([0 0.1 -800 1000])
grid on  
L2=legend('\fontsize{14}\fontname{Times New Roman}\itF_x ','\fontsize{14}\fontname{Times New Roman}\itF_y ','\fontsize{14}\fontname{Times New Roman}\itF_z ','location','northwest');
set(L2,'Position',[0.777119887481565 0.611918206309045 0.117331854029425 0.269564407316218]);
set(gca,'FontSize', 14 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 11.8 13.53 9.03],'color','white');%对应word（13.5,9）
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
set(gcf,'unit','centimeters','position',[14 11.8 13.53 9.03],'color','white');%对应word（13.5,9）
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
set(gcf,'unit','centimeters','position',[0 0.6 13.53 9.03],'color','white');%对应word（13.5,9）
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
set(gcf,'unit','centimeters','position',[14 0.6 13.53 9.03],'color','white');% word（13.5,9）
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
set(gcf,'unit','centimeters','position',[28 0.6 13.53 9.03],'color','white');% word（13.5,9）
title('\fontsize{14}\fontname{Times New Roman}Cutting Force    \itf_c\rm = 0.125mm')
xlabel('\fontsize{14}\fontname{Times New Roman}\itt \rm/ s')
ylabel('\fontsize{14}\fontname{Times New Roman}\itF \rm/ N')
hold on

%% n is the group number 
% Linear regression
n = length(FT);  

a1y = (n*sum(FT.*mean_Fy) - sum(FT)*sum(mean_Fy))/(n*sum(FT.^2) - (sum(FT))^2);
a0y = mean(mean_Fy) - a1y*mean(FT);
Ktc_fit = 4*a1y/(Nt*a)          % Radial cutting coefficient N/mm^2
Kte_fit = pi*a0y/(Nt*a)         % Radial plough coefficient N/mm 

a1x = (n*sum(FT.*mean_Fx) - sum(FT)*sum(mean_Fx))/(n*sum(FT.^2) - (sum(FT))^2);
a0x = mean(mean_Fx) - a1x*mean(FT);

Krc_fit = -4*a1x/(Nt*a)           % Tangential cutting coefficient N/mm^2
Kre_fit = -pi*a0x/(Nt*a)          % Tangential plough coefficient N/mm                               

% Refer to Altintas 《Manufacturing Automation》 P47
% Altintas, Y. (2012). Manufacturing Automation: 
% Metal Cutting Mechanics, Machine Tool Vibrations, and CNC Design. 
% Applied Mechanics Reviews (Vol. 54). https://doi.org/10.1115/1.1399383
% Here we change the direction of X and Y, because of the experiment setup.

a1z = (n*sum(FT.*mean_Fz) - sum(FT)*sum(mean_Fz))/(n*sum(FT.^2) - (sum(FT))^2);
a0z = mean(mean_Fz) - a1z*mean(FT);
Kac_fit = pi*a1z/(Nt*a)         % Axial cutting coefficient N/mm^2
Kae_fit = 2*a0z/(Nt*a)          % Axial plough coefficient N/mm

%% Plot the fitting stright line
figure(6)
plot(FT, mean_Fx, 'ro', FT, mean_Fy, 'gs', FT, mean_Fz, 'b^')
hold on
plot(FT, a0x+a1x*FT, 'r', FT, a0y+a1y*FT, 'g', FT, a0z+a1z*FT, 'b')
grid on  
L3=legend('\fontsize{14}\fontname{Times New Roman}\itx ','\fontsize{14}\fontname{Times New Roman}\ity ','\fontsize{14}\fontname{Times New Roman}\itz ','location','northwest');
set(L3,'Position',[0.790098857533526 0.686580607467004 0.0976562494761311 0.208211137926823]);
set(gca,'FontSize', 14 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[28 11.8 13.53 9.03],'color','white');% word（13.5,9）
title('\fontsize{14}Average Cutting Force')
xlabel('\fontsize{14}\fontname{Times New Roman}\it f_t \rm/ mm·tooth^{-1}')
ylabel('\fontsize{14}\fontname{Times New Roman}\itFm \rm/ N')

%% Evaluating the quality of linear regression
% coefficients of determination 
% rx2 = (sum((mean_Fx - mean(mean_Fx)).^2) - sum((mean_Fx - a0x - a1x*FT).^2))/(sum((mean_Fx - mean(mean_Fx)).^2)) 
% ry2 = (sum((mean_Fy - mean(mean_Fy)).^2) - sum((mean_Fy - a0y - a1y*FT).^2))/(sum((mean_Fy - mean(mean_Fy)).^2))
% rz2 = (sum((mean_Fz - mean(mean_Fz)).^2) - sum((mean_Fz - a0z - a1z*FT).^2))/(sum((mean_Fz - mean(mean_Fz)).^2))