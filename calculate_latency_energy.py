import sys
import pandas as pd

def calculate_latency_energy(csv_file):
    try:
        # Read the CSV file
        data = pd.read_csv(csv_file)

        # Ensure columns D and E exist (index 3 and 4 because Python is zero-indexed)
        if data.shape[1] < 5:
            raise ValueError("CSV file does not have enough columns (at least 5 required).")

        # Calculate total cycles (sum of column D) and convert to latency in ms
        total_cycles = data.iloc[:, 3].sum()
        latency_ms = total_cycles / 1e6

        # Calculate total energy (sum of column E) and convert to energy in mJ
        total_energy = data.iloc[:, 4].sum()
        energy_mJ = total_energy / 1e6

        # Print results
        print(f"For file '{csv_file}':")
        print(f"Total Cycles (column D): {total_cycles}")
        print(f"Latency (ms): {latency_ms}")
        print(f"Total Energy (column E): {total_energy}")
        print(f"Energy (mJ): {energy_mJ}")

    except Exception as e:
        print(f"Error processing file '{csv_file}': {e}")

if __name__ == "__main__":
    # Check if a CSV file was provided
    if len(sys.argv) != 2:
        print("Usage: python3 calculate_latency_energy.py <csv_file>")
        sys.exit(1)

    # Get the CSV file path from the command-line argument
    csv_file = sys.argv[1]

    # Call the function to calculate latency and energy
    calculate_latency_energy(csv_file)