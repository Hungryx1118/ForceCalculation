function [Time,Fx,Fy,Fz]=CommonForceFull(ap,ae,speed,feed,t,dt,dz,D,operation,Nt,R,Rr,Rz,beta0,alpha,gama,Hx,Lead,Ktc,Krc,Kac,Kte,Kre,Kae)
%%ͨ�õ���ϳ�����������ֱ���ߵ�ʱ��ϳ�������㣬������������
% ׶ͷ��Բ�����ֽ���M
Mr = (Rz*tan(alpha)+Rr)/(((tan(alpha))^2)+1);
if alpha >= 0
    Mz = Mr*tan(alpha);
else
    Mz =-Mr*tan(alpha);
end
%Բ����׶�粿�ֽ���N
u  = (D/2)*(1-tan(alpha)*tan(gama));
Nz = ((Rr-u)*tan(gama)+Rz)/(((tan(gama))^2)+1);
Nr = u +Nz*tan(gama);

% �����Ƕ�
phis = acos((D/2 - ae)/(D/2));  % (rad) the absolute angle of cutting ���߽���Ƕ�
if operation == 0             %��ϳ 
    phist = 0;                %����� rad
    phiex = phist + phis;     %�г��� rad
else                          %˳ϳ
    phiex = pi;               %�г��� rad
    phist = phiex - phis;     %����� rad
