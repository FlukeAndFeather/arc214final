# Automate

## The entire analysis is automated.
### Data reading and cleaning is handled in a standalone script that creates intermediate output(s) - Not yet. Explanation: Data reading and cleaning is still being handled all in one script and not a standalone script. 
### The analysis is performed in a Quarto document that reads intermediate outputs - Not yet. Explanation: The analysis is currently being performed in a scratch file. 
### Files in the R/ folder exclusively define functions and have no other side effects. - Meets spec.
### All scripts run without errors. - Meets spec.

## The analysis produces the expected output.
### The Quarto document performs the data analysis (moving average) - Met.
### The Quarto document creates a figure that is a reasonable approximation of the original - Not yet. Explanation: I have not created one figure that includes all the graphs yet. 

# Organize

## Data are properly organized.
### Raw data is contained in its own folder - Met.
### Outputs are contained in a separate folder from raw data - Not yet. Explanation: I don't have the outputs of my analysis in a folder of its own yet. 

## Code is properly organized.
### At least one function is defined in a script in R/ and used elsewhere in the workflow - Met.
### All code in the repo (except in the scratch/ folder) is required for the analysis (i.e., no “safety blanket” code remaining) - Met

# Document

## The repo has an effective README.
### A short, but descriptive title - Met.
### A brief explanation of the repository’s purpose - Met.
### A concise description of what's housed in the repository - Met.
### Details regarding data acess - Met.
### A list of authors or current contributors - Met.
### References - Met.

## Code follows a professional style.
### All code files follow a consistent style (the Air formatter automates this). - Met. 
### The code has an appropriate amount of comments - Not yet. Explanation: Comments could be more explanatory rather than just saying what a piece of code is doing. 