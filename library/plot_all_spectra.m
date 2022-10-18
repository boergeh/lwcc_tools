function plot_all_spectra(folder)
  [x, y] = get_all_spectra(folder);
  %figure(1)
  %subplot(2,1,1)
  %dark = y{1}(1,:);
  %mq = y{2}(3,:)-dark;
  %sample = y{3}(3,:)-dark;
  %wl = x{1}(1,:);
  
  %mq = subtract_extra_dark(wl,mq);
  %sample = subtract_extra_dark(wl,sample);

  
  %abs = -log(sample./(mq*1.013));
  %semilogy(wl,sample)
  %hold on
  %semilogy(wl,mq)
  %grid on
  %hold off
  %subplot(2,1,2)
  %plot(wl,abs)
  %grid on
  for i=1:length(x)
    semilogy(x{i}(1,:),y{i})
    grid on
    hold on
  end
  %figure(2)
  set(gca,'xlim',[170 880])
  set(gca,'ylim',[100 5000])
  %set(gca,'ylim',[0.1 5000])
  set(gca,'ytick',[100 140 200 300 500 1000 1400 2000 3000 4096])
  xlabel('Wavelength [nm]')
  ylabel('12 bit counts')
  hold off
  idx = findstr(folder,'/');
  t = folder(idx(4)+1:end);
  t = strrep(t,'_','\_');
  title(t,'fontweight','normal')
end

%function y = subtract_extra_dark(x,y)
%  low = find(x > 190 & x < 195);
  %high = find(x > 870 & x < 875);
%  yl = mean(y(low));
  %yh = mean(y(high));
%  yd = interp1([193 875],[yl 0],x);
%  y = y - yd;
%end