end   
%��������
phip=2*pi/Nt;         %���߳ݼ�� rad
c =  feed/Nt/speed;   %c������ mm/��                                     
%�������
K = t/dt ;         %������ֲ���
L = ap/dz ;        %������ֲ���
%��ʼ��
F  = zeros(floor(K),1);    %��������
phi= zeros(floor(K),1);  %λ�ý�
Fx = zeros(floor(K),1);   
Fy = zeros(floor(K),1);
Fz = zeros(floor(K),1);   %X��Y��Z������ĺ���
Ft = zeros(floor(K),1);   %��������
Fr = zeros(floor(K),1);   %�ܷ�����
Fa = zeros(floor(K),1);   %��������
T  = zeros(floor(K),1);    %��������
Time=zeros(floor(K),1); %ʱ������
%������תѭ����ʼ
for i=1:floor(K)        %���ߵ�i����ת
    phi(i)=phist+(i-1)*2*pi*speed*dt/60;%�����i�����ߵ�һ�����ݶ˲��Ľ�λ��
    %���ߵ���ѭ����ʼ
    for k=1:Nt%��k������
        phi1=phi(i)+(k-1)*phip;            %�����k�����ݶ˲��Ľ�λ��
        %������������΢Ԫѭ����ʼ
        for j=1:L   %��k�������ϵĵ�j��΢Ԫ
            Zj=j*dz;    %��j��΢Ԫ������߶�,ע�������ͷ��Zp����Ϊ�㣬�����ʹ��dS����ʱ�������
            if alpha >0 && R>0    %���׶ͷͻ��������Բ�����ֵ������ͨ����ϳ����
                rs=Mr/20;
                %���弸���ֽ���ͺ��
                phi1s=log(rs)*tan(beta0)/cos(alpha); % ׶ͷ���ͺ�ǳ�ʼֵ
                phi1e=log(Mr)*tan(beta0)/cos(alpha)-phi1s; % ׶ͷ�������ͺ��
                phias= (R+Mz-Rz)*tan(beta0)/R;%Բ�������ͺ�ǳ�ʼֵ
                phiae= (R+Nz-Rz)*tan(beta0)/R-phias+phi1e;%Բ�������ͺ������ֵ
                if Zj<Mz	%����׶ͷ����
                    Rj=Zj/tan(alpha);	%��j��΢Ԫ�ľ��򳤶�
                    if Rj>=rs   %����׶ͷ���ļ���
                        betaj=beta0;    %������������Ǽ���Ϊ�㶨 
                        phij=log(Zj*cot(alpha))*tan(betaj)/cos(alpha)-phi1s;%׶ͷ���ͺ��
                        phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                        %�Ƕ�����
                        phi2=phi2-2*pi*fix(phi2/2/pi);
                        if phi2<0                     
                            phi2=phi1+2*pi;              
                        end
                        %����΢Ԫ�ϵ������г���
                        P1=((Zj/tan(alpha))^2)*((tan(beta0)/Zj*cos(alpha))^2);
                        P2=((1/tan(alpha))^2);
                        dS=dz*sqrt(P1+P2+1);
                        %����ʵ���п�
                        ka=alpha;   %����Ӵ��ǣ��������з����к��й�
                        db=dz/sin(ka);  %�������
                    else
                        betaj=beta0;    %������������Ǽ���Ϊ�㶨
                        phij=log(Zj*cot(alpha))*tan(betaj)/cos(alpha);%׶ͷ���ͺ��
                        phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                        %�Ƕ�����
                        phi2=phi2-2*pi*fix(phi2/2/pi);
                        if phi2<0                     
                            phi2=phi1+2*pi;              
                        end
                        dS=0;
                        ka=0;
                        db=0;
                    end
                elseif Zj>=Mz && Zj< Nz %����Բ�����ֵļ���
                    Rj=sqrt(R^2-(R-Zj)^2)+Rr;%��j��΢Ԫ�ľ��򳤶�
                    betaj=atan(((Rj-Rr)*tan(beta0))/R);%��j��΢Ԫ����������
                    phij = (R+Zj-Rz)*tan(beta0)/R-phias+phi1e;%��j��΢Ԫ�ľ����ͺ��
                    phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                    %�Ƕ�����
                    phi2=phi2-2*pi*fix(phi2/2/pi);
                    if phi2<0                     
                        phi2=phi1+2*pi;              
                    end
                    %����΢Ԫ�ϵ������г���
                    P1=((sqrt(R^2-(R-Zj)^2)+Rr)^2)*(((tan(beta0)/R))^2);
                    P2=((Rz-Zj)^2)/(R^2-(Rz-Zj)^2);
                    dS=dz*sqrt(P1+P2+1);
                    %����ʵ���п�
                    ka=asin((Rj-Rr)/R);  %����Ӵ��ǣ��������з����к��й�  
                    db=dz/sin(ka);  %�������
                elseif Zj>=Nz %����׶�粿�ֵļ��� 
                    Rj=u+Zj*tan(gama);  %��j��΢Ԫ�ľ��򳤶�
                    %����׶������������
                    if Hx==0  %������
                        betas=atan(2*pi*Nr/(Lead*cos(gama)));%����������
                        phij=(Zj-Nz)*tan(betas)/Nr+phiae;%��j��΢Ԫ�ľ����ͺ��
                        betaj=atan((phij-phiae)*Rj/(Zj-Nz));%�仯��������
                        phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                        %�Ƕ�����
                        phi2=phi2-2*pi*fix(phi2/2/pi);
                        if phi2<0                     
                            phi2=phi1+2*pi;              
                        end
                        %����΢Ԫ�ϵ������г���
                        P1=((u+Zj*tan(gama))^2)*((tan(betas)/Nr)^2);
                        P2=(tan(gama))^2;
                        dS=dz*sqrt(P1+P2+1);
                        %����ʵ���п�
                        ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                        db=dz/sin(ka);  %�������
                    else  %��������
                        betaj=beta0;        %��j��΢Ԫ����������
                        if gama == 0 
                            phi2s=0;
                            phij=(Zj-Nz)*tan(betaj)-phi2s+phiae;
                            phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                            %�Ƕ�����
                            phi2=phi2-2*pi*fix(phi2/2/pi);
                            if phi2<0                     
                                phi2=phi1+2*pi;              
                            end
                            %����΢Ԫ�ϵ������г���
                            P1=((u+Zj*tan(gama))^2)*((tan(betaj)/Nr)^2);
                            P2=(tan(gama))^2;
                            dS=dz*sqrt(P1+P2+1);
                            %����ʵ���п�
                            ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                            db=dz/sin(ka);  %�������
                        else %gama!=0
                            phi2s=log(Nr)*tan(betaj)/sin(gama);
                            phij=log(Nr-(Nz-Zj)*tan(gama))*tan(betaj)/sin(gama)-phi2s+phiae;
                            phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                            %�Ƕ�����
                            phi2=phi2-2*pi*fix(phi2/2/pi);
                            if phi2<0                     
                                phi2=phi1+2*pi;              
                            end
                            %����΢Ԫ�ϵ������г���
                            P1=((u+Zj*tan(gama))^2)*((tan(betaj)*tan(gama)/(sin(gama)*(Nr-(Nz-Zj)*tan(gama))))^2);
                            P2=(tan(gama))^2;
                            dS=dz*sqrt(P1+P2+1);
                            %����ʵ���п�
                            ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                            db=dz/sin(ka);  %�������
                        end
                    end
                end
            elseif alpha >0 && R==0 %���׶ͷͻ��������Բ�����ֵ������Բ׶��ϳ����
                rs=Mr/20;
                %���弸���ֽ���ͺ��
                phi1s=log(rs)*tan(beta0)/cos(alpha); % ׶ͷ���ͺ�ǳ�ʼֵ
                phi1e=log(Mr)*tan(beta0)/cos(alpha)-phi1s; % ׶ͷ�������ͺ��
