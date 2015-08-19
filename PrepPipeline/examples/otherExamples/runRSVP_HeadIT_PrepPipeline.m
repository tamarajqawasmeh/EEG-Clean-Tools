%% Example: Running the pipeline outside of ESS

%% Read in the file and set the necessary parameters
basename = 'rsvp';
pop_editoptions('option_single', false, 'option_savetwofiles', false);
indir = 'E:\\CTAData\\RSVP_HEADIT'; % Input data directory used for this demo
params = struct();
%% Parameters that must be preset
params.lineFrequencies = [60, 120];
params.referenceChannels = 1:248;
params.evaluationChannels = 1:248;
params.rereferencedChannels = 1:256;
params.detrendChannels = 1:256;
params.lineNoiseChannels = 1:256;

outdir = 'N:\\ARLAnalysis\\RSVP_HeadIT\\RSVP_Robust_1Hz';
params.detrendType = 'high pass';
params.detrendCutoff = 1;
params.referenceType = 'robust';
params.meanEstimateType = 'median';
params.interpolationOrder = 'post-reference';
params.keepFiltered = false;
basenameOut = [basename 'robust_1Hz_post_median_unfiltered'];

%% Run the pipeline
for k = 1:18
    thisName = sprintf('%s_%02d', basename, k);
    fname = [indir filesep thisName '.set'];
    EEG = pop_loadset(fname);
    thisNameOut = sprintf('%s_%02d', basenameOut, k);
    params.name = thisNameOut;
    [EEG, computationTimes] = prepPipeline(EEG, params);
    fprintf('Computation times (seconds):\n   %s\n', ...
        getStructureString(computationTimes));
    fname = [outdir filesep thisName '.set'];
    save(fname, 'EEG', '-mat', '-v7.3'); 
end