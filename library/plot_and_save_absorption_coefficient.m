function plot_and_save_absorption_coefficient(input_folder,output_folder, save_name,dST)
  S_sample = dST(1);
  delta_S = S_sample;
  delta_T = dST(2);
  extra_wall_correction = 1.0;
  [wl a] = get_all_absorption_coefficients(input_folder,extra_wall_correction);
  for i = 1:length(a)
    a2(i,:) = a{i};
    a2(i,:) = correct_for_salinity(wl,a2(i,:),S_sample);
    a2(i,:) = correct_for_extra_salinity_and_temperature(wl,a2(i,:),delta_S,delta_T);
  end
  plot(wl, a2,'color',[1 1 1]*0.7);
  hold on;
  a3 = average_and_smooth(a2,40);

  %%% YCC added interpolation for data from 200nm to 800 nm
  wl_new = 200:1:800;%%YCC
  a3_new = interp1(wl,a3,wl_new);%%YCC
  %%% Null correction at 700 nm
  a3_700 = a3_new-a3_new(501);%%YCC
%      a3_700a = a3_new-a3_new(501)*(700./wl_new);%%YCC
%      a3_700b = a3_new-a3_new(501)*(wl_new./700);%%YCC

  abscoef_new = [wl_new; real(a3_700)]';%%YCC
  plot(wl,a3,'linewidth',1);

  plot(wl_new,a3_700,'linewidth',1,'Color','c');%%YCC
%     plot(wl_new,a3_700a,'linewidth',1,'Color','r');%%YCC
%     plot(wl_new,a3_700b,'linewidth',1,'Color','g');%%YCC



  grid on;
  set(gca,'xlim',[170 880]);
%   set(gca,'ylim',[-0.05 0.05]);
  set(gca,'ylim',[-0.05 0.4]);%%YCC

  hold off;
  xlabel('Wavelength [nm]');
  ylabel('Absorption coefficient [m^{-1}]');
  title(['MillQ-water correction: \DeltaS = ',num2str(delta_S),', \DeltaT = ',num2str(delta_T),' ^\circC'],...
	'fontweight','normal');
  print('-dpdf',[output_folder,'/',save_name,'.pdf']);

  lwcc.folder = input_folder;
  lwcc.delta_S = delta_S;
  lwcc.delta_T = delta_T;
  lwcc.extra_wall_correction_factor = extra_wall_correction;
  lwcc.wavelength = wl;
  lwcc.absorption_coefficient = a3;
  save('-mat',[output_folder,'/',save_name,'.mat'],'lwcc');
  abscoef = [wl; real(a3)']';
  save('-ascii',[output_folder,'/',save_name,'.txt'],'abscoef');

%   %%% YCC added interpolation for data from 200nm to 800 nm
%   wl_new = 200:1:800;
%   a3_new = interp1(wl,a3,wl_new);
%   a3_720 = a3_new-a3_new(521)*(720./wl_new);
%   abscoef_new = [wl_new; real(a3_720)]';
  save('-ascii',[output_folder,'/',save_name,'_interplated.txt'],'abscoef_new');
end




