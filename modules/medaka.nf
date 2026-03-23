process MEDAKA_INFERENCE {
    label 'medaka_inference'
    
    publishDir "$params.outdir/results/medaka/", mode: 'copy', pattern: '*.hdf'
    
    input:
    tuple path(bam), path(bai), path(region_file)
    val model
    
    output:
    path 'inference_results_*.hdf', emit: hdf
    
    script:
    """
    while read -r region; do
        echo "Processing \$region"
        medaka inference ${bam} "inference_results_\${region}.hdf" \\
            --model ${model} --threads 2 --region "\$region"
    done < ${region_file}
    """
}

process MEDAKA_SEQUENCE {
    label "medaka_sequence"
    
    publishDir "$params.outdir/results/medaka/", mode: 'copy', pattern: '*'
    
    input:
    val hdf_files
    path assembly
    
    output:
    path 'polished_assembly.fasta'
    
    script:
    """
    medaka sequence ${hdf_files.join(' ')} ${assembly} polished_assembly.fasta
    """
}
