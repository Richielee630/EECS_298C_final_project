import sys
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

def calculate_latency_energy(csv_file):
    try:
        # Read the CSV file
        data = pd.read_csv(csv_file)

        # Strip leading/trailing spaces from column names
        data.columns = data.columns.str.strip()

        # Ensure columns D, E, A, O, and AY exist
        if data.shape[1] < 5:
            raise ValueError("CSV file does not have enough columns (at least 5 required).")
        
        required_columns = ['Layer Number', 'L2 SRAM Size Req (Bytes)', 'Avg number of utilized PEs']
        if not all(col in data.columns for col in required_columns):
            raise ValueError(f"CSV file is missing required columns. Expected columns: {required_columns}")
        
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

        # Extract relevant columns for plotting
        layer_numbers = data['Layer Number']
        avg_pes = data['Avg number of utilized PEs']
        l2_sram_size = data['L2 SRAM Size Req (Bytes)']

        # Create an array of positions for each layer (to offset the bars side by side)
        positions = np.arange(len(layer_numbers))

        # Create a figure and axis with two y-axes
        fig, ax1 = plt.subplots(figsize=(14, 7))

        # Plot Avg Number of Utilized PEs with red bars (shifted to the left)
        ax1.bar(positions - 0.2, avg_pes, 0.4, color='red', label='Avg number of utilized PEs')
        ax1.set_xlabel('Layer Number')
        ax1.set_ylabel('Avg Number of Utilized PEs', color='red')
        ax1.tick_params(axis='y', labelcolor='red')

        # Create a second y-axis for L2 SRAM Size Req (Bytes) using blue bars (shifted to the right)
        ax2 = ax1.twinx()
        ax2.bar(positions + 0.2, l2_sram_size, 0.4, color='blue', alpha=0.6, label='L2 SRAM Size Req (Bytes)')
        ax2.set_ylabel('L2 SRAM Size Req (Bytes)', color='blue')
        ax2.tick_params(axis='y', labelcolor='blue')

        # Set the tick positions for x-axis and y-axis to show the labels properly
        ax1.set_xticks(positions)
        ax1.set_xticklabels(layer_numbers)

        # Adding title and grid
        plt.title("Avg Number of Utilized PEs and L2 SRAM Size Req vs Layer Number")
        ax1.grid(True)

        # Show the plot
        plt.tight_layout()
        plt.show()

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