rule gisaid:
    input:
        "data/gisaid/small_gisaid_metadata_2022-03-04.tsv"
    output:
        "results/processed_gisaid_metadata.tsv"
    shell:
        "shell/gisaid_preprocess/process_gisaid_metadata.R {input}"

rule owid:
    input:
        "data/owid/small_owid-covid-data.csv"
    output:
        "results/processed_owid_case_data.csv"
    shell:
        "shell/owid_preprocess/process_owid_case_data.R {input}"

rule subsample_gis_owid:
    input:
        "results/processed_gisaid_metadata.tsv",
        "results/processed_owid_case_data.csv"
    output:
        "results/subsampled_gisaid_metadata.tsv"
    shell:
<----- lots of undefined options that need defining here ------->
        "shell/subsample_gis_casedata/case_incidence-informed_subsampling.R <variant> <target_number_of_sequences> --start_month <%Y-%m> --end-month <%Y-%m> --metadata_infile results/processed_gisaid_metadata.tsv --case_data_infile results/processed_owid_case_data.csv --outfile {output}"

rule get_accession_ids:
    input:
        "results/processed_owid_case_data.csv"
    output:
        "results/processed_owid_case_data_seqids.csv"
    shell:
        <Script to extract second column only; Accession.ID> -------------------------------

rule sequence_accessions:
    input:
        gis="results/subsampled_gisaid_metadata.tsv",
        seqis="results/processed_owid_case_data_seqids.csv"
    output:
        "results/sequence_accessions" --------------------------------
    shell:
        "shell/seq_accessions/extract_accessions.sh -i {input.gis} {input.seqid}"
