function a2 = average_and_smooth(a1,wavelengths)
   %idx = find(x > 225 & x < 800);
  %a2 = smooth(mean(a1),18,'lowess');
  a2 = smooth(mean(a1),wavelengths,'lowess');
end
