# MRSartifactRemoval

-- still work in progress --

This repository contains code for the removal of artifact signals from a magnetic resonance (MR) spectrum. The modelled situation consists of two artifact lines and one line originating from the investigated compound. Other signals can be present and should be preserved as long as their frequency does not closely coincide with the artifact peaks. It is expected that there is prior knowledge on the artifact signals in the form of mean and standard deviation values for their frequency, full width at half maximum (FWHM) and Voigt mixing parameter, as well as the relative signal intensity of the two artifact signals. The code can easily be adapted to other applications and we provide an example dataset to enable running a demonstration script.

Please read MRSartifactRemoval.pdf (main folder) for more detail.

The provided code is licensed under GNU GPLv3.

If you use this software or material from the documentation, please cite the repository according to the information in the citation file our the output of the citation prompt. Please also cite  

    L. Starke et al.  
    "First Fluorine-19 Magnetic Resonance Images of the Disease Modifying Drug Siponimod"  
    submitted to Theranostics (2022).  
