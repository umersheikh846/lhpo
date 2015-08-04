%f version
function final = load_dirs (beforef,endf, column, save_best)
	valid_dirs = glob(strcat(beforef, '[._0-9]*/', endf));

%  	valid_dirs

if length(pk = pkg('list', 'parallel')) == 0
	for i=1:length(valid_dirs) 
		valid_dir = valid_dirs{i,1};
		X{i} = load(valid_dir)(:,column);
		if save_best
			X{i} = save_best_policy(X{i}')';
		endif
	endfor
else
	pkg load parallel
	vector_x=1:length(valid_dirs);
	if save_best
		fun = @(x) save_best_policy((load(valid_dirs{x,1})(:,column))')';
	else
		fun = @(x) load(valid_dirs{x,1})(:,column);
	endif
	X = pararrayfun(nproc, fun, vector_x, 'VerboseLevel', 0);
	final = X';
	return
endif

	if(length(valid_dirs) == 0)
		printf('ERROR path :%s \n', pattern);
		exit
	endif

%  	keyboard
	base = size(X{1});
	mmin = base(1);
	minRequired=0;
	for i=2:length(valid_dirs)
	  if(size(X{i}, 2) != base(2) )
		printf('ERROR matrix columns differ to merge %s\n', pattern);
		exit
	  elseif(size(X{i}, 1) != base(1))
		printf('WARNING matrix rows differ (min taken) %s\n', pattern);
		mmin = min([mmin size(X{i}, 1)]);
		minRequired=1;
	  endif
	endfor

%  	keyboard
	
  final=zeros(length(valid_dirs), mmin);
  for i=1:length(valid_dirs)
          final(i,:) = X{i}(1:mmin);
  endfor

endfunction


%load_dirs('NN_APP', 'statRL_NN.dat')

