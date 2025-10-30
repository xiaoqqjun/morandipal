# morandipal R Package - Complete Overview

## What is morandipal?

A professional R package for single-cell RNA-seq data visualization with:
- **17 publication-quality Morandi-style color palettes**
- **Optimized UMAP plotting functions** with customizable parameters
- **Auto-optimization** based on cell count and data density
- **Easy integration** with Seurat workflows

## Package Contents

### 📁 Directory Structure

```
morandipal/
│
├── DESCRIPTION              # Package metadata
├── NAMESPACE               # Function exports
├── LICENSE                 # MIT License
├── README.md               # Full documentation
├── QUICKSTART.md           # Quick start guide
├── INSTALLATION.md         # Installation guide
├── .gitignore              # Git configuration
│
├── R/                      # R source code
│   ├── data.R              # Color palette definitions
│   ├── plotting_functions.R # Main UMAP plotting functions
│   └── utility_functions.R  # Helper functions
│
├── examples/               # Example scripts
│   └── example_script.R    # Comprehensive usage examples
│
└── data/                   # Pre-compiled data
    └── morandi_palettes.rda # Binary palette data
```

## Key Functions

### Plotting Functions (3)

| Function | Purpose | Output |
|----------|---------|--------|
| `plot_umap()` | Create customizable UMAP plots | ggplot object |
| `plot_umap_optimized()` | Auto-optimized UMAP plots | ggplot object |
| `plot_umap_interactive()` | Side-by-side comparisons | list of plots |

### Color Management (4)

| Function | Purpose | Output |
|----------|---------|--------|
| `get_palette()` | Retrieve color palettes | hex color vector |
| `list_palettes()` | Show available palettes | data.frame |
| `preview_palette()` | Visualize palette | ggplot object |
| `generate_blend()` | Create color transitions | hex color vector |

### Optimization Functions (3)

| Function | Purpose | Output |
|----------|---------|--------|
| `suggest_alpha()` | Suggest transparency | numeric (0-1) |
| `suggest_pt_size()` | Suggest point size | numeric |
| `adjust_plot_alpha()` | Modify existing plot | ggplot object |

## Available Color Palettes (7 + 17)

### Named Palettes

1. **complete_17** - Full 17-color palette
2. **warm_theme** - Red, gold, pink (15 colors)
3. **cool_green** - Cyan, green, mint (15 colors)
4. **purple_elegant** - Purple and pink (15 colors)
5. **neutral_pro** - Professional grays (15 colors)
6. **harmony_blend** - Multi-color balance (15 colors)
7. **gradient_full** - Dark to light gradient (17 colors)

### Color Characteristics

- **Low saturation** - High-quality appearance
- **Scientifically optimized** - For publication clarity
- **Aesthetically balanced** - Based on Morandi's principles
- **Easy to distinguish** - Sufficient contrast between colors

## Installation

### Quick Install

```r
# From source
library(devtools)
install_local("/path/to/morandipal")

# Or
devtools::load_all("/path/to/morandipal")
```

### Full Setup

See `INSTALLATION.md` for detailed instructions including:
- System requirements
- Dependency installation
- Troubleshooting
- Platform-specific notes

## Basic Usage

### 1. Load Package

```r
library(morandipal)
```

### 2. View Available Palettes

```r
list_palettes()
preview_palette("cool_green")
```

### 3. Create UMAP Plot

```r
# Basic (uses defaults)
plot_umap(seurat_obj)

# Custom colors and style
plot_umap(
  seurat_obj,
  group.by = "cell_type",
  palette = "purple_elegant",
  alpha = 0.75,
  pt.size = 0.6
)

# Auto-optimized
plot_umap_optimized(seurat_obj)
```

### 4. Get Parameters Suggestions

```r
n_cells <- ncol(seurat_obj)
suggested_alpha <- suggest_alpha(n_cells)
suggested_pt_size <- suggest_pt_size(n_cells)
```

## Advanced Features

### Custom Styling

```r
plot_umap(
  seurat_obj,
  palette = "warm_theme",
  alpha = 0.85,
  pt.size = 0.6,
  label = TRUE,
  label.size = 6,
  legend.position = "right",
  bg.color = "white",
  panel.color = "#F5F5F5",
  title = "My Analysis",
  title.size = 16
)
```

### Color Management

```r
# Get specific palette
colors <- get_palette("cool_green")

# Get subset
colors_8 <- get_palette("gradient_full", n = 8)

# Create blend
blend <- generate_blend("#C1747B", "#CADD93", n = 15)
```

### Batch Processing

```r
for (group in c("seurat_clusters", "cell_type")) {
  p <- plot_umap(seurat_obj, group.by = group)
  ggsave(paste0(group, ".pdf"), p)
}
```

