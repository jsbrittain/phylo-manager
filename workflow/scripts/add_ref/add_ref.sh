#!/usr/bin/env bash

while getopts r:i: flag
do
	case "${flag}" in
		r) refFile=${OPTARG};;
		i) infile=${OPTARG};;
	esac
done

grep -Ev "^$" $refFile > ref_empR.fasta

filename=$(basename -- "$infile")
filename="${filename%.*}"
cat ref_empR.fasta $infile > "${filename}_refAdded.fasta"