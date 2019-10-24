% Read .csv file and save the cutting force data as .mat file
clc
clear 
close all

% Notion Here the x, y and z direction were changed according to the
% feeding direction.
% Represent the feed speed F = 300mm/min, 3 direction cutting forces in 1s, Spindle speed 6000rpm, Axial cutting depth is 3mm, Slotting
Fy_300 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f300ap3ae25.csv', '6-n6000f300ap3ae25', 'B21:B10021'))';%��ȡExcel�����ļ�
Fx_300 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f300ap3ae25.csv', '6-n6000f300ap3ae25', 'C21:C10021'))';%��ȡExcel�����ļ�
Fz_300 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f300ap3ae25.csv', '6-n6000f300ap3ae25', 'D21:D10021'))';%��ȡExcel�����ļ�

% Represent the feed speed F = 600mm/min, 3 direction cutting forces in 1s.
Fy_600 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f600ap3ae25.csv', '6-n6000f600ap3ae25', 'B21:B10021'))';%��ȡExcel�����ļ�
Fx_600 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f600ap3ae25.csv', '6-n6000f600ap3ae25', 'C21:C10021'))';%��ȡExcel�����ļ�
Fz_600 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f600ap3ae25.csv', '6-n6000f600ap3ae25', 'D21:D10021'))';%��ȡExcel�����ļ�

% Represent the feed speed F = 900mm/min, 3 direction cutting forces in 1s.
Fy_900 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f900ap3ae25.csv', '6-n6000f900ap3ae25', 'B21:B10021'))';%��ȡExcel�����ļ�
Fx_900 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f900ap3ae25.csv', '6-n6000f900ap3ae25', 'C21:C10021'))';%��ȡExcel�����ļ�
Fz_900 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f900ap3ae25.csv', '6-n6000f900ap3ae25', 'D21:D10021'))';%��ȡExcel�����ļ�

% Represent the feed speed F = 1200mm/min, 3 direction cutting forces in 1s.
Fy_1200 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f1200ap3ae25.csv', '6-n6000f1200ap3ae25', 'B21:B10021'))';%��ȡExcel�����ļ�
Fx_1200 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f1200ap3ae25.csv', '6-n6000f1200ap3ae25', 'C21:C10021'))';%��ȡExcel�����ļ�
Fz_1200 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f1200ap3ae25.csv', '6-n6000f1200ap3ae25', 'D21:D10021'))';%��ȡExcel�����ļ�

% Represent the feed speed F = 1500mm/min, 3 direction cutting forces in 1s.
Fy_1500 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f1500ap3ae25.csv', '6-n6000f1500ap3ae25', 'B21:B10021'))';%��ȡExcel�����ļ�
Fx_1500 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f1500ap3ae25.csv', '6-n6000f1500ap3ae25', 'C21:C10021'))';%��ȡExcel�����ļ�
Fz_1500 = (xlsread('C:\Work\�ܽ�\����\��������ģ��������ϵ��ʶ�𷽷�\������ϵ��ʶ�����Ӻ�˵��\Flat milling tool\6-n6000f1500ap3ae25.csv', '6-n6000f1500ap3ae25', 'D21:D10021'))';%��ȡExcel�����ļ�

% Save as force.mat
save ('force','Fx_300','Fy_300','Fz_300','Fx_600','Fy_600','Fz_600','Fx_900','Fy_900','Fz_900','Fx_1200','Fy_1200','Fz_1200','Fx_1500','Fy_1500','Fz_1500')