## Optimization Rules

The package includes intelligent optimization based on data size:

### Alpha (Transparency)
- < 5K cells: 1.0
- 5-10K: 0.9
- 10-50K: 0.8
- 50-100K: 0.6
- > 100K: 0.4

### Point Size
- < 5K cells: 1.5
- 5-10K: 1.2
- 10-50K: 0.8
- 50-100K: 0.5
- > 100K: 0.3

## File Details

### R Files

**data.R**
- Defines all 7 color palettes
- Creates `morandi_palettes` list object
- Generates binary .rda file

**plotting_functions.R**
- `plot_umap()` - Main plotting function
- `plot_umap_interactive()` - Comparative plotting
- `adjust_plot_alpha()` - Transparency adjustment

**utility_functions.R**
- `get_palette()`, `list_palettes()`, `preview_palette()`
- `suggest_alpha()`, `suggest_pt_size()`
- `generate_blend()` - Color blending
- `plot_umap_optimized()` - Auto-optimization

### Documentation Files

**README.md** - Complete documentation with:
- Features and installation
- All function descriptions
- Usage examples
- Parameter guide
- Citation information

**QUICKSTART.md** - Quick reference with:
- Basic usage patterns
- Advanced examples
- Tips & tricks
- Troubleshooting

**INSTALLATION.md** - Setup guide with:
- Installation methods
- Dependency information
- Troubleshooting solutions
- Platform-specific notes

**example_script.R** - Executable examples:
- All function demonstrations
- Common use cases
- Integration examples
- Batch processing patterns

## Dependencies

Required Packages:
- R >= 4.0.0
- Seurat >= 4.0.0
- ggplot2 >= 3.3.0
- dplyr
- scales

## Key Features

### 1. Publication Quality
- Carefully designed color palettes
- Optimized for journal figures
- High-resolution output support

### 2. User-Friendly
- Sensible defaults
- Easy customization
- Clear documentation

### 3. Scientifically Sound
- Data-density aware optimization
- Accessible color schemes
- Seurat integration

### 4. Flexible
- Multiple palettes for different needs
- Custom color support
- Works with various reductions (UMAP, tSNE, PCA)

## Common Workflows

### Workflow 1: Quick Publication Figure

```r
p <- plot_umap(
  seurat_obj,
  group.by = "cell_type",
  palette = "purple_elegant",
  alpha = 0.85,
  pt.size = 0.6
)
ggsave("figure.pdf", p, width = 8, height = 6, dpi = 300)
```

### Workflow 2: Exploratory Analysis

```r
# Multiple quick plots
plot_umap_interactive(
  seurat_obj,
  group.by.list = c("clusters", "cell_type", "batch")
)
```

### Workflow 3: Optimized Plotting

```r
# Let package decide best parameters
plot_umap_optimized(seurat_obj)
```

### Workflow 4: Custom Integration

```r
# Use with other visualization tools
colors <- get_palette("cool_green")
# Apply to ComplexHeatmap, ggplot2, etc.
```

## Performance Considerations

### For Large Datasets (>100K cells)
- Use `alpha = 0.3-0.4`
- Use `pt.size = 0.2-0.3`
- Consider `plot_umap_optimized()`

### For Medium Datasets (10-100K cells)
- Use `alpha = 0.6-0.8`
- Use `pt.size = 0.4-0.6`
- Default parameters work well

### For Small Datasets (<10K cells)
- Use `alpha = 0.9-1.0`
- Use `pt.size = 0.8-1.2`
- Labels and details more visible

## Troubleshooting

Common issues and solutions are documented in:
- `INSTALLATION.md` - Installation issues
- `QUICKSTART.md` - Usage issues
- Function help: `?function_name`

## Support & Help

```r
# View all functions
ls("package:morandipal")

# Get package info
?morandipal
packageVersion("morandipal")

# Function documentation
?plot_umap
?get_palette
?list_palettes

# Examples
example(plot_umap)
```

## License

MIT License - Free for academic and commercial use

## Citation

```
@software{morandipal,
  title = {morandipal: Professional Morandi Color Palettes 
           for Single-Cell Visualization},
  year = {2024}
}
```

## Version History

**v1.0.0** (2024)
- Initial release
- 7 color palettes
- 10 main functions
- Full documentation
- Example scripts

## Future Enhancements

Potential additions:
- Additional color palettes
- Interactive Shiny app
- vignettes for complex workflows
- Additional dimensionality reduction support
- Statistical comparison functions

---

**Created:** 2024
**Package Version:** 1.0.0
**R Version:** >= 4.0.0
**Status:** Production Ready
