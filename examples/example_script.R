# Example Script: morandipal Package Usage
# Demonstrates all main functionality

library(morandipal)
library(Seurat)

# ============================================================
# 1. List All Available Palettes
# ============================================================

list_palettes()


# ============================================================
# 2. Preview Palettes
# ============================================================

# Preview complete 17-color palette
preview_palette("complete_17")

# Preview with subset
preview_palette("warm_theme", n = 10)

# Multiple previews
preview_palette("cool_green")
preview_palette("purple_elegant")
preview_palette("neutral_pro")
preview_palette("harmony_blend")


# ============================================================
# 3. Basic UMAP Plotting
# ============================================================

# Default parameters (assuming 'seurat_obj' is available)
# plot_umap(seurat_obj)

# Custom palette
# plot_umap(seurat_obj, palette = "warm_theme")

# Multiple customizations
# plot_umap(
#   seurat_obj,
#   group.by = "cell_type",
#   reduction = "umap",
#   palette = "cool_green",
#   alpha = 0.7,
#   pt.size = 0.6,
#   label = TRUE,
#   label.size = 5,
#   repel = TRUE
# )


# ============================================================
# 4. Auto-Optimized Plotting
# ============================================================

# Automatically optimized based on cell count
# p <- plot_umap_optimized(seurat_obj)
# print(p)


# ============================================================
# 5. Get Suggested Parameters
# ============================================================

# Simulate cell counts
cell_counts <- c(3000, 8000, 25000, 75000, 150000)

cat("Suggested Parameters by Cell Count:\n")
cat("=====================================\n")

for (count in cell_counts) {
  alpha <- suggest_alpha(count)
  pt_size <- suggest_pt_size(count)
  
  cat(sprintf("Cells: %6d | Alpha: %.1f | Point Size: %.1f\n",
              count, alpha, pt_size))
}


# ============================================================
# 6. Get Color Palettes
# ============================================================

# Get full palette
warm_colors <- get_palette("warm_theme")
cat("Warm theme palette:\n")
print(warm_colors)

# Get subset of colors
colors_8 <- get_palette("gradient_full", n = 8)
cat("\nFirst 8 colors from gradient_full:\n")
print(colors_8)

# Get all palette names
all_palettes <- names(list_palettes())
cat("\nAll available palettes:\n")
print(all_palettes)


# ============================================================
# 7. Generate Color Blends
# ============================================================

# Create smooth transition between two colors
blend_10 <- generate_blend("#C1747B", "#CADD93", n = 10)
cat("\nBlend from red to yellow-green (10 colors):\n")
print(blend_10)

# Create a longer blend
blend_20 <- generate_blend("#C1747B", "#8ED19B", n = 20)
cat("\nBlend from red to green (20 colors):\n")
print(blend_20)


# ============================================================
# 8. Multiple Plotting Examples
# ============================================================

# Create example plots (commented out - requires real seurat object)

# Example 1: Multiple groupings
# plots_list <- plot_umap_interactive(
#   seurat_obj,
#   group.by.list = c("seurat_clusters", "cell_type", "batch")
# )


# Example 2: Side-by-side comparison
# library(patchwork)
# 
# p1 <- plot_umap(seurat_obj, group.by = "seurat_clusters", 
#                  palette = "cool_green", title = "Clusters")
# p2 <- plot_umap(seurat_obj, group.by = "cell_type",
#                  palette = "warm_theme", title = "Cell Type")
# 
# combined <- p1 | p2
# print(combined)


# Example 3: Adjust transparency
# p <- plot_umap(seurat_obj, alpha = 1.0)
# p_adjusted <- adjust_plot_alpha(p, alpha = 0.5)
# print(p_adjusted)


# ============================================================
# 9. Custom Parameters and Styling
# ============================================================

# Example custom plot with specific styling
# plot_umap(
#   seurat_obj,
#   group.by = "cell_type",
#   palette = "purple_elegant",
#   alpha = 0.85,
#   pt.size = 0.6,
#   label = TRUE,
#   label.size = 5,
#   label.box = FALSE,
#   legend.position = "right",
#   theme.style = "minimal",
#   bg.color = "white",
#   panel.color = "#F5F5F5",
#   axis.text.size = 11,
#   title = "My UMAP Plot",
#   title.size = 16,
#   axis.title.size = 13
# )


# ============================================================
# 10. Batch Processing Example
# ============================================================

# Create plots for multiple metadata columns
# metadata_columns <- c("seurat_clusters", "cell_type", "batch")
# palette_selection <- c("cool_green", "warm_theme", "neutral_pro")
# 
# for (i in seq_along(metadata_columns)) {
#   p <- plot_umap(
#     seurat_obj,
#     group.by = metadata_columns[i],
#     palette = palette_selection[i],
#     title = metadata_columns[i],
#     alpha = 0.8
#   )
#   
#   # Save plot
#   filename <- paste0("umap_", metadata_columns[i], ".pdf")
#   ggsave(filename, p, width = 8, height = 6, dpi = 300)
#   
#   print(p)
# }


# ============================================================
# 11. Integration with Other Packages
# ============================================================

# Use morandipal colors with other visualization tools
# Example: ggplot2

# Get color palette
colors_for_ggplot <- get_palette("harmony_blend", n = 5)

# Example data frame
# df <- data.frame(
#   category = LETTERS[1:5],
#   value = rnorm(5, mean = 10, sd = 2)
# )
#
# library(ggplot2)
# ggplot(df, aes(x = category, y = value, fill = category)) +
#   geom_col() +
#   scale_fill_manual(values = colors_for_ggplot) +
#   theme_minimal()


# ============================================================
# 12. Session Information
# ============================================================

cat("\n====== morandipal Package Info ======\n")
cat("Package Version:", packageVersion("morandipal"), "\n")
cat("Available Functions:\n")
cat("  - plot_umap()\n")
cat("  - plot_umap_optimized()\n")
cat("  - plot_umap_interactive()\n")
cat("  - get_palette()\n")
cat("  - list_palettes()\n")
cat("  - preview_palette()\n")
cat("  - suggest_alpha()\n")
cat("  - suggest_pt_size()\n")
cat("  - adjust_plot_alpha()\n")
cat("  - generate_blend()\n")
cat("======================================\n")

# Get help on specific functions
# ?plot_umap
# ?get_palette
# ?list_palettes
