function [params,loglik] = fit_model(data, lesion_index, lesion_value)

% lesion_index: which parameter(s) to lesion (set to [] to disable)
% lesion_value: fix the lesioned parameter(s) to these values

badsopts = bads('defaults');
badsopts.UncertaintyHandling = 1;
badsopts.NoiseFinalSamples = 0;
badsopts.MaxFunEvals = 2000;

%     [   prn , pstop, drp, laps, scal, ctr, 2un, 2co, 3rw, 4rw]
x0 =  [    2  , 0.02 , 0.2, 0.05, 1.2 , 0.8,   1, 0.4, 3.5,  10];
ub =  [10000  , 1    , 1  , 1   , 4   ,  10,  10,  10,  10,  10];
lb =  [    0.1, 0.001, 0  , 0.05, 0.25, -10, -10, -10, -10, -10];
pub = [   10  , 1    , 0.5, 0.5 , 2   ,   5,   5,   5,   5,   5];
plb = [    0.1, 0.001, 0  , 0.05, 0.5 ,  -5,  -5,  -5,  -5,  -5];
c = 50;

Ntrials = size(data,1);
L = zeros(Ntrials,10);

x0  = apply_lesion(x0,  lesion_index, lesion_value);
lb  = apply_lesion(lb,  lesion_index, lesion_value);
ub  = apply_lesion(ub,  lesion_index, lesion_value);
plb = apply_lesion(plb, lesion_index, lesion_value);
pub = apply_lesion(pub, lesion_index, lesion_value);

data

for i=1:10
	L(:,i) = estimate_loglik_ibs(data,x0);
end

times = generate_times(mean(L,2),c);

times'

fun=@(x) sum(estimate_loglik_ibs(data, apply_lesion(x, lesion_index, lesion_value), times));

params = bads(fun,x0,lb,ub,plb,pub,[],badsopts);

params

for i=1:10
	loglik(i) = fun(params);
end

end

function x = apply_lesion(x, lesion_index, lesion_value)
	% Apply a lesion to one or more of the parameters.
	for idx = 1:numel(lesion_index)
		x(lesion_index(idx)) = lesion_value(idx);
	end
end
