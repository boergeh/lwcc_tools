function a = water_absorption_coefficient(wl,S,T)
  command = ['flick iop absorption_length 188e-9 900e-9 1000 pure_water ',...
	     num2str(T),' ',num2str(S),' > tmp.txt']
  system(command);
  m = load('tmp.txt');
  a = 1./interp1([100e-9; m(:,1)],[m(1,2); m(:,2)],wl*1e-9);
  system('rm -f ./tmp.txt');
end

