function a = get_absorption_coefficient(wl, dark, milliq, sample,wall_correction)
  path_length_in_m = 1;
  sample = sample-dark;
  milliq = milliq-dark;
  milliq = subtract_extra_dark(wl,milliq);
  sample = subtract_extra_dark(wl,sample);
  a = -1/path_length_in_m*log(sample./(milliq*wall_correction));
end

function y = subtract_extra_dark(x,y)
  low = find(x > 188 & x < 192);
  high = find(x > 870 & x < 874);
  yl = mean(y(low));
  yh = mean(y(high));
  yd = interp1([190 873],[yl yh],x);
  y = y - yd;
end
