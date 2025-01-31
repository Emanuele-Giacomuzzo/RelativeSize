## Content of the folder

-   functions: folder with R functions
-   r_markdown_files: folder with R markdown files
-   renv: Files related to the r package `renv`. This package enables you to restore the exact package versions used when working on this project.
-   .Rprofile: file to setup the startup behavior of R
-   AHSize.Rproj: AHSize project on RStudio
-   [renv.lock](https://github.com/Emanuele-Giacomuzzo/AHSize/blob/master/renv.lock "renv.lock"): File from the package `renv` which contains information on which packages (and versions) were used when working on this project.

## Installation and Code Execution

1.  Open the AHSize project by opening the AHSize.Rproj file using RStudio.
2.  Install the `knitr` package if you do not have installed installed on your machine. Do not worry about installing other packages (see step 4).
3.  Open the master R markdown file "r_markdown_files/00_master.Rmd"
4.  Press the 'knit' button to generate the HTML file containing the analysed data. By knitting the R markdown file, the R package `renv` installs all the necessary packages with the correct versions in the project, so that you don't need to manually manage package versions.
5. Although the `renv` package should enable you to reinstall all packages with the correct versions, I'm providing you with the necessary packages in case there are any issues with `renv`. You can see which R and package versions you might need to install to run the analysis by going to AHSize → 3_results → results.html → other.
