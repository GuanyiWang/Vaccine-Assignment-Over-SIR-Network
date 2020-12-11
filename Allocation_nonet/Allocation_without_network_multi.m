%Vaccine Allocation without considering network
%(Multiple network) 
%Author: Guanyi Wang and Toru Kitagawa

clear all

% DATA INPUT AND PREPARATION
load('../simulation_multi.mat')

times = length(adj_1);%get the number of random networks
N_1 = length(S_1); 
N_2 = length(S_2);
N_3 = length(S_3);


% Parameter setting 
parameter = false; % switch: choose 1st parameter set into account or 2nd parameter set
budget_constraint = 1; %swtich: choose the capacity constraint level from 1, 2, 3

if (budget_constraint == 1)
if (parameter)
diary('nonet_multi_para1.log');
filename_results = '../nonet_multi_para1_bgt1.mat';
beta_11 = 0.7; %infection rate between group 1 and group 1
beta_12 = 0.5; %infection rate from group 2 to group 1
beta_21 = 0.5; %infection rate from group 1 to group 2
beta_22 = 0.6; %infection rate between group 2 and group 2
gamma_1 = 0.1; %recover rate for group 1
gamma_2 = 0.05; %recover rate for group 2
d_1 = round(0.07*N_1); %capacity constraint for N_1
d_2 = round(0.07*N_2); %capacity constraint for N_2
d_3 = round(0.07*N_3); %capacity constraint for N_3
else
diary('nonet_multi_para2.log');
filename_results = '../nonet_multi_para2_bgt1.mat';
beta_11 = 0.8; %infection rate between group 1 and group 1
beta_12 = 0.5; %infection rate from group 2 to group 1
beta_21 = 0.7; %infection rate from group 1 to group 2
beta_22 = 0.7; %infection rate between group 2 and group 2
gamma_1 = 0.1; %recover rate for group 1
gamma_2 = 0.025; %recover rate for group 2 
d_1 = round(0.07*N_1); %capacity constraint for N_1
d_2 = round(0.07*N_2); %capacity constraint for N_2
d_3 = round(0.07*N_3); %capacity constraint for N_3
end
end
if (budget_constraint == 2)
    if (parameter)
diary('nonet_multi_para1.log');
filename_results = '../nonet_multi_para1_bgt2.mat';
beta_11 = 0.7; %infection rate between group 1 and group 1
beta_12 = 0.5; %infection rate from group 2 to group 1
beta_21 = 0.5; %infection rate from group 1 to group 2
beta_22 = 0.6; %infection rate between group 2 and group 2
gamma_1 = 0.1; %recover rate for group 1
gamma_2 = 0.05; %recover rate for group 2
d_1 = round(0.1*N_1); %capacity constraint for N_1
d_2 = round(0.1*N_2); %capacity constraint for N_2
d_3 = round(0.1*N_3); %capacity constraint for N_3
else
diary('nonet_multi_para2.log');
filename_results = '../nonet_multi_para2_bgt2.mat';
beta_11 = 0.8; %infection rate between group 1 and group 1
beta_12 = 0.5; %infection rate from group 2 to group 1
beta_21 = 0.7; %infection rate from group 1 to group 2
beta_22 = 0.7; %infection rate between group 2 and group 2
gamma_1 = 0.1; %recover rate for group 1
gamma_2 = 0.025; %recover rate for group 2   
d_1 = round(0.1*N_1); %capacity constraint for N_1
d_2 = round(0.1*N_2); %capacity constraint for N_2
d_3 = round(0.1*N_3); %capacity constraint for N_3
    end
end

if (budget_constraint == 3)
    if (parameter)
