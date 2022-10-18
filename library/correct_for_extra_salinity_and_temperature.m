function a_new = correct_for_extra_salinity_and_temperature(wl,a,delta_S, delta_T)
  S = 35;
  T = 273+22;
  a0 = water_absorption_coefficient(wl,S,T);
  a1 = water_absorption_coefficient(wl,S+delta_S,T+delta_T);
  a_new = a + (a1 - a0);
end
