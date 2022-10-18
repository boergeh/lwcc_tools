function a2 = correct_for_salinity(wl,a1,S)
  m = load('nacl_subtraction_values_in_per_m.txt');
  a2 = a1' - m(:,2)*S/35;
end
