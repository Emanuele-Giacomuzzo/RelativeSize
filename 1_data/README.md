# How this data was produced

This repository contains the experimental data on morphology and movement of protist species.

## Training data

To be able to then identify protist species in the experiment, prior to the main experiment we filmed at least 100 individuals for each protist species. The analysis of these footages was performed using the BEMOVI R package (based on ImageJ) to extract morphological and behavioral characteristics. We implemented two different intensity thresholds for image analysis:
- A lower pixel intensity threshold of 13 was used for most protist species
- A lower pixel intensity threshold of 40 was used for Blepharisma sp. to distinguish it from the prey species it was kept with in monocultures

## Time point (t0-4) data
We subsequently filmed ecosystem samples at five distinct time points (t0-t4) using BEMOVI software. A threshold of 13 was selected as the optimal setting for capturing protist characteristics while minimizing background noise.

# Ecosystem information

The columns in the ecosystems_info file represent the following (this file uses ecosystem, patch, and culture as synonyms):

- **culture_ID**: ID of the ecosystem  
- **system_nr**: ID of the system (a system is either an unconnected ecosystem or a connected meta-ecosystem; unconnected ecosystems have their own system number, while connected ecosystems share the same system number)  
- **treatment_replicate**: Treatment replicate  
- **disturbance**: Level of disturbance  
- **disturbance_volume**: Volume of the ecosystem that was disturbed (ml)  
- **patch_size**: Size of the ecosystem (S = small, M = medium, L = large)  
- **patch_size_ml**: Size of the ecosystem (ml)  
- **trophic_type**: Trophic type of the ecosystem (autotrophic vs heterotrophic)
- **metaecosystem**: Whether the ecosystem is part of a connected meta-ecosystem  
- **metaecosystem_type**: Type of the connected meta-ecosystem (Ma_Mh = Equally-dominated meta-ecosystem, Sa_Lh = Heterotrophic-dominated meta-ecosystem, Sh_La = Autotrophic-dominated meta-ecosystem)  
- **eco_metaeco_type**: Ecosystem type (Sa = small autotrophic, Sh = small heterotrophic, Ma = medium autotrophic, Mh = medium heterotrophic, La = large autotrophic, Lh = large heterotrophic) followed by the connected meta-ecosystem it is part of.



# Content of the folder
- ecosystem_info.csv: Information about the ecosystems
- t0.csv: Analysis of cultures at time point 0
- t1.csv: Analysis of cultures at time point 1
- t2.csv: Analysis of cultures at time point 2
- t3.csv: Analysis of cultures at time point 3
- t4.csv: Analysis of cultures at final time point (t4)
- training_threshold_13.csv: Morphology and behavior data for monocultures analysed at the 13 lower threshold
- training_threshold_40.csv: Morphology and behavior data for monocultures analysed at the 40 lower threshold
