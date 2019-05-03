#******************************************************************************
#
# note: 
#       integral function used : integral(f, x1, x2);
#       plot somehow does not show a correct result
#
#******************************************************************************

clear all;
clc;
tic;

#abstol = 1e-10; #default = 1e-10
#reltol = 1e-6; #default = 1e-06

n = 2;
tol_up = 0.999;
tol_bottom = 1 + 0e-20;
#material = "Au2";   # 1 = Au, 2 = Pt, 3 = Ti, 4 = Pt/Ti/SiO2/Si, 5 = Ag

#for mat = {"Au3", "Pt3", "Ti3", "PtTi3"}
#for mat = {"Au4", "Pt4", "Ti4", "PtTi4"}
for mat = {"Ag","Cu"}

material = mat{};

if (strcmp(material, "Ag"))
rho_bulk = 1.6; # rho_bulk = 1.6 uOhm.cm
h = 200e-9;
p = 0.0; # assumed
lambda = 57e-9;
w = linspace(50e-9,900e-6,n);
sigma = 0.385;
D_50 = 50e-9;  # 53.502+-20.374
R = 0.3;

elseif (strcmp(material, "Ag2"))
rho_bulk = 1.6; # rho_bulk = 1.6 uOhm.cm
h = 200e-9;
p = 0.0; # assumed
lambda = 57e-9;
w = [56e-9  58e-9  60e-9  62e-9  64e-9  ...
            68e-9  70e-9  72e-9         ...
     76e-9  78e-9  80e-9  82e-9  84e-9  ...
            88e-9  90e-9  92e-9         ...
     96e-9  98e-9  100e-9 102e-9 104e-9 ...
     116e-9 118e-9 120e-9 122e-9 124e-9 ...
            128e-9                      ...
     136e-9 138e-9 140e-9 142e-9 144e-9 ...
            148e-9                      ...
     156e-9 158e-9 160e-9 162e-9 164e-9 ...
            168e-9                      ...
                                 324e-9 ...
     326e-9 328e-9 330e-9 332e-9 334e-9 ...
     836e-9 838e-9 840e-9 842e-9 844e-9 ...
     ];  # n = 50;
#w = linspace(50e-9,900e-6,n);
sigma = 0.385;
D_50 = 50e-9;  # 53.502+-20.374
R = 0.3;

elseif (strcmp(material, "Cu"))
rho_bulk = 1.65; # rho_bulk = 1.75 uOhm.cm
h = 800e-9; # assumed, to fit
p = 0.0;
lambda = 39e-9;
w = linspace(50e-9,550e-9,n);
#w = [76.1e-9 86.1e-9 96.2e-9 140e-9 162e-9 251e-9 355e-9 520e-9];  # n = 8;
sigma = 0.2; # assumed
D_50 = 40e-9; # 40.808+-8.244
R = 0.25;

#*******************************************************************************
#*******************************************************************************
elseif (strcmp(material, "Au3"))
rho_bulk = 2.20; # rho_bulk = 2.20 uOhm.cm
h = 180e-9;
p = 0.5;
lambda = 40e-9;
w = linspace(50e-9,2049e-9,n);
sigma = 0.2;
D_50 = 40e-9;   # 40.808+-8.244
R = 0.658;

elseif (strcmp(material, "Pt3"))
rho_bulk = 10.5; # rho_bulk = 10.5 uOhm.cm
h = 150e-9;
p = 1.0;  # assumed
lambda = 23e-9;
w = linspace(50e-9,2049e-9,n);
sigma = 0.385;
D_50 = 23.212e-9; # 25+-10
R = 0.57;

elseif (strcmp(material, "Ti3"))
rho_bulk = 75; # rho_bulk = 75 uOhm.cm
h = 30e-9;
p = 1.0;  # assumed
lambda = 18e-9;
w = linspace(50e-9,2049e-9,n);
sigma = 0.246;
D_50 = 31.045e-9;  # 32+-8
R = 0.17;

elseif (strcmp(material, "PtTi3"))
rho_bulk = 17.8; # rho_bulk = 17.8 uOhm.cm
h = 180e-9;
p = 0.5;  # no_info
lambda = 17.2e-9;
w = linspace(50e-9,2049e-9,n);
sigma = 0.2;
D_50 = 29.398e-9;  # 30+-6.1
R = 0.41;
#*******************************************************************************
#*******************************************************************************
elseif (strcmp(material, "Au4"))
rho_bulk = 2.20; # rho_bulk = 2.20 uOhm.cm
h = 180e-9;
p = 0.5;
lambda = 40e-9;
w = 20000e-9;
sigma = 0.2;
D_50 = 40e-9;   # 40.808+-8.244
R = 0.658;

