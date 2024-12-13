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

        # Ensure required columns exist
        required_columns = ['Layer Number', 'L2 SRAM Size Req (Bytes)', 
                            'Avg number of utilized PEs', 'L1 SRAM Size Req (Bytes)', 'NoC BW Req (Elements/cycle)']
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
        l1_sram_size = data['L1 SRAM Size Req (Bytes)']
        noc_bw_req = data['NoC BW Req (Elements/cycle)']

        # Create an array of positions for each layer (to offset the bars side by side)
        positions = np.arange(len(layer_numbers))

        # Create a figure and axis with four y-axes
        fig, ax1 = plt.subplots(figsize=(14, 8))

        # Plot Avg Number of Utilized PEs with red bars
        bar_width = 0.15
        ax1.bar(positions - 1.5 * bar_width, avg_pes, bar_width, color='red', label='Avg number of utilized PEs')
        ax1.set_xlabel('Layer Number')
        ax1.set_ylabel('Avg Number of Utilized PEs', color='red')
        ax1.tick_params(axis='y', labelcolor='red')

        # Create a second y-axis for L2 SRAM Size Req (Bytes) using blue bars
        ax2 = ax1.twinx()
        ax2.bar(positions - 0.5 * bar_width, l2_sram_size, bar_width, color='blue', alpha=0.6, label='L2 SRAM Size Req (Bytes)')
        ax2.set_ylabel('L2 SRAM Size Req (Bytes)', color='blue')
        ax2.tick_params(axis='y', labelcolor='blue')

        # Create a third y-axis for L1 SRAM Size Req (Bytes) using green bars
        ax3 = ax1.twinx()
        ax3.spines["right"].set_position(("outward", 60))  # Offset the third axis to avoid overlap
        ax3.bar(positions + 0.5 * bar_width, l1_sram_size, bar_width, color='green', alpha=0.6, label='L1 SRAM Size Req (Bytes)')
        ax3.set_ylabel('L1 SRAM Size Req (Bytes)', color='green')
        ax3.tick_params(axis='y', labelcolor='green')

        # Create a fourth y-axis for NoC BW Req (Elements/cycle) using dark yellow bars
        ax4 = ax1.twinx()
        ax4.spines["right"].set_position(("outward", 120))  # Offset the fourth axis further
        ax4.bar(positions + 1.5 * bar_width, noc_bw_req, bar_width, color='darkgoldenrod', alpha=0.6, label='NoC BW Req (Elements/cycle)')
        ax4.set_ylabel('NoC BW Req (Elements/cycle)', color='darkgoldenrod')
        ax4.tick_params(axis='y', labelcolor='darkgoldenrod')

        # Set the tick positions for x-axis and labels
        ax1.set_xticks(positions)
        ax1.set_xticklabels(layer_numbers)

        # Adding title and grid
        plt.title("Avg Number of Utilized PEs, L2/L1 SRAM Size Req, and NoC BW Req vs Layer Number")
        ax1.grid(True)

        # Display calculated latency and energy at the bottom within the figure
        fig.text(0.5, 0.02, f"Latency: {latency_ms:.2f} ms | Energy: {energy_mJ:.2f} mJ",
                 ha="center", fontsize=12, bbox={"facecolor":"lightgray", "alpha":0.5, "pad":5})

        # Adjust layout for clarity
        plt.tight_layout(rect=[0, 0.05, 1, 1])

        # Show the plot
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