diary('nonet_multi_para1.log');
filename_results = '../nonet_multi_para1_bgt3.mat';
beta_11 = 0.7; %infection rate between group 1 and group 1
beta_12 = 0.5; %infection rate from group 2 to group 1
beta_21 = 0.5; %infection rate from group 1 to group 2
beta_22 = 0.6; %infection rate between group 2 and group 2
gamma_1 = 0.1; %recover rate for group 1
gamma_2 = 0.05; %recover rate for group 2
d_1 = round(0.2*N_1); %capacity constraint for N_1
d_2 = round(0.2*N_2); %capacity constraint for N_2
d_3 = round(0.2*N_3); %capacity constraint for N_3
else
diary('nonet_multi_para2.log');
filename_results = '../nonet_multi_para2_bgt3.mat';
beta_11 = 0.8; %infection rate between group 1 and group 1
beta_12 = 0.5; %infection rate from group 2 to group 1
beta_21 = 0.7; %infection rate from group 1 to group 2
beta_22 = 0.7; %infection rate between group 2 and group 2
gamma_1 = 0.1; %recover rate for group 1
gamma_2 = 0.025; %recover rate for group 2  
d_1 = round(0.2*N_1); %capacity constraint for N_1
d_2 = round(0.2*N_2); %capacity constraint for N_2
d_3 = round(0.2*N_3); %capacity constraint for N_3
    end
end
%Define the parameter matrix for C

C_1 = ones(N_1,1) - R_1 - diag(a_1*I_1')*gamma_1 - diag(b_1*I_1')*gamma_2 - S_1; %define the vector for N_1
C_2 = ones(N_2,1) - R_2 - diag(a_2*I_2')*gamma_1 - diag(b_2*I_2')*gamma_2 - S_2; %define the vector for N_2
C_3 = ones(N_3,1) - R_3 - diag(a_3*I_3')*gamma_1 - diag(b_3*I_3')*gamma_2 - S_3; %define the vector for N_3



% Find the index for units in group 2
group = true; %switch : give vaccine to group 2 (true) or give vaccine to group 1 (false)
if (group)
Ind_1 = find(b_1);
Ind_2 = find(b_2);
Ind_3 = find(b_3);
else
Ind_1 = find(a_1);
Ind_2 = find(a_2);
Ind_3 = find(a_3);
end

V_1 = zeros(N_1,1);
V_2 = zeros(N_2,1);
V_3 = zeros(N_3,1);
%give the vaccine to the specific group within the budget constraint
for ii = 1:d_1
V_1(Ind_1(ii))= 1;
    
end

for ii = 1:d_2
V_2(Ind_2(ii))= 1;
    
end

for ii = 1:d_3
V_3(Ind_3(ii))= 1;
    
end
tic  %calculate the running time



%Define the weighting matrix
for qq = 1:times
%the first element vector in weighting matrix
W_11{qq} = beta_11*diag(a_1)*diag(S_1)*adj_1{qq}*diag(a_1)*diag(I_1);
W_12{qq} = beta_11*diag(a_1)*diag(S_1)*adj_2{qq}*diag(a_1)*diag(I_1);
W_13 = beta_11*diag(a_1)*diag(S_1)*adj_3*diag(a_1)*diag(I_1);
W_14{qq} = beta_11*diag(a_2)*diag(S_2)*adj_4{qq}*diag(a_2)*diag(I_2);
W_15{qq} = beta_11*diag(a_2)*diag(S_2)*adj_5{qq}*diag(a_2)*diag(I_2);
W_16 = beta_11*diag(a_2)*diag(S_2)*adj_6*diag(a_2)*diag(I_2);
W_17{qq} = beta_11*diag(a_3)*diag(S_3)*adj_7{qq}*diag(a_3)*diag(I_3);
W_18{qq} = beta_11*diag(a_3)*diag(S_3)*adj_8{qq}*diag(a_3)*diag(I_3);
W_19 = beta_11*diag(a_3)*diag(S_3)*adj_9*diag(a_3)*diag(I_3);

%the second element vector in weighting matrix
W_21{qq} = beta_12*diag(a_1)*diag(S_1)*adj_1{qq}*diag(b_1)*diag(I_1);
W_22{qq} = beta_12*diag(a_1)*diag(S_1)*adj_2{qq}*diag(b_1)*diag(I_1);
W_23 = beta_12*diag(a_1)*diag(S_1)*adj_3*diag(b_1)*diag(I_1);
W_24{qq} = beta_12*diag(a_2)*diag(S_2)*adj_4{qq}*diag(b_2)*diag(I_2);
W_25{qq} = beta_12*diag(a_2)*diag(S_2)*adj_5{qq}*diag(b_2)*diag(I_2);
W_26 = beta_12*diag(a_2)*diag(S_2)*adj_6*diag(b_2)*diag(I_2);
W_27{qq} = beta_12*diag(a_3)*diag(S_3)*adj_7{qq}*diag(b_3)*diag(I_3);
W_28{qq} = beta_12*diag(a_3)*diag(S_3)*adj_8{qq}*diag(b_3)*diag(I_3);
W_29 = beta_12*diag(a_3)*diag(S_3)*adj_9*diag(b_3)*diag(I_3);

