SyntheVAEiser: Synthetic gene expression sample generation
        
Codebase corresponding to 'Augmenting traditional ML with VAE-based gene expression sample generation for improved prediction of cancer molecular subtypes'  

Data structure for input to model:
    Categorically labeled, tabular gene expression
    Samples as rows, features as columns

Description of paths in code files:

    data/
        The file set of samples for encoding and generating sythetic samples. One file per cancer type for this experiment.

    v/
        This is 'version' - the parent directory in which the individual output dirs will be written.

    decoded_objs/
        The original sample expression values after encoding and re-coding by the VAE.

    latent_objs/
        The latent feature representations of the original samples. Input to the HLVS and RNLVS fuctions at runtime.

    take-off_points/
        The subset of samples randomly selected within each experimental validation replicate. Corresponds to the four data phases shown in Figure 1 - original, blend, re-coded, and latent-phase synthetic.
    
    synthetic_sample_sets/
        The generated syntetic samples decoded back to the original feature dimension of the input gene expression values.

    rfe_out/
        Optional output directory for directly incorporating recursive feature elimination on the synthetic samples in-line.
