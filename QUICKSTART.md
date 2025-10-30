# morandipal Quick Start Guide

## Installation

```r
# Load the package (assuming it's installed)
library(morandipal)
library(Seurat)
```

## Basic Usage

### 1. View Available Palettes

```r
list_palettes()
```

Output shows all 7 available palettes with their characteristics.

### 2. Preview a Palette

```r
preview_palette("warm_theme")
preview_palette("gradient_full", n = 12)
```

### 3. Create Basic UMAP Plot

```r
# Simplest usage - uses default parameters
plot_umap(seurat_obj)

# Equivalent to:
plot_umap(
  object = seurat_obj,
  group.by = "seurat_clusters",
  reduction = "umap",
  palette = "gradient_full",
  alpha = 0.8,
  pt.size = 0.5,
  label = TRUE,
  label.size = 5,
  repel = TRUE
)
```

### 4. Customize Colors and Style

```r
# Using different palette
plot_umap(
  seurat_obj,
  group.by = "cell_type",
  palette = "cool_green",
  alpha = 0.7,
  pt.size = 0.6
)
```

### 5. Auto-Optimize Based on Data Size

```r
# Automatically adjusts alpha and pt.size based on cell count
p <- plot_umap_optimized(seurat_obj)

# For 50,000 cells:
# - alpha = 0.8
# - pt.size = 0.5
```

### 6. Get Suggested Parameters

```r
n_cells <- ncol(seurat_obj)

suggested_alpha <- suggest_alpha(n_cells)
suggested_pt_size <- suggest_pt_size(n_cells)

plot_umap(
  seurat_obj,
  alpha = suggested_alpha,
  pt.size = suggested_pt_size
)
```

### 7. Modify Existing Plot Transparency

```r
p <- plot_umap(seurat_obj, alpha = 1.0)

# Make it more transparent
p_transparent <- adjust_plot_alpha(p, alpha = 0.5)
```

### 8. Get Custom Color Vector

```r
# Full palette
colors_all <- get_palette("warm_theme")

# Subset of colors
colors_8 <- get_palette("gradient_full", n = 8)

# Use with other packages
library(ggplot2)
ggplot(data, aes(x = var1, y = var2, fill = category)) +
  geom_point() +
  scale_fill_manual(values = colors_8)
```

## Advanced Examples

### Example 1: Publication-Ready Figure

```r
# Create a high-quality plot for publication
p <- plot_umap(
  seurat_obj,
  group.by = "cell_type",
  reduction = "umap",
  palette = "purple_elegant",
  alpha = 0.85,
  pt.size = 0.6,
  label = TRUE,
  label.size = 6,
  label.box = FALSE,
  legend.position = "right",
  bg.color = "white",
  panel.color = "#F5F5F5",
  axis.text.size = 11,
  title = "Cell Type Distribution",
  title.size = 16,
  axis.title.size = 13
)

# Save with high resolution
ggsave("figure_s1_umap.pdf", p, width = 8, height = 7, dpi = 300)
ggsave("figure_s1_umap.png", p, width = 8, height = 7, dpi = 300)
```

### Example 2: Multiple Plots Comparison

```r
library(patchwork)

# Create multiple plots with different groupings
p_clusters <- plot_umap(
  seurat_obj,
  group.by = "seurat_clusters",
  palette = "cool_green",
  title = "Clusters"
)

p_celltype <- plot_umap(
  seurat_obj,
  group.by = "cell_type",
  palette = "warm_theme",
  title = "Cell Type"
)

p_batch <- plot_umap(
  seurat_obj,
  group.by = "batch",
  palette = "neutral_pro",
  title = "Batch"
)

# Arrange in grid
p_combined <- (p_clusters | p_celltype) / p_batch
ggsave("umap_comparison.pdf", p_combined, width = 14, height = 10, dpi = 300)
```

### Example 3: Custom Color Blending

```r
# Create smooth transition between colors
custom_blend <- generate_blend("#C1747B", "#CADD93", n = 10)

plot_umap(
  seurat_obj,
  palette = custom_blend
)
```

### Example 4: Transparency Comparison

```r
library(patchwork)

# Show effect of different alpha values
p1 <- plot_umap(seurat_obj, alpha = 1.0) + ggtitle("Alpha = 1.0 (Opaque)")
p2 <- plot_umap(seurat_obj, alpha = 0.7) + ggtitle("Alpha = 0.7")
p3 <- plot_umap(seurat_obj, alpha = 0.4) + ggtitle("Alpha = 0.4 (Transparent)")

p1 | p2 | p3
```

### Example 5: Custom Palette

```r
# Define custom color palette
my_colors <- c("#C1747B", "#BDD9B6", "#DBB0D4", "#929F74", "#636363")

plot_umap(
  seurat_obj,
  palette = my_colors,
  alpha = 0.75,
  pt.size = 0.7
)
```

