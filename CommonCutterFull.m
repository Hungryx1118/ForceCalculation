%ͨ�õ���ϳ�����������ֱ���ߵ�ʱ��ϳ�������㣬��������������
clc
clear
close all

load 20170822 % ʵ�����ݣ�����ƽ�׵���R������ͷ��

%������ϵ��
Ktc=796.1 ; %����������ϵ��
Krc=168.8 ; %����������ϵ��
Kac=222 ;  %����������ϵ��
Kte=27.7 ;  %�����п���ϵ��
Kre=30.8 ;  %�����п���ϵ��
Kae=1.4 ;  %�����п���ϵ��

%���߼���
D=16;        %����ֱ��mm
beta0=(25/180)*pi; %������rad
Nt=2;                   %���߳���
alpha=0; %׶ͷ���rad
gama=0; %׶�����rad
R=3;                    %����Բ�ǰ뾶  
Rr=5;  %Բ��Բ�ľ��� mm 
Rz=3;  %Բ��Բ����� mm
Hx=0;  %׶��������Ϊ�����̣�����ȡ1����������
Lead=pi*D/tan(beta0);
%������ʽ
operation=1;            %˳ϳ

%��������
% ap = 1;  %�������� mm
ae = 16;  %�����п� mm  
speed=800;            %����ת�� rpm
feed=160;             %�����ٶ� mm/min

%�������
t=0.1;           %����ʱ�� s
dt=0.0001;       %ʱ�䲽�� s
dz=0.01;        %������ֲ��� mm

[Time,Fx_1,Fy_1,Fz_1]=CommonForceFull(1,ae,speed,feed,t,dt,dz,D,operation,Nt,R,Rr,Rz,beta0,alpha,gama,Hx,Lead,Ktc,Krc,Kac,Kte,Kre,Kae);
figure(1)
plot(Time,-Fy_1,'b',Time,-Fx_1,'r',Time,Fz_1,'g',Time,Fx_R_1(5040:5039+length(Time)),'b:',Time,Fy_R_1(5040:5039+length(Time)),'r:',Time,Fz_R_1(5040:5039+length(Time)),'g:','Linewidth',2)%����ʵ���н�������ΪY������涨��X����ͬ������X��Y����Ҫ�Ե�
legend('Fx Pre.','Fy Pre.','Fz Pre.','Fx Mea.','Fy Mea.','Fz Mea.')
hold on
plot([0,t], [0,0], '-k');
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 17 13.53 9.03]);%��Ӧword��13.5,9��
title('\fontsize{10.5}\fontname{����}��ͷ��������Ԥ����ʵ��  \fontname{Times New Roman}(\itap\rm=1 mm \itae\rm=16 mm)')
xlabel('\fontsize{10.5}\fontname{Times New Roman}\itt \rm/s')
ylabel('\fontsize{10.5}\fontname{Times New Roman}\itF \rm/N')

[Time,Fx_2,Fy_2,Fz_2]=CommonForceFull(2,ae,speed,feed,t,dt,dz,D,operation,Nt,R,Rr,Rz,beta0,alpha,gama,Hx,Lead,Ktc,Krc,Kac,Kte,Kre,Kae);
figure(2)
plot(Time,-Fy_2,'b',Time,-Fx_2,'r',Time,Fz_2,'g',Time,Fx_R_2(4942:4941+length(Time)),'b:',Time,Fy_R_2(4942:4941+length(Time)),'r:',Time,Fz_R_2(4942:4941+length(Time)),'g:','Linewidth',2)%����ʵ���н�������ΪY������涨��X����ͬ������X��Y����Ҫ�Ե�
legend('Fx Pre.','Fy Pre.','Fz Pre.','Fx Mea.','Fy Mea.','Fz Mea.')
hold on
plot([0,t], [0,0], '-k');
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 17 13.53 9.03]);%��Ӧword��13.5,9��
title('\fontsize{10.5}\fontname{����}��ͷ��������Ԥ����ʵ��  \fontname{Times New Roman}(\itap\rm=2 mm \itae\rm=16 mm)')
xlabel('\fontsize{10.5}\fontname{Times New Roman}\itt \rm/s')
ylabel('\fontsize{10.5}\fontname{Times New Roman}\itF \rm/N')

