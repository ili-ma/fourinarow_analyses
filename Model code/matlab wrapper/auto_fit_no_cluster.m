n_subjects = 9;
n_splits = 5;

basedir = "../../Analysis notebooks/data/generated_games/";
indir = strcat(basedir, "Average-no-tree");
outdir = strcat(basedir, "fit_full_gen_no_tree");

addpath(genpath("."));

for player = 1:n_subjects
	for group = 1:n_splits
		fprintf("Player %d/%d split %d/%d\n", player, n_subjects, group, n_splits);
		cross_val(player,group,indir,outdir);
	end
end
fprintf("Done\n");