### Example 6: Batch Processing

```r
# Create plots for all metadata columns
metadata_cols <- c("seurat_clusters", "cell_type", "batch", "treatment")
palettes <- c("cool_green", "warm_theme", "neutral_pro", "purple_elegant")

plots <- list()

for (i in seq_along(metadata_cols)) {
  plots[[i]] <- plot_umap(
    seurat_obj,
    group.by = metadata_cols[i],
    palette = palettes[i],
    title = metadata_cols[i]
  )
}

# Display all plots
for (p in plots) {
  print(p)
}
```

### Example 7: Subset-Specific Visualization

```r
# Subset to specific cell type
seurat_subset <- subset(seurat_obj, cell_type == "T_cell")

# Visualize with optimized parameters
p <- plot_umap_optimized(
  seurat_subset,
  group.by = "seurat_clusters",
  palette = "harmony_blend"
)

print(p)
```

### Example 8: Integration with ComplexHeatmap or Other Packages

```r
# Get specific color palette for use with other visualization tools
heatmap_colors <- get_palette("gradient_full")

# Use with ComplexHeatmap
library(ComplexHeatmap)
Heatmap(
  mat,
  col = colorRamp2(seq(min(mat), max(mat), length = 17), heatmap_colors)
)
```

## Parameter Guide

### Main Parameters

| Parameter | Type | Default | Options |
|-----------|------|---------|---------|
| `group.by` | string | "seurat_clusters" | Any metadata column |
| `reduction` | string | "umap" | "umap", "tsne", "pca", etc. |
| `palette` | string/vector | "gradient_full" | See palette names |
| `alpha` | numeric | 0.8 | 0-1 |
| `pt.size` | numeric | 0.5 | >0 |
| `label` | logical | TRUE | TRUE/FALSE |
| `label.size` | numeric | 5 | >0 |
| `repel` | logical | TRUE | TRUE/FALSE |

### Styling Parameters

| Parameter | Type | Default |
|-----------|------|---------|
| `legend.position` | string | "right" |
| `bg.color` | string | "white" |
| `panel.color` | string | "grey90" |
| `axis.text.size` | numeric | 10 |
| `title` | string | NULL |
| `title.size` | numeric | 14 |
| `axis.title.size` | numeric | 12 |

## Tips & Tricks

### 1. Save Plot Parameters

```r
# Define your standard parameters
my_plot_params <- list(
  alpha = 0.75,
  pt.size = 0.6,
  label.size = 5,
  palette = "purple_elegant",
  legend.position = "right"
)

# Use with do.call
p <- do.call(plot_umap, c(list(object = seurat_obj), my_plot_params))
```

### 2. Optimize for Print

```r
# Parameters optimized for black & white printing
plot_umap(
  seurat_obj,
  palette = "neutral_pro",
  alpha = 0.9,
  bg.color = "white",
  panel.color = "white"
)
```

### 3. Optimize for Screen Display

```r
# Parameters optimized for screen viewing
plot_umap(
  seurat_obj,
  alpha = 0.7,
  pt.size = 0.8,
  panel.color = "#EFEFEF"
)
```

### 4. Extract Color Information

```r
# Get specific colors
palette <- get_palette("cool_green")

# Get unique colors for current grouping
n_unique <- length(unique(seurat_obj$seurat_clusters))
selected_colors <- palette[1:n_unique]
```

## Common Issues & Solutions

### Issue 1: Not enough colors for groups

```r
# Automatic solution: function repeats palette as needed
# Manual solution: provide custom vector
custom_palette <- rep(get_palette("gradient_full"), 3)
plot_umap(seurat_obj, palette = custom_palette)
```

### Issue 2: Overlapping labels

```r
# Use repel
plot_umap(seurat_obj, repel = TRUE)

# Adjust label size
plot_umap(seurat_obj, label.size = 4)

# Or remove labels
plot_umap(seurat_obj, label = FALSE)
```

### Issue 3: Plot too dense

```r
# Use auto-optimization
plot_umap_optimized(seurat_obj)

# Or manually adjust
plot_umap(seurat_obj, alpha = 0.5, pt.size = 0.3)
```

## Performance Tips

- Large datasets (>100K cells): Use `alpha = 0.3-0.4` and `pt.size = 0.2-0.3`
- Medium datasets (10K-100K): Use `alpha = 0.6-0.8` and `pt.size = 0.4-0.6`
- Small datasets (<10K): Use `alpha = 0.9-1.0` and `pt.size = 0.8-1.2`

## Getting Help

```r
# View function documentation
?plot_umap
?plot_umap_optimized
?list_palettes

# List all available functions
ls("package:morandipal")

# View package info
packageVersion("morandipal")
```
