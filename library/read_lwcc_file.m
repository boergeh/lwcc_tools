function [x, y] = read_lwcc_file(filename)
  headerlines = 13;
  fid = fopen(filename);
  m = textscan(fid,'%f%f%s','headerlines',headerlines);
  fclose(fid);
  x = m{1};
  y = m{2};
end
