rule gisaid:
    input:
    output:
    shell:
        <R-script>

rule casedata:
    input:
    output:
        <R-script>

rule subsample_gis_casedata:
    input:
        {gisaid, casedata}
    output:
        
    shell:
        <R-script>
