process CREATE_REGIONS {
	label "create_regions"
	
	publishDir "$params.outdir/results/regions/", mode: 'copy'
	
    input:
    path bam
    
    output:
    path 'all_contigs.txt'
    path '*.regions', emit: regions 
    
    script:
    """
    # Extract all contig names
    samtools view -H ${bam} | grep '^@SQ' | cut -f2 | sed 's/SN://' > all_contigs.txt
    
    # Create batches of contigs (one file per batch)
    split -l ${params.contigs_per_batch} all_contigs.txt batch_
    
    # Convert each batch file to medaka format (one contig per line)
    for f in batch_*; do
        cp \$f \${f}.regions
    done
    """
}
