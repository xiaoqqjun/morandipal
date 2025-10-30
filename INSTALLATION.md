# morandipal Package: Installation & Setup Guide

## Directory Structure

```
morandipal/
├── DESCRIPTION          # Package metadata
├── NAMESPACE           # Package exports and imports
├── README.md           # Main documentation
├── QUICKSTART.md       # Quick start guide
├── INSTALLATION.md     # This file
├── LICENSE             # MIT License
├── R/
│   ├── data.R          # Color palette data definitions
│   ├── plotting_functions.R   # Main plotting functions
│   └── utility_functions.R    # Utility and helper functions
├── examples/
│   └── example_script.R       # Usage examples
├── data/
│   └── morandi_palettes.rda   # Pre-compiled palette data
└── .gitignore
```

## Installation Methods

### Method 1: Install from Source (Recommended)

#### Prerequisites
```r
# Install required packages if not already installed
install.packages(c("devtools", "roxygen2"))

# Install dependencies
install.packages(c("Seurat", "ggplot2", "dplyr", "scales"))
```

#### Installation Steps
```r
# Load devtools
library(devtools)

# Set working directory to package root
setwd("path/to/morandipal")

# Install from source
install(".", dependencies = TRUE)

# Or use
devtools::install_local(".", dependencies = TRUE)
```

### Method 2: Build and Install

```bash
# From command line in package root directory

# Build the package
R CMD build morandipal

# Install
R CMD INSTALL morandipal_1.0.0.tar.gz
```

### Method 3: Quick Load (Development)

```r
# For development/testing - doesn't require installation
library(devtools)
setwd("path/to/morandipal")
load_all()
```

## Post-Installation Setup

### 1. Load the Package

```r
library(morandipal)
```

### 2. Verify Installation

```r
# Check if package loads correctly
packageVersion("morandipal")

# List available functions
ls("package:morandipal")

# View package help
help(package = "morandipal")
```

### 3. Verify Color Palettes

```r
# Load and check palettes
data(morandi_palettes)
names(morandi_palettes)

# Verify palette dimensions
sapply(morandi_palettes, length)
```

### 4. Test Basic Functionality

```r
# Test palette retrieval
test_palette <- get_palette("cool_green")
print(test_palette)

# Test palette preview
preview_palette("warm_theme")

# Test optimization suggestions
suggest_alpha(50000)
suggest_pt_size(50000)
```

## Dependencies

### Required Packages
- **R >= 4.0.0**
- **Seurat >= 4.0.0** - Single-cell analysis framework
- **ggplot2 >= 3.3.0** - Graphics and visualization
- **dplyr** - Data manipulation
- **scales** - Scale functions for ggplot2

### Installation of Dependencies

```r
# Install all dependencies
install.packages(c("dplyr", "scales"))
install.packages("Seurat")

# Check versions
packageVersion("Seurat")
packageVersion("ggplot2")
```

## Building Package Documentation

If you modify functions and need to rebuild documentation:

```r
library(roxygen2)
setwd("path/to/morandipal")

# Regenerate NAMESPACE and .Rd files
roxygen2::roxygenise()

# Or use
devtools::document()
```

## Creating the Package Data File

If the `morandi_palettes.rda` file doesn't exist:

```r
# In R, from package root directory
source("R/data.R")

# Or manually create
morandi_palettes <- list(...)  # as defined in data.R
usethis::use_data(morandi_palettes, overwrite = TRUE)
```

## Troubleshooting

### Issue 1: Package not found after installation

**Solution:**
```r
# Restart R
# Reinstall the package
library(devtools)
install_local("path/to/morandipal")

# Load and verify
library(morandipal)
```

### Issue 2: Function not found

**Check:**
```r
# Verify package is loaded
"morandipal" %in% .packages()

# Reload if needed
detach("package:morandipal", unload = TRUE)
library(morandipal)

# List available functions
ls("package:morandipal")
```

### Issue 3: Dependency installation failure

**Solution:**
```r
# Try installing dependencies separately
install.packages("Seurat", repos = "https://cran.r-project.org")

# Check for system requirements
sessionInfo()
```

### Issue 4: Cannot load Seurat

**Check:**
```r
# Install from Bioconductor if needed
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Seurat")
```

### Issue 5: Plotting function doesn't work

**Troubleshoot:**
```r
# Check if Seurat object is valid
class(your_seurat_object)

# Verify reduction exists
names(your_seurat_object@reductions)

# Test simple plot first
plot_umap(your_seurat_object, label = FALSE, legend.position = "none")
```

## Platform-Specific Notes

### Windows
- If compilation issues occur, ensure Rtools is installed
- May need to install from binary: `install.packages(..., type = "binary")`

### macOS
- Ensure Xcode Command Line Tools are installed
- If building from source fails, try: `xcode-select --install`

### Linux
- Ensure development packages are installed:
  ```bash
  # Ubuntu/Debian
  sudo apt-get install r-base-dev
  sudo apt-get install libssl-dev libcurl4-openssl-dev
  ```

## Advanced Configuration

### Create .Rprofile Shortcut

Add to your `.Rprofile`:
```r
# Quick load morandipal
mp <- function() {
  library(morandipal)
  cat("morandipal loaded!\n")
  list_palettes()
}
```

Then use:
```r
mp()  # Loads package and shows palettes
```

### Configure Package Path

```r
# Add to .Renviron
R_LIBS_USER="path/to/library"

# Or in R
.libPaths("path/to/library")
```

## Updating the Package

### From GitHub (when available)

```r
library(devtools)
install_github("morandipal/morandipal")
```

### From Local Source

```r
library(devtools)
setwd("path/to/updated/morandipal")
install(".", force = TRUE)
```

## Uninstalling the Package

```r
remove.packages("morandipal")
```

## Development Workflow

### Making Changes

```r
# 1. Modify R files
# 2. Document changes
library(roxygen2)
roxygenise()

# 3. Test
load_all()
test_plot <- plot_umap(your_seurat_obj)

# 4. Check for errors
check()

# 5. Reinstall
install()
```

### Testing Functions

```r
# Test basic functionality
library(morandipal)

# Test all functions exist
all_functions <- c(
  "plot_umap", "plot_umap_optimized", "plot_umap_interactive",
  "get_palette", "list_palettes", "preview_palette",
  "suggest_alpha", "suggest_pt_size", "adjust_plot_alpha",
  "generate_blend"
)

for (func in all_functions) {
  if (exists(func)) {
    cat(sprintf("✓ %s loaded\n", func))
  } else {
    cat(sprintf("✗ %s NOT FOUND\n", func))
  }
}
```

## Getting Help

### Package Documentation

```r
# View package help
help(package = "morandipal")

# Function-specific help
?plot_umap
?get_palette
?list_palettes

# Examples
example(plot_umap)
```

### Reporting Issues

When reporting issues, include:
- R version: `R.version.string`
- morandipal version: `packageVersion("morandipal")`
- Seurat version: `packageVersion("Seurat")`
- Session info: `sessionInfo()`

## License

MIT License - See LICENSE file for details

## Support

For issues and questions:
1. Check README.md and QUICKSTART.md
2. Review examples in `examples/example_script.R`
3. Consult function documentation: `?function_name`
4. Check error messages for suggestions

---

**Last Updated:** 2024
**Package Version:** 1.0.0
