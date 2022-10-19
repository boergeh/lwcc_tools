function a2 = average_and_smooth(a1,wavelengths)
  a2 = smooth(mean(a1),wavelengths,'lowess');
end