%                 phias= 0;%Բ�������ͺ�ǳ�ʼֵ
                phiae= phi1e;%Բ�������ͺ������ֵ
                if Zj<Mz	%����׶ͷ����
                    Rj=Zj/tan(alpha);	%��j��΢Ԫ�ľ��򳤶�
                    if Rj>=rs   %����׶ͷ���ļ���
                        betaj=beta0;    %������������Ǽ���Ϊ�㶨 
                        phij=log(Zj*cot(alpha))*tan(betaj)/cos(alpha)-phi1s;%׶ͷ���ͺ��
                        phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                        %�Ƕ�����
                        phi2=phi2-2*pi*fix(phi2/2/pi);
                        if phi2<0                     
                            phi2=phi1+2*pi;              
                        end
                        %����΢Ԫ�ϵ������г���
                        P1=((Zj/tan(alpha))^2)*((tan(beta0)/Zj*cos(alpha))^2);
                        P2=((1/tan(alpha))^2);
                        dS=dz*sqrt(P1+P2+1);
                        %����ʵ���п�
                        ka=alpha;   %����Ӵ��ǣ��������з����к��й�
                        db=dz/sin(ka);  %�������
                    else
                        betaj=beta0;    %������������Ǽ���Ϊ�㶨
                        phij=log(Zj*cot(alpha))*tan(betaj)/cos(alpha);%׶ͷ���ͺ��
                        phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                        %�Ƕ�����
                        phi2=phi2-2*pi*fix(phi2/2/pi);
                        if phi2<0                     
                            phi2=phi1+2*pi;              
                        end
                        dS=0;
                        ka=0;
                        db=0;
                    end
                else  %ֱ�Ӷ���׶�粿�ֵļ��� 
                    Rj=u+Zj*tan(gama);  %��j��΢Ԫ�ľ��򳤶�
                    %����׶������������
                    if Hx==0  %������
                        betas=atan(2*pi*Nr/(Lead*cos(gama)));%����������
                        phij=(Zj-Nz)*tan(betas)/Nr+phiae;%��j��΢Ԫ�ľ����ͺ��
                        betaj=atan((phij-phiae)*Rj/(Zj-Nz));%�仯��������
                        phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                        %�Ƕ�����
                        phi2=phi2-2*pi*fix(phi2/2/pi);
                        if phi2<0                     
                            phi2=phi1+2*pi;              
                        end
                        %����΢Ԫ�ϵ������г���
                        P1=((u+Zj*tan(gama))^2)*((tan(betas)/Nr)^2);
                        P2=(tan(gama))^2;
                        dS=dz*sqrt(P1+P2+1);
                        %����ʵ���п�
                        ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                        db=dz/sin(ka);  %�������
                    else  %��������
                        betaj=beta0;        %��j��΢Ԫ����������
                        if gama == 0 
                            phi2s=0;
                            phij=(Zj-Nz)*tan(betaj)-phi2s+phiae;
                            phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                            %�Ƕ�����
                            phi2=phi2-2*pi*fix(phi2/2/pi);
                            if phi2<0                     
                                phi2=phi1+2*pi;              
                            end
                            %����΢Ԫ�ϵ������г���
                            P1=((u+Zj*tan(gama))^2)*((tan(betaj)/Nr)^2);
                            P2=(tan(gama))^2;
                            dS=dz*sqrt(P1+P2+1);
                            %����ʵ���п�
                            ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                            db=dz/sin(ka);  %�������
                        else %gama!=0
                            phi2s=log(Nr)*tan(betaj)/sin(gama);
                            phij=log(Nr-(Nz-Zj)*tan(gama))*tan(betaj)/sin(gama)-phi2s+phiae;
                            phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                            %�Ƕ�����
                            phi2=phi2-2*pi*fix(phi2/2/pi);
                            if phi2<0                     
                                phi2=phi1+2*pi;              
                            end
                            %����΢Ԫ�ϵ������г���
                            P1=((u+Zj*tan(gama))^2)*((tan(betaj)*tan(gama)/(sin(gama)*(Nr-(Nz-Zj)*tan(gama))))^2);
                            P2=(tan(gama))^2;
                            dS=dz*sqrt(P1+P2+1);
                            %����ʵ���п�
                            ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                            db=dz/sin(ka);  %�������
                        end
                    end
                end
            elseif alpha <=0 && R>0    %���׶ͷ��ͻ��������Բ�����ֵ��������ͷ����R����׶����ͷ����Բ����ϳ����
                %���弸���ֽ���ͺ��
