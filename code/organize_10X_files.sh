#!/bin/bash

# Define the directory containing all files
DATA_DIR="/Users/nareshdonijayavelu/Downloads/Projects_Naresh/Hemorrhage_Biopsies/raw_data/GSE266873_RAW"  # Change this to your actual directory

# Check if the directory exists
if [ ! -d "$DATA_DIR" ]; then
    echo "Error: Directory $DATA_DIR does not exist."
    exit 1
fi

# Navigate to the data directory
cd "$DATA_DIR" || exit

# Loop through all matrix.mtx.gz files to extract sample names
for matrix_file in *matrix.mtx.gz; do
    # Extract the sample name (modify pattern if needed)
    sample_name=$(echo "$matrix_file" | sed -E 's/_matrix.mtx.gz$//' )

    # Skip if no sample name is found
    if [ -z "$sample_name" ]; then
        echo "Warning: Could not extract sample name from $matrix_file. Skipping..."
        continue
    fi

    # Create a directory for the sample if it doesn't exist
    mkdir -p "$sample_name"

    # Move and rename files to the sample directory (only if they exist)
    [ -f "${sample_name}_barcodes.tsv.gz" ] && mv "${sample_name}_barcodes.tsv.gz" "$sample_name/barcodes.tsv.gz"
    [ -f "${sample_name}_features.tsv.gz" ] && mv "${sample_name}_features.tsv.gz" "$sample_name/features.tsv.gz"
    [ -f "${sample_name}_matrix.mtx.gz" ] && mv "${sample_name}_matrix.mtx.gz" "$sample_name/matrix.mtx.gz"

    echo "Organized files for $sample_name"
done

echo "All files have been organized into separate directories."

