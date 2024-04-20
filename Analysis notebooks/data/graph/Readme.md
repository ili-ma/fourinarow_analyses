Data in these subfolders contain csv files with fully processed data that can directly be plotted.
These files were generated with `histograms_to_graph_data.py` for models and `players_to_graph_data.py` for player and random data.
These scripts are in the `fourinarow` repository by Ili Ma, forked from the original by Tyler Seip.
Histogram data is generated starting from every game state in the human data and simulating several moves with a model.
These histograms capture how the model would have conitued the game state.
The most common move for the model can then be compared to the human move.