%                 phi1s=0; % ׶ͷ���ͺ�ǳ�ʼֵ
                phi1e=0; % ׶ͷ�������ͺ��
                phias= 0;%Բ�������ͺ�ǳ�ʼֵ
                phiae= (R+Nz-Rz)*tan(beta0)/R;%Բ�������ͺ������ֵ
                if Zj< Nz %����Բ�����ֵļ���
                    Rj=sqrt(R^2-(R-Zj)^2)+Rr;%��j��΢Ԫ�ľ��򳤶�
                    betaj=atan(((Rj-Rr)*tan(beta0))/R);%��j��΢Ԫ����������
                    phij = (R+Zj-Rz)*tan(beta0)/R-phias+phi1e;%��j��΢Ԫ�ľ����ͺ��
                    phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                    %�Ƕ�����
                    phi2=phi2-2*pi*fix(phi2/2/pi);
                    if phi2<0                     
                        phi2=phi1+2*pi;              
                    end
                    %����΢Ԫ�ϵ������г���
                    P1=((sqrt(R^2-(R-Zj)^2)+Rr)^2)*(((tan(beta0)/R))^2);
                    P2=((Rz-Zj)^2)/(R^2-(Rz-Zj)^2);
                    dS=dz*sqrt(P1+P2+1);
                    %����ʵ���п�
                    ka=asin((Rj-Rr)/R);  %����Ӵ��ǣ��������з����к��й�  
                    db=dz/sin(ka);  %�������
                elseif Zj>=Nz %����׶�粿�ֵļ��� 
                    Rj=u+Zj*tan(gama);  %��j��΢Ԫ�ľ��򳤶�
                    %����׶������������
                    if Hx==0  %������
                        betas=atan(2*pi*Nr/(Lead*cos(gama)));%����������
                        phij=(Zj-Nz)*tan(betas)/Nr+phiae;%��j��΢Ԫ�ľ����ͺ��
                        betaj=atan((phij-phiae)*Rj/(Zj-Nz));%�仯��������
                        phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                        %�Ƕ�����
                        phi2=phi2-2*pi*fix(phi2/2/pi);
                        if phi2<0                     
                            phi2=phi1+2*pi;              
                        end
                        %����΢Ԫ�ϵ������г���
                        P1=((u+Zj*tan(gama))^2)*((tan(betas)/Nr)^2);
                        P2=(tan(gama))^2;
                        dS=dz*sqrt(P1+P2+1);
                        %����ʵ���п�
                        ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                        db=dz/sin(ka);  %�������
                    else  %��������
                        betaj=beta0;        %��j��΢Ԫ����������
                        if gama == 0 
                            phi2s=0;
                            phij=(Zj-Nz)*tan(betaj)-phi2s+phiae;
                            phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                            %�Ƕ�����
                            phi2=phi2-2*pi*fix(phi2/2/pi);
                            if phi2<0                     
                                phi2=phi1+2*pi;              
                            end
                            %����΢Ԫ�ϵ������г���
                            P1=((u+Zj*tan(gama))^2)*((tan(betaj)/Nr)^2);
                            P2=(tan(gama))^2;
                            dS=dz*sqrt(P1+P2+1);
                            %����ʵ���п�
                            ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                            db=dz/sin(ka);  %�������
                        else %gama!=0
                            phi2s=log(Nr)*tan(betaj)/sin(gama);
                            phij=log(Nr-(Nz-Zj)*tan(gama))*tan(betaj)/sin(gama)-phi2s+phiae;
                            phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                            %�Ƕ�����
                            phi2=phi2-2*pi*fix(phi2/2/pi);
                            if phi2<0                     
                                phi2=phi1+2*pi;              
                            end
                            %����΢Ԫ�ϵ������г���
                            P1=((u+Zj*tan(gama))^2)*((tan(betaj)*tan(gama)/(sin(gama)*(Nr-(Nz-Zj)*tan(gama))))^2);
                            P2=(tan(gama))^2;
                            dS=dz*sqrt(P1+P2+1);
                            %����ʵ���п�
                            ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                            db=dz/sin(ka);  %�������
                        end
                    end
                end
            elseif alpha <=0 && R==0    %���׶ͷ��ͻ��������Բ�����ֵ������ƽ�׵���׶����ϳ����
                %���弸���ֽ���ͺ��
%                 phi1s=0; % ׶ͷ���ͺ�ǳ�ʼֵ
                phi1e=0; % ׶ͷ�������ͺ��
