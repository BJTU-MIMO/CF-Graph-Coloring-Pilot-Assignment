# Graph Coloring Based Pilot Assignment for Cell-Free Massive MIMO Systems

This is a code package is related to the following scientific article:


H. Liu, J. Zhang, S. Jin, and B. Ai, “Graph coloring based pilot assignment for cell-free massive MIMO systems,” IEEE Trans. Veh. Technol., vol. 69, no. 8, pp. 9180–9184, Aug. 2020

The package contains a simulation environment, based on Matlab, that reproduces some of the numerical results and figures in the article. *We encourage you to also perform reproducible research!*


## Abstract of Article

An efficient pilot assignment scheme based on graph coloring is proposed to mitigate the severe pilot contamination effect in cell-free massive multiple-input multiple-output systems. By exploiting the large-scale fading coefficients between the access points (APs) and the user equipments, we first utilize an AP selection algorithm to construct an interference graph. Then, the optimal pilot assignment can be achieved by updating the interference graph. In addition, we consider a fair policy for pilot reuse to improve the system performance. Numerical results verify that, compared with conventional pilot assignment schemes, the proposed graph coloring based pilot assignment scheme can significantly increase the 95%-likely per-user throughput and reduce the complexity of assigning pilot sequences.

## Content of Code Package

The package generates the simulation SE results which are used in Figure 2, Figure 3, Figure 4, and Figure 5. To be specific:

- `simulation_main`: Main function;
- `functionAPSelection`: Generate AP selection results;
- `functiongraph`: Generate the graph coloring based pilot assignment result;

See each file for further documentation.


## License and Referencing

This code package is licensed under the GPLv2 license. If you in any way use this code for research that results in publications, please cite our original article listed above.
