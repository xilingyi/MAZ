%% load data file saved after LASSO analysis
clearvars;close all;clc;
load('..\Step_2\zjn_lasso.mat')

%% Parallel Option
test = coeff;
index=1:length(test);
% diary('log.txt')
% diary off

for k=1:3 %Set range to k=1:3 to generate 1D, 2D and 3D
des_num = k;
n_c2=nchoosek(test,des_num);
sz=size(n_c2);

rmse=zeros(1,sz(1));

%parfor i=1:sz(1) uncomment for parallel execution 
for i=1:sz(1)    
    d_test=[D_Total_s(:,n_c2(i,:))];
    [fit_b,fit_info]=lasso(d_test,P_c,'Alpha',1,'Lambda',0,'Standardize',false);
    rmse(i) = sqrt((fit_info.MSE));
end
diary on
disp('----------------')
disp('No of descriptors')
disp('----------------')
disp(des_num)
% Find min RMSE location and run agclc

[M,I]=min(rmse);
set=n_c2(I,:);
[l_fit_b,l_fit_info]=lasso(d_f1(:,set),G_eV,'Alpha',1,'Lambda',0,'Standardize',false);

%% Test fit
sz=size(d_f1);
y_predicted=d_f1(:,set)*l_fit_b+l_fit_info.Intercept;
MAE=mean(abs(G_eV-y_predicted));
MaxAE=max(abs(G_eV-y_predicted));

%
disp('lowest RMSE Index')
disp(I)
disp('lowest RMSE')
disp(rmse(I))
disp('MAE')
disp(MAE)
disp('MaxAE')
disp(MaxAE)
disp('Descriptors')
disp(h_f1(set)')
disp('Descriptor Index')
disp(set)
disp('Coefficients')
disp(l_fit_b);
disp('Intercept')
disp(l_fit_info.Intercept)
diary off

%% plot
figure1=figure;
y_lim_max=round(max([y_predicted' G_eV']))+2;
y_lim_min=round(min([y_predicted' G_eV']))-2;
plot([y_lim_min,y_lim_max],[y_lim_min,y_lim_max],'-',y_predicted,G_eV,'o');
hold on;
ylim([y_lim_min,y_lim_max]);xlim([y_lim_min,y_lim_max]);
xlabel('Predicted GH (eV)');ylabel('GH (eV)');
t = sprintf('%dD, RMSE = %f',des_num,rmse(I));
title(t)
fname=sprintf('%dD.jpg', des_num);
saveas(figure1,fname);
wdata=[G_eV y_predicted];
fname1=sprintf('%dD.txt', des_num);
dlmwrite(fname1,wdata,'delimiter','\t','precision','%.6f');
end

% save('result.mat')