%the third element vector in weighting matrix
W_31{qq} = beta_21*diag(b_1)*diag(S_1)*adj_1{qq}*diag(a_1)*diag(I_1);
W_32{qq} = beta_21*diag(b_1)*diag(S_1)*adj_2{qq}*diag(a_1)*diag(I_1);
W_33 = beta_21*diag(b_1)*diag(S_1)*adj_3*diag(a_1)*diag(I_1);
W_34{qq} = beta_21*diag(b_2)*diag(S_2)*adj_4{qq}*diag(a_2)*diag(I_2);
W_35{qq} = beta_21*diag(b_2)*diag(S_2)*adj_5{qq}*diag(a_2)*diag(I_2);
W_36 = beta_21*diag(b_2)*diag(S_2)*adj_6*diag(a_2)*diag(I_2);
W_37{qq} = beta_21*diag(b_3)*diag(S_3)*adj_7{qq}*diag(a_3)*diag(I_3);
W_38{qq} = beta_21*diag(b_3)*diag(S_3)*adj_8{qq}*diag(a_3)*diag(I_3);
W_39 = beta_21*diag(b_3)*diag(S_3)*adj_9*diag(a_3)*diag(I_3);

%the fourth element vector in weighting matrix
W_41{qq} = beta_22*diag(b_1)*diag(S_1)*adj_1{qq}*diag(b_1)*diag(I_1);
W_42{qq} = beta_22*diag(b_1)*diag(S_1)*adj_2{qq}*diag(b_1)*diag(I_1);
W_43 = beta_22*diag(b_1)*diag(S_1)*adj_3*diag(b_1)*diag(I_1);
W_44{qq} = beta_22*diag(b_2)*diag(S_2)*adj_4{qq}*diag(b_2)*diag(I_2);
W_45{qq} = beta_22*diag(b_2)*diag(S_2)*adj_5{qq}*diag(b_2)*diag(I_2);
W_46 = beta_22*diag(b_2)*diag(S_2)*adj_6*diag(b_2)*diag(I_2);
W_47{qq} = beta_22*diag(b_3)*diag(S_3)*adj_7{qq}*diag(b_3)*diag(I_3);
W_48{qq} = beta_22*diag(b_3)*diag(S_3)*adj_8{qq}*diag(b_3)*diag(I_3);
W_49 = beta_22*diag(b_3)*diag(S_3)*adj_9*diag(b_3)*diag(I_3);

%combine above elements together
W_1{qq} = - W_11{qq} - W_21{qq} - W_31{qq} - W_41{qq};
W_2{qq} = - W_12{qq} - W_22{qq} - W_32{qq} - W_42{qq};
W_3 = - W_13 - W_23 - W_33 - W_43;
W_4{qq} = - W_14{qq} - W_24{qq} - W_34{qq} - W_44{qq};
W_5{qq} = - W_15{qq} - W_25{qq} - W_35{qq} - W_45{qq};
W_6 = - W_16 - W_26 - W_36 - W_46;
W_7{qq} = - W_17{qq} - W_27{qq} - W_37{qq} - W_47{qq};
W_8{qq} = - W_18{qq} - W_28{qq} - W_38{qq} - W_48{qq};
W_9 = - W_19 - W_29 - W_39 - W_49;

%Normalization for the weighting matrix
for cc = 1:N_1
    if sum(adj_1{qq}(cc,:)) == 0 %for the unit with 0 neighbor, there is no normalization
       W_1{qq}(cc,:) = W_1{qq}(cc,:);
    else
       W_1{qq}(cc,:) = W_1{qq}(cc,:)/sum(adj_1{qq}(cc,:));
    end
    if sum(adj_2{qq}(cc,:)) == 0
        W_2{qq}(cc,:) = W_2{qq}(cc,:);
    else
        W_2{qq}(cc,:) = W_2{qq}(cc,:)/sum(adj_2{qq}(cc,:));
    end
 
    if sum(adj_3(cc,:)) == 0
        W_3(cc,:) = W_3(cc,:);
    else
        W_3(cc,:) = W_3(cc,:)/sum(adj_3(cc,:));
    end
