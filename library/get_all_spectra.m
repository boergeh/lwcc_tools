function [x, y] = get_all_spectra(folder)
  f{1} = dir([folder,'/*dark*.txt']);
  f{2} = dir([folder,'/*mqw*.txt']);
  f{3} = dir([folder,'/*sample*.txt']);
  for i=1:length(f)
    if length(f{i})==0
      folder
      f{i}
    end
  end
  for i=1:length(f)
    for j=1:length(f{i})
      [x{i}(j,:), y{i}(j,:)] = read_lwcc_file([folder,'/',f{i}(j).name]);
    end
  end
end
