%%
clearvars;close all;clc;

%% Import the data: GH Data
[~, ~, raw] = xlsread('list-MAZ-0.5.xlsx');
data = raw(2:end,:);
%raw = raw(2:92,:);
data(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),data)) = {''};
A = data(:,1);
G_eV = data(:,2);          % GH (eV)


%% Import the information of bader
q_M = data(:,3);           
q_A = data(:,4);            
q_Z = data(:,5);     
q_H = data(:,6);             

%% Import the information of bond distance
d_Z1H = data(:,7);   
d_AH = data(:,8); 
d_Z2H = data(:,9); 
d_MH = data(:,10);     

%% Import the information of d band
db_Hs = data(:,11);      
db_Zs = data(:,12);  
db_Zpy = data(:,13);  
db_Zpz = data(:,14);  
db_Zpx = data(:,15);  
db_As = data(:,16);  
db_Apy = data(:,17);  
db_Apz = data(:,18);  
db_Apx = data(:,19); 
db_Ms = data(:,20);  
db_Mpy = data(:,21);  
db_Mpz = data(:,22);  
db_Mpx = data(:,23); 
db_Mdxy = data(:,24);  
db_Mdyz = data(:,25);  
db_Mdz2 = data(:,26); 
db_Mdxz = data(:,27);  
db_Mdx2 = data(:,28);  

%% Import the information of electron number
en_Hs = data(:,29);      
en_Zs = data(:,30);  
en_Zpy = data(:,31);  
en_Zpz = data(:,32);  
en_Zpx = data(:,33);  
en_As = data(:,34);  
en_Apy = data(:,35);  
en_Apz = data(:,36);  
en_Apx = data(:,37); 
en_Ms = data(:,38);  
en_Mpy = data(:,39);  
en_Mpz = data(:,40);  
en_Mpx = data(:,41); 
en_Mdxy = data(:,42);  
en_Mdyz = data(:,43);  
en_Mdz2 = data(:,44); 
en_Mdxz = data(:,45);  
en_Mdx2 = data(:,46); 

%% Import the information of Pauling
p_Eg1 = data(:,47); 
p_lp1 = data(:,48); 
p_Ea1 = data(:,49); 
p_Eg2 = data(:,50); 
p_lp2 = data(:,51); 
p_Ea2 = data(:,52); 
p_Eg3 = data(:,53); 
p_lp3 = data(:,54); 
p_Ea3 = data(:,55); 

%% Import the information of Orial
o_homo1 = data(:,56); 
o_lumo1 = data(:,57); 
o_rod1 = data(:,58); 
o_rv1 = data(:,59); 
o_homo2 = data(:,60); 
o_lumo2 = data(:,61); 
o_rop2 = data(:,62); 
o_rv2 = data(:,63); 
o_homo3 = data(:,64); 
o_lumo3 = data(:,65); 
o_rop3 = data(:,66); 
o_rv3 = data(:,67); 

%% Import the information of Elemental Table
et_vl1 = data(:,68);
et_m1 = data(:,69);
et_vl2 = data(:,70);
et_m2 = data(:,71);
et_vl3 = data(:,72);
et_m3 = data(:,73);
% END OF IMPORT

%% Create D matrix
n_s=size(G_eV,1);
head_1={'q_M', 'q_A', 'q_Z', 'q_H', ...   
    'd_Z1H', 'd_AH', 'd_Z2H ', 'd_MH',...    
    'db_Hs', 'db_Zs','db_Zpy','db_Zpz','db_Zpx',... 
    'db_As', 'db_Apy','db_Apz','db_Apx',...
    'db_Ms', 'db_Mpy','db_Mpz','db_Mpx', 'db_Mdxy', 'db_Mdyz','db_Mdz2','db_Mdxz','db_Mdx2',...
    'en_Hs', 'en_Zs','en_Zpy','en_Zpz','en_Zpx',... 
    'en_As', 'en_Apy','en_Apz','en_Apx',...
    'en_Ms', 'en_Mpy','en_Mpz','en_Mpx', 'en_Mdxy', 'en_Mdyz','en_Mdz2','en_Mdxz','en_Mdx2',...
    'p_Eg1', 'p_lp1', 'p_Ea1', 'p_Eg2', 'p_lp2', 'p_Ea2', 'p_Eg3', 'p_lp3', 'p_Ea3',...
    'o_homo1', 'o_lumo1', 'o_rod1', 'o_rv1', 'o_homo2', 'o_lumo2', 'o_rop2', 'o_rv2', 'o_homo3', 'o_lumo3', 'o_rop3', 'o_rv3',...
    'et_vl1', 'et_m1', 'et_vl2', 'et_m2', 'et_vl3', 'et_m3'};