end

for cc = 1:N_2
    if sum(adj_4{qq}(cc,:)) == 0
       W_4{qq}(cc,:) = W_4{qq}(cc,:);
    else
       W_4{qq}(cc,:) = W_4{qq}(cc,:)/sum(adj_4{qq}(cc,:));
    end
    if sum(adj_5{qq}(cc,:)) == 0
        W_5{qq}(cc,:) = W_5{qq}(cc,:);
    else
        W_5{qq}(cc,:) = W_5{qq}(cc,:)/sum(adj_5{qq}(cc,:));
    end
 
    if sum(adj_6(cc,:)) == 0
        W_6(cc,:) = W_6(cc,:);
    else
        W_6(cc,:) = W_6(cc,:)/sum(adj_6(cc,:));
    end
end

for cc = 1:N_3
    if sum(adj_7{qq}(cc,:)) == 0
       W_7{qq}(cc,:) = W_7{qq}(cc,:);
    else
       W_7{qq}(cc,:) = W_7{qq}(cc,:)/sum(adj_7{qq}(cc,:));
    end
    if sum(adj_8{qq}(cc,:)) == 0
        W_8{qq}(cc,:) = W_8{qq}(cc,:);
    else
        W_8{qq}(cc,:) = W_8{qq}(cc,:)/sum(adj_8{qq}(cc,:));
    end
 
    if sum(adj_9(cc,:)) == 0
        W_9(cc,:) = W_9(cc,:);
    else
        W_9(cc,:) = W_9(cc,:)/sum(adj_9(cc,:));
    end
end

% Allocation based on Group
%calculate the current result
F_result_11{qq} = obj(V_1,W_1{qq},C_1);
F_result_12{qq} = obj(V_1,W_2{qq},C_1);
F_result_13 = obj(V_1,W_3,C_1);
F_result_21{qq} = obj(V_2,W_4{qq},C_2);
F_result_22{qq} = obj(V_2,W_5{qq},C_2);
F_result_23 = obj(V_2,W_6,C_2);
F_result_31{qq} = obj(V_3,W_7{qq},C_3);
F_result_32{qq} = obj(V_3,W_8{qq},C_3);
F_result_33 = obj(V_3,W_9,C_3);

%calculate the constant part in the initial objective function
%constant part without interaction, N_1
zz = 1;
const_1 = 0;
while (zz<=N_1)
   const_1 = const_1 + R_1(zz)+a_1(zz)*I_1(zz)*gamma_1+b_1(zz)*I_1(zz)*gamma_2+S_1(zz);
    zz = zz+1;
end
%take average for the constant part without interaction 
const_1 = const_1/N_1;

%calcuate the interacted constant part sepearately, N_1 
mm = 1;
nn = 1;
const_11{qq} = 0;
while (nn <= N_1)
while (mm <= N_1)
   const_11{qq} = const_11{qq}+(beta_11*a_1(nn)*a_1(mm)+beta_12*a_1(nn)*b_1(mm)+beta_21*b_1(nn)*a_1(mm)+ beta_22*b_1(nn)*b_1(mm))*adj_1{qq}(nn,mm)*I_1(mm)*S_1(nn);
    mm = mm+1;
end
nn = nn+1;
end
%take average value for interacted constant part with adj_1
const_11{qq} = const_11{qq}/N_1;

mm = 1;
nn = 1;
const_12{qq} = 0;
while (nn <= N_1)
while (mm <= N_1)
   const_12{qq} = const_12{qq}+(beta_11*a_1(nn)*a_1(mm)+beta_12*a_1(nn)*b_1(mm)+beta_21*b_1(nn)*a_1(mm)+ beta_22*b_1(nn)*b_1(mm))*adj_2{qq}(nn,mm)*I_1(mm)*S_1(nn);
    mm = mm+1;
end
nn = nn+1;
end
%take average value for interacted constant part with adj_2
const_12{qq} = const_12{qq}/N_1;

