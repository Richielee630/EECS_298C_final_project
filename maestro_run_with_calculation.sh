#!/bin/bash

# Check if a script name is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <script_name>"
  echo "Example: $0 vgg16_fp"
  exit 1
fi

# Map user-friendly names to actual script paths and corresponding CSV files
case "$1" in
  example)
    script_to_run="./run_example.sh"
    csv_file="example.csv"
    ;;
  unet)
    script_to_run="./run_unet.sh"
    csv_file="unet.csv"
    ;;
  unet_fp)
    script_to_run="./run_unet_fp.sh"
    csv_file="UNet_dataflow_fp.csv"
    ;;
  unet_temp)
    script_to_run="./run_unet_temp.sh"
    csv_file="UNet_dataflow_temp.csv"
    ;;
  vgg16_fp)
    script_to_run="./run_vgg16_fp.sh"
    csv_file="vgg16_dataflow_fp.csv"
    ;;
  vgg16_temp)
    script_to_run="./run_vgg16_temp.sh"
    csv_file="vgg16_dataflow_temp.csv"
    ;;
  llama3)
    script_to_run="./run_llama3_variant_mha.sh"
    csv_file="llama3_variant_mha_dataflow.csv"
    ;;
  *)
    echo "Error: Unknown script name '$1'"
    echo "Supported scripts: example, unet, vgg16_fp, vgg16_temp"
    exit 1
    ;;
esac

# Remove the corresponding CSV file if it exists
if [ -f "$csv_file" ]; then
  echo "Removing existing file: $csv_file"
  rm "$csv_file"
fi

# Run the script and filter output to show only between "[PASS]" and "Model-wise total L1"
"$script_to_run" | awk '
/\[PASS\]/ {found=1} 
found && /Model-wise total L1/ {print; exit} 
found'

# Wait for 3 seconds
sleep 3

# Check if the CSV file exists after the script execution
if [ ! -f "$csv_file" ]; then
  echo "Error: CSV file '$csv_file' not found after running the script!"
  exit 1
fi

# Call the Python script to calculate latency and energy
python3 calculate_latency_energy.py "$csv_file"