n_ap=size(head_1);
D_p1=[q_M q_A q_Z q_H ...   
    d_Z1H d_AH d_Z2H  d_MH...    
    db_Hs db_Zs db_Zpy db_Zpz db_Zpx... 
    db_As db_Apy db_Apz db_Apx...
    db_Ms db_Mpy db_Mpz db_Mpx db_Mdxy db_Mdyz db_Mdz2 db_Mdxz db_Mdx2...
    en_Hs en_Zs en_Zpy en_Zpz en_Zpx... 
    en_As en_Apy en_Apz en_Apx...
    en_Ms en_Mpy en_Mpz en_Mpx en_Mdxy en_Mdyz en_Mdz2 en_Mdxz en_Mdx2...
    p_Eg1 p_lp1 p_Ea1 p_Eg2 p_lp2 p_Ea2 p_Eg3 p_lp3 p_Ea3...
    o_homo1 o_lumo1 o_rod1 o_rv1 o_homo2 o_lumo2 o_rop2 o_rv2 o_homo3 o_lumo3 o_rop3 o_rv3...
    et_vl1 et_m1 et_vl2 et_m2 et_vl3 et_m3];
D_p1=cell2mat(D_p1);
% End of data import


%% information of element
D_P=D_p1(:,1:4);
h_P=head_1(1:4);
unit=ones(1,size(D_P,2));
% 1st stage
list={ '/absu'};
[d_f1,h_f1,u_f1]=genfeature2(D_P,h_P,unit,list,1);
% 2rd stage 
list={'^r'; '^I'; '^2'; '^3'};
[d_q,h_q,u_q]=genfeature(d_f1,h_f1,u_f1,list,1);

%%  the electron structure of element 
D_P=[D_p1(:,5:8)];
h_P=[head_1(5:8)];
unit=ones(1,size(D_P,2));
% Pre-Process
% 1st stage
list={'/absu'};
[d_f1,h_f1,u_f1]=genfeature2(D_P,h_P,unit,list,1);
% 2rd stage 
list={'^r'; '^I'; '^2'; '^3'};
[d_d,h_d,u_d]=genfeature(d_f1,h_f1,u_f1,list,1);

%% the charge transfer
D_P=D_p1(:,9:26);
h_P=head_1(9:26);
unit=ones(1,size(D_P,2));
list={ '/absu'};
[d_f1,h_f1,u_f1]=genfeature2(D_P,h_P,unit,list,1);
list = {'^r'; '^I'; '^2'; '^3'};
[d_bd,h_bd,u_bd]=genfeature(d_f1,h_f1,u_f1,list);

%% the geometry
D_P=D_p1(:,27:44);
h_P=head_1(27:44);
unit=ones(1,size(D_P,2));
list={ '/absu'};
[d_f1,h_f1,u_f1]=genfeature2(D_P,h_P,unit,list,1);
list = {'^r'; '^I'; '^2'; '^3'};
[d_en,h_en,u_en]=genfeature(d_f1,h_f1,u_f1,list);

%% Import the information of Pauling
D_P=D_p1(:,45:53);
h_P=head_1(45:53);
unit=ones(1,size(D_P,2));
list={ '/absu'};
[d_f1,h_f1,u_f1]=genfeature2(D_P,h_P,unit,list,1);
list = {'^r'; '^I'; '^2'; '^3'};
[d_p,h_p,u_p]=genfeature(d_f1,h_f1,u_f1,list);

%% Import the information of Orital
D_P=D_p1(:,54:65);
h_P=head_1(54:65);
unit=ones(1,size(D_P,2));
list={ '/absu'};
[d_f1,h_f1,u_f1]=genfeature2(D_P,h_P,unit,list,1);
list = {'^r'; '^I'; '^2'; '^3'};
[d_o,h_o,u_o]=genfeature(d_f1,h_f1,u_f1,list);

%% Import the information of Elemental Table
D_P=D_p1(:,66:71);
h_P=head_1(66:71);
unit=ones(1,size(D_P,2));
list={ '/absu'};
[d_f1,h_f1,u_f1]=genfeature2(D_P,h_P,unit,list,1);
list = {'^r'; '^I'; '^2'; '^3'};
[d_et,h_et,u_et]=genfeature(d_f1,h_f1,u_f1,list);
% % Check for uniq columns
% [C,ia,ic]=unique(d_en','rows','stable');
% d_en=d_en(:,ia);
% h_en=h_en(ia);
% u_en=u_en(ia);

%% 
D_s= [d_q d_d d_bd  d_en d_p d_o d_et];
h_s= [h_q h_d h_bd  h_en h_p h_o h_et];

% Final cleaning just in case
c_col=find(any(isinf(D_s)) | any(isnan(D_s)));
D_s(:,c_col)=[];
h_s(:,c_col)=[];

%% 
% special function to avoid multiplication that produces columns with 1
list={'*absI'};
unit=ones(1,size(D_s,2));
[d_f1,h_f1,u_f1]=genfeature2p(D_s,h_s,unit,list,1);

% keep unique descriptors only
[C,ia,ic]=unique(d_f1','rows','stable');

% final unscaled descriptor dataset
d_f1=d_f1(:,ia);
% final headers 
h_f1=h_f1(ia);
% final unit flags - not going to be used in future
u_f1=u_f1(ia);

save('zjn_feature_MAZ.mat')


