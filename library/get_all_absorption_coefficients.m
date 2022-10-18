function [wl a] = get_all_absorption_coefficients(folder,wall_correction)
  [x, y] = get_all_spectra(folder);
  wl = x{1}(1,:);
  n = 1;
  for i=1:size(x{1},1)
    for j=1:size(x{2},1)
      for k=1:size(x{3},1)
	dark = y{1}(i,:);
	mq_water = y{2}(j,:);
	sample = y{3}(k,:);
	a{n} = get_absorption_coefficient(wl,dark,mq_water,sample,wall_correction);
	n = n + 1;
      end
    end
  end
  wl = x{1}(1,:);
end
