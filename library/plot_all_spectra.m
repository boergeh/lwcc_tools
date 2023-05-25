function plot_all_spectra(folder)
  [x, y] = get_all_spectra(folder);
  for i=1:length(x)
    semilogy(x{i}(1,:),y{i});
    grid on;
    hold on;
  end
  set(gca,'xlim',[170 880]);
  %set(gca,'ylim',[100 5000]);
  set(gca,'ylim',[10 5000]);
  set(gca,'ytick',[100 140 200 300 500 1000 1400 2000 3000 4096]);
  xlabel('Wavelength [nm]');
  ylabel('12 bit counts');
  hold off;
  idx = findstr(folder,'/');
  t = folder(idx(4)+1:end);
  t = strrep(t,'_','\_');
  title(t,'fontweight','normal');
end