elseif (strcmp(material, "Pt4"))
rho_bulk = 10.5; # rho_bulk = 10.5 uOhm.cm
h = 150e-9;
p = 1.0;  # assumed
lambda = 23e-9;
w = 20000e-9;
sigma = 0.385;
D_50 = 23.212e-9; # 25+-10
R = 0.57;

elseif (strcmp(material, "Ti4"))
rho_bulk = 75; # rho_bulk = 75 uOhm.cm
h = 30e-9;
p = 1.0;  # assumed
lambda = 18e-9;
w = 20000e-9;
sigma = 0.246;
D_50 = 31.045e-9;  # 32+-8
R = 0.17;

elseif (strcmp(material, "PtTi4"))
rho_bulk = 17.8; # rho_bulk = 17.8 uOhm.cm
h = 180e-9;
p = 0.5;  # no_info
lambda = 17.2e-9;
w = 20000e-9;
sigma = 0.2;
D_50 = 29.398e-9;  # 30+-6.1
R = 0.41;
#*******************************************************************************
#*******************************************************************************

else
# do nothing
endif

h_nm = h * 1e9;

if (strcmp(material, "Ag"))
for i = 1:n
  alpha(i) = lambda ./ D_50 * R / (1-R);  
  ratio_MS(i) = 3 * ( (1/3) - (alpha(i)/2) + (alpha(i))^2 - ((alpha(i))^3 * (log(1 + alpha(i)^-1) ) ) );
  
  rho_MS(i) = rho_bulk ./ ratio_MS(i);
  
  rho_gb(i) = rho_MS(i) - rho_bulk;
end;

else

for i = 1:n  
  pdf = @(D) 1 ./ (sigma .* D * sqrt(2*pi)) .* exp(-(1 / (sigma.*sqrt(2)) * log(D./D_50) ).^2);  
  
  A = @(D) (pi/4) .* pdf(D) .* D .* (D-w(i)) ./ w(i);
  B = @(D)           pdf(D) .* 1 .* (D-w(i)) ./ w(i);

  [q_A(i)] = quadgk( A, w(i)*tol_bottom, ((1.09.*w(i))+45e-9) );
  [q_B(i)] = quadgk( B, w(i)*tol_bottom, ((1.09.*w(i))+45e-9) );
     
  [D_eff(i)] = [q_A(i)] ./ [q_B(i)];
  alpha(i) = lambda ./ D_eff(i) * R / (1-R);  
  ratio_MS(i) = 3 * ( (1/3) - (alpha(i)/2) + (alpha(i))^2 - ((alpha(i))^3 * (log(1 + alpha(i)^-1) ) ) );
  rho_MS(i) = rho_bulk ./ ratio_MS(i);
  rho_gb(i) = rho_MS(i) - rho_bulk;
end;

#subplot (rows, cols, index)
subplot(2,2,1)
plot (w,D_eff);
xlabel ("w");
ylabel ("D_eff(i)", "Interpreter", "none");

subplot(2,2,2)
plot (w,ratio_MS);
xlabel ("w");
ylabel ("ratio_MS(i)", "Interpreter", "none");

subplot(2,2,3)
plot (w,rho_MS);
title ("rho_MS=rho_bulk/ratio_MS", "Interpreter", "none")
xlabel ("w");
ylabel ("rho_MS(i)", "Interpreter", "none");

subplot(2,2,4)
plot (w,rho_gb);
title ("rho_s(i)=ratio_MS - rho_bulk", "Interpreter", "none")
xlabel ("w");
ylabel ("rho_s(i)", "Interpreter", "none");

endif
#******************************************************************************
# To export the raw data into a file
result_matrix = transpose([1:i; w; ratio_MS; rho_MS; rho_gb; rho_bulk*ones(1,i)]);
dlmwrite (sprintf('ms_v14_%s_%dnm_%d.csv', material, h_nm, n), result_matrix); 
#
#******************************************************************************

endfor;

elapsed_time = toc;
hours_time = floor(elapsed_time/3600);
minutes_time = floor((elapsed_time - (hours_time*3600))/60);
seconds_time = rem  ((elapsed_time - (hours_time*3600)),60);
elapsed_time_formated = [hours_time minutes_time seconds_time];

disp_01_elapsed_time_formated = elapsed_time_formated;
disp_02_elapsed_time = elapsed_time;
disp_03_w = w;
disp_04_h = h;
disp_05_material = material;
disp_06_ratio_MS = ratio_MS;
disp_07_rho_MS = rho_MS;

disp_08_rho_MS_start = rho_MS(1);
#disp_09_rho_MS_end = rho_MS(100);
disp_10_w_start = w(1) *1e9;
disp_11_w_end = w(n)*1e9;

#******************************************************************************
#
#   pdf1 = @(D) 1 / (sigma * D * sqrt(2*pi)) * exp(-(1 / (sigma*sqrt(2)) * log(D/D_50) )^2);
#   a = pdf(40e-9);
#   b = 2.34e-222;
#
#******************************************************************************
