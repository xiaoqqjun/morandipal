# morandipal: Professional Morandi Color Palettes for Single-Cell Visualization

An R package providing publication-quality Morandi-style color palettes optimized for single-cell RNA-seq data visualization. Includes streamlined functions for creating beautiful UMAP/tSNE plots with customizable transparency, sizing, and clustering parameters.

## Features

- **7 Professional Color Palettes**: Carefully designed Morandi-style color schemes
- **17 Unique Colors**: Full palette with all colors available
- **Auto-Optimization**: Intelligent parameter suggestions based on data density
- **Full Customization**: Control over every aspect of visualization
- **Publication-Ready**: Optimized for academic journals and presentations
- **Seurat Integration**: Seamless integration with Seurat workflows

## Installation

```r
# Install from GitHub (coming soon)
# remotes::install_github("morandipal/morandipal")

# Or build locally
devtools::load_all()
```

## Quick Start

```r
library(morandipal)
library(Seurat)

# Basic UMAP plot with default settings
plot_umap(seurat_obj)

# Custom parameters
plot_umap(seurat_obj,
          group.by = "cell_type",
          palette = "warm_theme",
          alpha = 0.7,
          pt.size = 0.8,
          label = TRUE)

# Auto-optimized plot (recommended)
plot_umap_optimized(seurat_obj)
```

## Available Palettes

| Palette | Colors | Use Case |
|---------|--------|----------|
| `complete_17` | 17 | General use, many categories |
| `warm_theme` | 15 | Heat maps, time series |
| `cool_green` | 15 | Cell types, clustering |
| `purple_elegant` | 15 | Academic publication |
| `neutral_pro` | 15 | Reports, printing |
| `harmony_blend` | 15 | Multi-dimensional analysis |
| `gradient_full` | 17 | Gradient visualization |

## Main Functions

### Plotting Functions

#### `plot_umap()`
Creates enhanced UMAP plots with Morandi color palettes.

```r
plot_umap(
  object,
  group.by = "seurat_clusters",
  reduction = "umap",
  palette = "gradient_full",
  alpha = 0.8,
  pt.size = 0.5,
  label = TRUE,
  label.size = 5,
  repel = TRUE,
  legend.position = "right"
)
```

**Parameters:**
- `object`: Seurat object
- `group.by`: Metadata column for coloring
- `reduction`: Dimensionality reduction to plot
- `palette`: Color palette name or custom hex vector
- `alpha`: Transparency (0-1)
- `pt.size`: Point size for cells
- `label`: Add cluster labels
- `label.size`: Size of labels
- `repel`: Repel overlapping labels
- `legend.position`: Position of legend

#### `plot_umap_optimized()`
Auto-optimizes parameters based on cell count.

```r
plot_umap_optimized(seurat_obj, group.by = "seurat_clusters")
```

#### `plot_umap_interactive()`
Creates side-by-side comparison plots.

```r
plots <- plot_umap_interactive(
  seurat_obj,
  group.by.list = c("seurat_clusters", "cell_type")
)
```

### Utility Functions

#### `list_palettes()`
Display all available palettes.

```r
list_palettes()
```

#### `get_palette()`
Retrieve specific color palettes.

```r
# Get full palette
colors <- get_palette("warm_theme")

# Get subset of colors
colors_8 <- get_palette("gradient_full", n = 8)
```

#### `preview_palette()`
Visualize color palettes.

```r
preview_palette("warm_theme")
preview_palette("gradient_full", n = 10, include_hex = TRUE)
```

#### `suggest_alpha()`
Get optimal transparency based on cell count.

```r
alpha <- suggest_alpha(50000)  # Returns 0.8
```

#### `suggest_pt_size()`
Get optimal point size based on cell count.

```r
pt_size <- suggest_pt_size(50000)  # Returns 0.5
```

#### `adjust_plot_alpha()`
Modify transparency of existing plots.

