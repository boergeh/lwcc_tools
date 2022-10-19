% correct_and_save_spectra(lwcc_input_folder, output_station_name)
% reads LWCC raw data, finds the absorption spectra in units of 1/m
% and corrects for different salinity and temperature in sample and
% blank. Corrected output spectra will be written to the
% ./cdom_absorption_spectra folder.
% Note: at UiB, connect to the smb://klient.uib.no server before running this script.

% Example:
% correct_and_save_spectra('/Users/borgehamre/fieldWork/2021-2022_Arven_etter_Nansen/Q1_and_Q2_Data/AeN_Q1/LWCC/Stations/P7_ice','Q1_P7_ice')

function correct_and_save_spectra(lwcc_input_folder, output_station_name)
  warning off;
addpath ./library;

folder = lwcc_input_folder;
f = dir([folder,'/*_*_*']);
idx = strfind(folder,'/');
dST0 = [35 0];
for i=1:length(f)
  redo = true;
  dST = dST0;
  while redo
    save_name = [output_station_name,'_',f(i).name];
    input_sub_folder = [folder,'/',f(i).name];
    figure(1);
    subplot(2,1,1);
    plot_all_spectra(input_sub_folder);
    subplot(2,1,2);
    plot_and_save_absorption_coefficient(input_sub_folder,...
					 './cdom_absorption_spectra',...
					 save_name,dST);
    disp(['Processing: ',save_name]);
    disp('Salinity and temperature differences between sample and blank are respectively');
    disp(['[',num2str(dST),']']);
    disp(['Press Enter if plotted spectrum does not contain salinity or temperature dependent bumps in red and NIR']);
    dST = input('Otherwise type new [delta_S delta_T] to optimize: ');
    if isempty(dST)
      redo = false;
    else
      redo = true;
      dST0 = dST;
    end
  end
end





