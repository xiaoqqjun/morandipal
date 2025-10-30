#' Enhanced UMAP Plotting with Morandi Color Palettes
#'
#' @description Creates publication-quality UMAP plots with customizable
#' Morandi-style color palettes, transparency, and styling parameters.
#'
#' @param object A Seurat object containing dimensionality reduction data
#' @param group.by Metadata column to color by (default: "seurat_clusters")
#' @param reduction Dimensionality reduction to plot (default: "umap")
#' @param palette Color palette name or vector of hex colors
#' (default: "gradient_full")
#' @param alpha Transparency level from 0 to 1 (default: 0.8)
#' @param pt.size Point size for individual cells (default: 0.5)
#' @param label Whether to add cluster labels (default: TRUE)
#' @param label.size Size of cluster labels (default: 5)
#' @param repel Whether to repel overlapping labels (default: TRUE)
#' @param label.box Whether to add box around labels (default: FALSE)
#' @param legend.position Position of legend: "right", "left", "top", "bottom", "none"
#' (default: "right")
#' @param theme.style Background and panel theme ("minimal", "bw", "classic")
#' (default: "minimal")
#' @param bg.color Background color (default: "white")
#' @param panel.color Panel background color (default: "grey90")
#' @param axis.text.size Font size for axis text (default: 10)
#' @param title Plot title (default: NULL)
#' @param title.size Font size for title (default: 14)
#' @param axis.title.size Font size for axis titles (default: 12)
#'
#' @return A ggplot object with the UMAP plot
#'
#' @details
#' This function combines Seurat's DimPlot with optimized Morandi color palettes
#' and enhanced visual customization. It automatically applies optimal transparency
#' and sizing for different data densities.
#'
#' @examples
#' \dontrun{
#' # Basic usage with default palette
#' plot_umap(seurat_obj)
#'
#' # Custom parameters
#' plot_umap(seurat_obj,
#'           group.by = "cell_type",
#'           palette = "warm_theme",
#'           alpha = 0.7,
#'           pt.size = 0.8)
#'
#' # Using custom color vector
#' custom_colors <- c("#C1747B", "#BDD9B6", "#DBB0D4")
#' plot_umap(seurat_obj,
#'           palette = custom_colors,
#'           alpha = 0.9)
#' }
#'
#' @importFrom Seurat DimPlot
#' @importFrom ggplot2 theme_minimal theme element_rect element_text labs
#'
#' @export

plot_umap <- function(
    object,
    group.by = "seurat_clusters",
    reduction = "umap",
    palette = "gradient_full",
    alpha = 0.8,
    pt.size = 0.8,
    label = TRUE,
    label.size = 5,
    repel = TRUE,
    split.by = NULL,      
    ncol = 1,             
    legend.position = "right",
    theme.style = "minimal",
    bg.color = "white",
    panel.color = "grey90",
    axis.text.size = 10,
    title = NULL,
    title.size = 14,
    axis.title.size = 12)  {

  # Validate inputs
  if (!inherits(object, "Seurat")) {
    stop("object must be a Seurat object")
  }

  if (!(reduction %in% names(object@reductions))) {
    stop(paste("Reduction", reduction, "not found in object"))
  }

  if (!(group.by %in% names(object@meta.data))) {
    stop(paste("Metadata column", group.by, "not found"))
  }

  # Handle palette input
  if (is.character(palette) && length(palette) == 1) {
    if (palette %in% names(morandi_palettes)) {
      colors <- morandi_palettes[[palette]]
    } else {
      stop(paste("Palette", palette, "not found. Available palettes:",
                 paste(names(morandi_palettes), collapse = ", ")))
    }
  } else {
    colors <- palette
  }

  # Ensure sufficient colors for unique groups
  n_groups <- length(unique(object@meta.data[[group.by]]))
  if (length(colors) < n_groups) {
    colors <- rep(colors, ceiling(n_groups / length(colors)))
    colors <- colors[1:n_groups]
  } else {
    colors <- colors[1:n_groups]
  }

  # Create base plot
  p <- Seurat::DimPlot(
    object,
    group.by = group.by,
    reduction = reduction,
    label = label,
    label.size = label.size,
    pt.size = pt.size,
    repel = repel,
    split.by = split.by,    
    ncol = ncol,            
    cols = colors
  )

  # Apply alpha transparency
  if (alpha < 1) {
    p$layers[[1]]$aes_params$alpha <- alpha
  }

  # Apply theme customization
  p <- p +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      plot.background = ggplot2::element_rect(fill = bg.color, color = NA),
      panel.background = ggplot2::element_rect(fill = panel.color, color = NA),
      panel.grid = ggplot2::element_blank(),
      axis.text = ggplot2::element_text(size = axis.text.size),
      axis.title = ggplot2::element_text(size = axis.title.size),
      legend.position = legend.position,
      plot.title = ggplot2::element_text(
        size = title.size,
        hjust = 0.5,
        face = "bold"
      )
    )

  # Add title if provided
  if (!is.null(title)) {
    p <- p + ggplot2::ggtitle(title)
  }

  return(p)
}


#' Interactive UMAP with Multiple Grouping Options
#'
#' @description Creates a side-by-side UMAP comparison for different metadata columns
#'
#' @param object A Seurat object
#' @param group.by.list List of metadata columns to plot
#' @param reduction Dimensionality reduction to plot
#' @param palette Color palette name or list of palettes
#' @param alpha Transparency level
#' @param pt.size Point size
#' @param  Number of columns in the plot arrangement
#'
#' @return A list of ggplot objects
#'
#' @examples
#' \dontrun{
#' plots <- plot_umap_interactive(seurat_obj,
#'                                group.by.list = c("seurat_clusters",
#'                                                   "cell_type"))
#' }
#'
#' @export

plot_umap_interactive <- function(
    object,
    group.by.list = NULL,
    reduction = "umap",
    palette = "gradient_full",
    alpha = 0.8,
    pt.size = 0.5,
     = 1) {

  if (is.null(group.by.list)) {
    stop("group.by.list must be provided")
  }

  plots <- list()

  for (i in seq_along(group.by.list)) {
    plots[[i]] <- plot_umap(
      object,
      group.by = group.by.list[i],
      reduction = reduction,
      palette = palette,
      alpha = alpha,
      pt.size = pt.size
    )
  }

  return(plots)
}


#' Adjust Plot Transparency
#'
#' @description Modify alpha transparency of an existing plot
#'
#' @param plot A ggplot object
#' @param alpha New alpha value (0-1)
#' @param layer Layer index to modify (default: 1)
#'
#' @return Modified ggplot object
#'
#' @examples
#' \dontrun{
#' p <- plot_umap(seurat_obj, alpha = 1.0)
#' p_transparent <- adjust_plot_alpha(p, alpha = 0.5)
#' }
#'
#' @export

adjust_plot_alpha <- function(plot, alpha = 0.7, layer = 1) {
  if (alpha < 0 || alpha > 1) {
    stop("alpha must be between 0 and 1")
  }

  if (length(plot$layers) < layer) {
    stop(paste("Layer", layer, "not found in plot"))
  }

  plot$layers[[layer]]$aes_params$alpha <- alpha
  return(plot)
}