mm = 1;
nn = 1;
const_13 = 0;
while (nn <= N_1)
while (mm <= N_1)
   const_13 = const_13+(beta_11*a_1(nn)*a_1(mm)+beta_12*a_1(nn)*b_1(mm)+beta_21*b_1(nn)*a_1(mm)+ beta_22*b_1(nn)*b_1(mm))*adj_3(nn,mm)*I_1(mm)*S_1(nn);
    mm = mm+1;
end
nn = nn+1;
end
%take average value for interacted constant part with adj_3
const_13 = const_13/N_1;

%constant part without interaction, N_2
zz = 1;
const_2 = 0;
while (zz<=N_2)
   const_2 = const_2 + R_2(zz)+a_2(zz)*I_2(zz)*gamma_2+b_2(zz)*I_2(zz)*gamma_2+S_2(zz);
    zz = zz+1;
end
%take average for the constant part without interaction 
const_2 = const_2/N_2;

%calcuate the interacted constant part sepearately, N_2
mm = 1;
nn = 1;
const_21{qq} = 0;
while (nn <= N_2)
while (mm <= N_2)
   const_21{qq} = const_21{qq}+(beta_11*a_2(nn)*a_2(mm)+beta_12*a_2(nn)*b_2(mm)+beta_21*b_2(nn)*a_2(mm)+ beta_22*b_2(nn)*b_2(mm))*adj_4{qq}(nn,mm)*I_2(mm)*S_2(nn);
    mm = mm+1;
end
nn = nn+1;
end
%take average value for interacted constant part with adj_4
const_21{qq} = const_21{qq}/N_2;

mm = 1;
nn = 1;
const_22{qq} = 0;
while (nn <= N_2)
while (mm <= N_2)
   const_22{qq} = const_22{qq} +(beta_11*a_2(nn)*a_2(mm)+beta_12*a_2(nn)*b_2(mm)+beta_21*b_2(nn)*a_2(mm)+ beta_22*b_2(nn)*b_2(mm))*adj_5{qq}(nn,mm)*I_2(mm)*S_2(nn);
    mm = mm+1;
end
nn = nn+1;
end
%take average value for interacted constant part with adj_5
const_22{qq} = const_22{qq}/N_2;

mm = 1;
nn = 1;
const_23 = 0;
while (nn <= N_2)
while (mm <= N_2)
   const_23 = const_23+(beta_11*a_2(nn)*a_2(mm)+beta_12*a_2(nn)*b_2(mm)+beta_21*b_2(nn)*a_2(mm)+ beta_22*b_2(nn)*b_2(mm))*adj_6(nn,mm)*I_2(mm)*S_2(nn);
    mm = mm+1;
end
nn = nn+1;
end
%take average value for interacted constant part with adj_6
const_23 = const_23/N_2;

%constant part without interaction, N_3
zz = 1;
const_3 = 0;
while (zz<=N_3)
   const_3 = const_3 + R_3(zz)+a_3(zz)*I_3(zz)*gamma_1+b_3(zz)*I_3(zz)*gamma_2+S_3(zz);
    zz = zz+1;
end

%take average for the constant part without interaction 
const_3 = const_3/N_3;

%calcuate the interacted constant part sepearately, N_3
mm = 1;
nn = 1;
const_31{qq} = 0;
while (nn <= N_3)
while (mm <= N_3)
   const_31{qq} = const_31{qq}+(beta_11*a_3(nn)*a_3(mm)+beta_12*a_3(nn)*b_3(mm)+beta_21*b_3(nn)*a_3(mm)+ beta_22*b_3(nn)*b_3(mm))*adj_7{qq}(nn,mm)*I_3(mm)*S_3(nn);
    mm = mm+1;
end
nn = nn+1;
end
%take average value for interacted constant part with adj_7
const_31{qq} = const_31{qq}/N_3;

mm = 1;
nn = 1;
const_32{qq} = 0;
while (nn <= N_3)
while (mm <= N_3)
   const_32{qq} = const_32{qq}+(beta_11*a_3(nn)*a_3(mm)+beta_12*a_3(nn)*b_3(mm)+beta_21*b_3(nn)*a_3(mm)+ beta_22*b_2(nn)*b_3(mm))*adj_8{qq}(nn,mm)*I_3(mm)*S_3(nn);
    mm = mm+1;
