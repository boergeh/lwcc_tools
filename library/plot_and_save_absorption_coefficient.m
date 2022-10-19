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
  plot(wl,a3,'linewidth',1);
  grid on;
  set(gca,'xlim',[170 880]);
  set(gca,'ylim',[-0.05 0.05]);
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
end