```r
p <- plot_umap(seurat_obj, alpha = 1.0)
p_transparent <- adjust_plot_alpha(p, alpha = 0.5)
```

#### `generate_blend()`
Create smooth color blends.

```r
blend <- generate_blend("#C1747B", "#CADD93", n = 10)
```

## Color Palette Details

### Complete 17-Color Palette

```
#C1747B - Almond Red      #DEA368 - Caramel Gold   #CADD93 - Yellow Green
#BDD9B6 - Mint Green      #8ED19B - Medium Green   #E1C270 - Golden Yellow
#DBB0D4 - Purple Pink     #DBE6B3 - Light Yel-Grn  #7B537D - Deep Purple
#929F74 - Gray Green      #679AC3 - Blue           #CF8DB4 - Rose Pink
#57B3C3 - Cyan            #377EB7 - Deep Blue
#636363 - Deep Gray       #9EA0A4 - Light Gray     #BDBFC3 - Pale Gray
```

### Color Scheme Characteristics

- **Warm Theme**: Red, gold, and pink tones - ideal for heat maps and temporal data
- **Cool Green**: Cyan, green, and mint - perfect for cell type clustering
- **Purple Elegant**: Purple and pink shades - suitable for academic journals
- **Neutral Pro**: Professional grays - recommended for reports and printing
- **Harmony Blend**: Multi-color balance - for complex, multi-dimensional data
- **Gradient Full**: Dark to light progression - for hierarchical data visualization

## Optimization Rules

Auto-optimization suggests parameters based on cell count:

**Alpha Transparency:**
- < 5,000 cells: 1.0
- 5,000-10,000: 0.9
- 10,000-50,000: 0.8
- 50,000-100,000: 0.6
- > 100,000: 0.4

**Point Size:**
- < 5,000 cells: 1.5
- 5,000-10,000: 1.2
- 10,000-50,000: 0.8
- 50,000-100,000: 0.5
- > 100,000: 0.3

## Advanced Examples

### Custom Color Vector

```r
custom_colors <- c("#C1747B", "#BDD9B6", "#DBB0D4", "#929F74")
plot_umap(seurat_obj, palette = custom_colors)
```

### Publication-Ready Plot

```r
p <- plot_umap(
  seurat_obj,
  group.by = "cell_type",
  palette = "purple_elegant",
  alpha = 0.85,
  pt.size = 0.6,
  label = TRUE,
  label.size = 6,
  legend.position = "right",
  title = "Cell Type UMAP",
  title.size = 16
)

ggsave("umap_plot.pdf", p, width = 8, height = 6, dpi = 300)
```

### Side-by-Side Comparison

```r
library(patchwork)

p1 <- plot_umap(seurat_obj, group.by = "seurat_clusters", 
                palette = "cool_green")
p2 <- plot_umap(seurat_obj, group.by = "cell_type", 
                palette = "purple_elegant")

p1 | p2
```

### Batch Processing

```r
metadata_cols <- colnames(seurat_obj@meta.data)
palette_list <- rep(c("warm_theme", "cool_green", "purple_elegant"), 
                    length.out = length(metadata_cols))

for (i in seq_along(metadata_cols)) {
  p <- plot_umap(seurat_obj,
                 group.by = metadata_cols[i],
                 palette = palette_list[i])
  print(p)
}
```

## Requirements

- R >= 4.0.0
- Seurat >= 4.0.0
- ggplot2 >= 3.3.0
- dplyr
- scales

## Citation

```
@software{morandipal,
  title = {morandipal: Professional Morandi Color Palettes for Single-Cell Visualization},
  year = {2024}
}
```

## License

MIT

## Contributing

Contributions are welcome! Please submit issues and pull requests on GitHub.

## Acknowledgments

Morandi color palette design inspired by the aesthetic principles of Giorgio Morandi's artwork, adapted for scientific data visualization.

---

For more information and updates, visit the [GitHub repository](https://github.com/morandipal/morandipal)