%                 phias= 0;%Բ�������ͺ�ǳ�ʼֵ
                phiae= phi1e;%Բ�������ͺ������ֵ
                %ֱ�Ӷ���׶�粿�ֵļ��� 
                Rj=u+Zj*tan(gama);  %��j��΢Ԫ�ľ��򳤶�
                %����׶������������
                if Hx==0  %������
                    betas=atan(2*pi*Nr/(Lead*cos(gama)));%����������
                    phij=(Zj-Nz)*tan(betas)/Nr+phiae;%��j��΢Ԫ�ľ����ͺ��
                    betaj=atan((phij-phiae)*Rj/(Zj-Nz));%�仯��������
                    phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                    %�Ƕ�����
                    phi2=phi2-2*pi*fix(phi2/2/pi);
                    if phi2<0                     
                        phi2=phi1+2*pi;              
                    end
                    %����΢Ԫ�ϵ������г���
                    P1=((u+Zj*tan(gama))^2)*((tan(betas)/Nr)^2);
                    P2=(tan(gama))^2;
                    dS=dz*sqrt(P1+P2+1);
                    %����ʵ���п�
                    ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                    db=dz/sin(ka);  %�������
                else  %��������
                    betaj=beta0;        %��j��΢Ԫ����������
                    if gama == 0 
                        phi2s=0;
                        phij=(Zj-Nz)*tan(betaj)-phi2s+phiae;
                        phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                        %�Ƕ�����
                        phi2=phi2-2*pi*fix(phi2/2/pi);
                        if phi2<0                     
                            phi2=phi1+2*pi;              
                        end
                        %����΢Ԫ�ϵ������г���
                        P1=((u+Zj*tan(gama))^2)*((tan(betaj)/Nr)^2);
                        P2=(tan(gama))^2;
                        dS=dz*sqrt(P1+P2+1);
                        %����ʵ���п�
                        ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                        db=dz/sin(ka);  %�������
                    else %gama!=0
                        phi2s=log(Nr)*tan(betaj)/sin(gama);
                        phij=log(Nr-(Nz-Zj)*tan(gama))*tan(betaj)/sin(gama)-phi2s+phiae;
                        phi2 = phi1-phij;   %���µ�j��΢Ԫ�ĽӴ���
                        %�Ƕ�����
                        phi2=phi2-2*pi*fix(phi2/2/pi);
                        if phi2<0                     
                            phi2=phi1+2*pi;              
                        end
                        %����΢Ԫ�ϵ������г���
                        P1=((u+Zj*tan(gama))^2)*((tan(betaj)*tan(gama)/(sin(gama)*(Nr-(Nz-Zj)*tan(gama))))^2);
                        P2=(tan(gama))^2;
                        dS=dz*sqrt(P1+P2+1);
                        %����ʵ���п�
                        ka=pi/2-gama;  %����Ӵ��ǣ��������з����к��й�  
                        db=dz/sin(ka);  %�������
                    end        
                end
            end

            if  phist<=phi2&&phi2<=phiex    %�жϵ�ǰ����΢Ԫ�Ƿ��������
                h=c*sin(phi2)*sin(ka);%�������з�����к�
                
%                 dFt=Ktc*h*db/cos(betaj)+Kte*dS;
%                 dFr=Krc*h*db+Kre*dS;
%                 dFa=Kac*h*db*cos(betaj)+Kae*dS;

                dFt=Ktc*h*db+Kte*dS;
                dFr=Krc*h*db+Kre*dS;
                dFa=Kac*h*db+Kae*dS;

                dF=[dFt;dFr;dFa];

                M=[-cos(phi2) -sin(phi2)*sin(ka) -sin(phi2)*cos(ka);
                    sin(phi2) -cos(phi2)*sin(ka) -cos(phi2)*cos(ka);
                     0         cos(ka)           -sin(ka)];
                 
                dF1=M*dF;

                dFx=dF1(1);
                dFy=dF1(2);
                dFz=dF1(3);

                Ft(i)=Ft(i)+dFt;
                Fr(i)=Fr(i)+dFr;
                Fa(i)=Fa(i)+dFa;
                
                Fx(i)=Fx(i)+dFx;
                Fy(i)=Fy(i)+dFy;
                Fz(i)=Fz(i)+dFz;
            end
        end
    end
    F(i)=(Fx(i)^2+Fy(i)^2+Fz(i)^2)^0.5;
    T(i)=D/2*Ft(i)/1e3 ; %��������
    Time(i)=(i-1)*t/floor(K);
end