end
nn = nn+1;
end
%take average value for interacted constant part with adj_8
const_32{qq} = const_32{qq}/N_3;

mm = 1;
nn = 1;
const_33 = 0;
while (nn <= N_3)
while (mm <= N_3)
   const_33 = const_33+(beta_11*a_3(nn)*a_3(mm)+beta_12*a_3(nn)*b_3(mm)+beta_21*b_3(nn)*a_3(mm)+ beta_22*b_2(nn)*b_3(mm))*adj_9(nn,mm)*I_3(mm)*S_3(nn);
    mm = mm+1;
end
nn = nn+1;
end
%take average value for interacted constant part with adj_9
const_33 = const_33/N_3;
%combime the previous result together
Y_11{qq} = const_1-const_11{qq}+F_result_11{qq};
Y_12{qq} = const_1-const_12{qq}+F_result_12{qq};
Y_13 = const_1-const_13+F_result_13;
Y_21{qq} = const_2-const_21{qq}+F_result_21{qq};
Y_22{qq} = const_2-const_22{qq}+F_result_22{qq};
Y_23 = const_2-const_23+F_result_23;
Y_31{qq} = const_3-const_31{qq}+F_result_31{qq};
Y_32{qq} = const_3-const_32{qq}+F_result_32{qq};
Y_33 = const_3-const_33+F_result_33;
end
%calculate the average value of outcome variable for multiple network
Y_11_ave = 0;
Y_12_ave = 0;
Y_13_ave = Y_13;
Y_21_ave = 0;
Y_22_ave = 0;
Y_23_ave = Y_23;
Y_31_ave = 0;
Y_32_ave = 0;
Y_33_ave = Y_33;

%take average value across different networks
ww = 1;
while (ww<=times)
Y_11_ave = Y_11_ave + Y_11{ww};
ww = ww+1;
end
Y_11_ave = Y_11_ave/times;

ww = 1;
while (ww<=times)
Y_12_ave = Y_12_ave + Y_12{ww};
ww = ww+1;
end
Y_12_ave = Y_12_ave/times;

ww = 1;
while (ww<=times)
Y_21_ave = Y_21_ave + Y_21{ww};
ww = ww+1;
end
Y_21_ave = Y_21_ave/times;

ww = 1;
while (ww<=times)
Y_22_ave = Y_22_ave + Y_22{ww};
ww = ww+1;
end
Y_22_ave = Y_22_ave/times;

ww = 1;
while (ww<=times)
Y_31_ave = Y_31_ave + Y_31{ww};
ww = ww+1;
end
Y_31_ave = Y_31_ave/times;

ww = 1;
while (ww<=times)
Y_32_ave = Y_32_ave + Y_32{ww};
ww = ww+1;
end
Y_32_ave = Y_32_ave/times;
toc

%clear the irrelevant variables
clear C_1 C_2 C_3 
clear W_11 W_12 W_13 W_14 W_15 W_16 W_17 W_18 W_19 W_21 W_22 W_23 W_24 W_25 W_26 W_27 W_28 W_29 
clear W_31 W_32 W_33 W_34 W_35 W_36 W_37 W_38 W_39 W_41 W_42 W_43 W_44 W_45 W_46 W_47 W_48 W_49
clear V_1 V_2 V_3 Ind_1 Ind_2 Ind_3
clear F_result_11 F_result_12 F_result_13 F_result_21 F_result_22 F_result_23 F_result_31 F_result_32 F_result_33
clear mm nn zz ii qq cc ww
clear a_1 a_2 a_3 b_1 b_2 b_3 S_1 S_2 S_3 I_1 I_2 I_3 R_1 R_2 R_3
clear W_1 W_2 W_3 W_4 W_5 W_6 W_7 W_8 W_9
clear beta_11 beta_12 beta_21 beta_22 gamma_1 gamma_2
clear const_1 const_2 const_3 const_11 const_12 const_13 const_21 const_22 const_23 const_31 const_32 const_33
clear adj_1 adj_2 adj_3 adj_4 adj_5 adj_6 adj_7 adj_8 adj_9 Y_11 Y_12 Y_13 Y_21 Y_22 Y_23 Y_31 Y_32 Y_33
% Save coefficients and other variables for graphs
save(filename_results);

diary off