[Time,Fx_3,Fy_3,Fz_3]=CommonForceFull(3,ae,speed,feed,t,dt,dz,D,operation,Nt,R,Rr,Rz,beta0,alpha,gama,Hx,Lead,Ktc,Krc,Kac,Kte,Kre,Kae);
figure(3)
plot(Time,-Fy_3,'b',Time,-Fx_3,'r',Time,Fz_3,'g',Time,Fx_R_3(4902:4901+length(Time)),'b:',Time,Fy_R_3(4902:4901+length(Time)),'r:',Time,Fz_R_3(4902:4901+length(Time)),'g:','Linewidth',2)%����ʵ���н�������ΪY������涨��X����ͬ������X��Y����Ҫ�Ե�
legend('Fx Pre.','Fy Pre.','Fz Pre.','Fx Mea.','Fy Mea.','Fz Mea.')
hold on
plot([0,t], [0,0], '-k');
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 17 13.53 9.03]);%��Ӧword��13.5,9��
title('\fontsize{10.5}\fontname{����}��ͷ��������Ԥ����ʵ��  \fontname{Times New Roman}(\itap\rm=3 mm \itae\rm=16 mm)')
xlabel('\fontsize{10.5}\fontname{Times New Roman}\itt \rm/s')
ylabel('\fontsize{10.5}\fontname{Times New Roman}\itF \rm/N')

[Time,Fx_4,Fy_4,Fz_4]=CommonForceFull(4,ae,speed,feed,t,dt,dz,D,operation,Nt,R,Rr,Rz,beta0,alpha,gama,Hx,Lead,Ktc,Krc,Kac,Kte,Kre,Kae);
figure(4)
plot(Time,-Fy_4,'b',Time,-Fx_4,'r',Time,Fz_4,'g',Time,Fx_R_4(5086:5085+length(Time)),'b:',Time,Fy_R_4(5086:5085+length(Time)),'r:',Time,Fz_R_4(5086:5085+length(Time)),'g:','Linewidth',2)%����ʵ���н�������ΪY������涨��X����ͬ������X��Y����Ҫ�Ե�
legend('Fx Pre.','Fy Pre.','Fz Pre.','Fx Mea.','Fy Mea.','Fz Mea.')
hold on
plot([0,t], [0,0], '-k');
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 17 13.53 9.03]);%��Ӧword��13.5,9��
title('\fontsize{10.5}\fontname{����}��ͷ��������Ԥ����ʵ��  \fontname{Times New Roman}(\itap\rm=4 mm \itae\rm=16 mm)')
xlabel('\fontsize{10.5}\fontname{Times New Roman}\itt \rm/s')
ylabel('\fontsize{10.5}\fontname{Times New Roman}\itF \rm/N')

[Time,Fx_5,Fy_5,Fz_5]=CommonForceFull(5,ae,speed,feed,t,dt,dz,D,operation,Nt,R,Rr,Rz,beta0,alpha,gama,Hx,Lead,Ktc,Krc,Kac,Kte,Kre,Kae);
figure(5)
plot(Time,-Fy_5,'b',Time,-Fx_5,'r',Time,Fz_5,'g',Time,Fx_R_5(4703:4702+length(Time)),'b:',Time,Fy_R_5(4703:4702+length(Time)),'r:',Time,Fz_R_5(4703:4702+length(Time)),'g:','Linewidth',2)%����ʵ���н�������ΪY������涨��X����ͬ������X��Y����Ҫ�Ե�
legend('Fx Pre.','Fy Pre.','Fz Pre.','Fx Mea.','Fy Mea.','Fz Mea.')
hold on
plot([0,t], [0,0], '-k');
set(gca,'FontSize', 10.5 ,'FontName', 'Times New Roman')
set(gcf,'unit','centimeters','position',[0 17 13.53 9.03]);%��Ӧword��13.5,9��
title('\fontsize{10.5}\fontname{����}��ͷ��������Ԥ����ʵ��  \fontname{Times New Roman}(\itap\rm=5 mm \itae\rm=16 mm)')
xlabel('\fontsize{10.5}\fontname{Times New Roman}\itt \rm/s')
ylabel('\fontsize{10.5}\fontname{Times New Roman}\itF \rm/N')