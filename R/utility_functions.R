#' Get Color Palette
#'
#' @description Retrieve a specific color palette or subset of colors
#'
#' @param palette Palette name or vector of hex colors
#' @param n Number of colors to return (default: NULL for all)
#'
#' @return Character vector of hex color codes
#'
#' @examples
#' \dontrun{
#' # Get full palette
#' colors <- get_palette("warm_theme")
#'
#' # Get first 8 colors
#' colors_8 <- get_palette("gradient_full", n = 8)
#' }
#'
#' @export

get_palette <- function(palette = "gradient_full", n = NULL) {

  if (is.character(palette) && length(palette) == 1) {
    if (!(palette %in% names(morandi_palettes))) {
      stop(paste("Palette not found. Available palettes:",
                 paste(names(morandi_palettes), collapse = ", ")))
    }
    colors <- morandi_palettes[[palette]]
  } else {
    colors <- palette
  }

  if (!is.null(n)) {
    if (n > length(colors)) {
      warning(paste("Requested colors exceed palette size. Returning all", length(colors), "colors."))
      return(colors)
    }
    return(colors[1:n])
  }

  return(colors)
}


#' List Available Palettes
#'
#' @description Display all available color palettes with their descriptions
#'
#' @return Character vector of palette names
#'
#' @examples
#' \dontrun{
#' list_palettes()
#' }
#'
#' @export

list_palettes <- function() {

  palettes_info <- data.frame(
    name = c(
      "complete_17",
      "warm_theme",
      "cool_green",
      "purple_elegant",
      "neutral_pro",
      "harmony_blend",
      "gradient_full"
    ),
    colors = c(17, 15, 15, 15, 15, 15, 17),
    description = c(
      "Full 17-color palette",
      "Warm colors (red, gold, pink)",
      "Cool colors (cyan, green, mint)",
      "Purple and pink shades",
      "Professional neutral grays",
      "Balanced multi-color blend",
      "Complete gradient from dark to light"
    ),
    use_case = c(
      "General use",
      "Heat maps, time series",
      "Cell types, clustering",
      "Academic publication",
      "Reports, printing",
      "Multi-dimensional analysis",
      "Gradient visualization"
    )
  )

  cat("\n=== Morandi Color Palettes ===\n\n")
  print(palettes_info, row.names = FALSE)
  cat("\nUsage: get_palette('palette_name')\n")

  invisible(palettes_info)
}


#' Preview Color Palette
#'
#' @description Visualize a color palette
#'
#' @param palette Palette name or vector of hex colors
#' @param n Number of colors to show (default: NULL for all)
#' @param title Plot title
#' @param include_hex Whether to display hex codes
#'
#' @return A ggplot object showing the color palette
#'
#' @examples
#' \dontrun{
#' preview_palette("warm_theme")
#' preview_palette("gradient_full", n = 10)
#' }
#'
#' @importFrom ggplot2 ggplot aes geom_tile geom_text scale_fill_identity
#'
#' @export

preview_palette <- function(palette = "gradient_full",
                            n = NULL,
                            title = NULL,
                            include_hex = TRUE) {

  colors <- get_palette(palette, n)

  if (is.null(title)) {
    if (is.character(palette) && length(palette) == 1) {
      title <- palette
    } else {
      title <- "Custom Palette"
    }
  }

  df <- data.frame(
    x = 1:length(colors),
    y = 1,
    color = colors,
    hex = colors
  )

  p <- ggplot2::ggplot(df, ggplot2::aes(x = x, y = y, fill = color)) +
    ggplot2::geom_tile(width = 0.95, height = 0.95) +
    ggplot2::scale_fill_identity()

  if (include_hex) {
    p <- p +
      ggplot2::geom_text(
        ggplot2::aes(label = hex),
        color = "black",
        size = 3,
        angle = 0
      )
  }

  p <- p +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      axis.text = ggplot2::element_blank(),
      axis.title = ggplot2::element_blank(),
      panel.grid = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(hjust = 0.5, size = 12, face = "bold"),
      plot.background = ggplot2::element_rect(fill = "white", color = NA),
      panel.background = ggplot2::element_rect(fill = "white", color = NA)
    ) +
    ggplot2::ggtitle(title)

  return(p)
}


#' Generate Color Blend
#'
#' @description Create smooth blend between two colors
#'
#' @param color1 First color (hex code)
#' @param color2 Second color (hex code)
#' @param n Number of interpolated colors
#'
#' @return Character vector of hex colors
#'
#' @examples
#' \dontrun{
#' blend <- generate_blend("#C1747B", "#CADD93", n = 10)
#' }
#'
#' @export

generate_blend <- function(color1, color2, n = 10) {

  # Convert hex to RGB
  rgb1 <- grDevices::col2rgb(color1) / 255
  rgb2 <- grDevices::col2rgb(color2) / 255

  # Generate interpolation
  seq_vals <- seq(0, 1, length.out = n)

  blend_colors <- sapply(seq_vals, function(t) {
    r <- rgb1[1] * (1 - t) + rgb2[1] * t
    g <- rgb1[2] * (1 - t) + rgb2[2] * t
    b <- rgb1[3] * (1 - t) + rgb2[3] * t
    grDevices::rgb(r, g, b)
  })

  return(blend_colors)
}


#' Optimal Alpha for Density
#'
#' @description Suggest optimal alpha value based on cell count
#'
#' @param n_cells Number of cells
#'
#' @return Optimal alpha value (0-1)
#'
#' @details
#' Returns suggested alpha based on data density:
#' - < 5000 cells: 1.0 (opaque)
#' - 5000-10000: 0.9
#' - 10000-50000: 0.8
#' - 50000-100000: 0.6
#' - > 100000: 0.4
#'
#' @examples
#' \dontrun{
#' alpha <- suggest_alpha(10000)
#' }
#'
#' @export

suggest_alpha <- function(n_cells) {

  if (n_cells < 5000) {
    return(1.0)
  } else if (n_cells < 10000) {
    return(0.9)
  } else if (n_cells < 50000) {
    return(0.8)
  } else if (n_cells < 100000) {
    return(0.6)
  } else {
    return(0.4)
  }
}


#' Optimal Point Size for Visualization
#'
#' @description Suggest optimal point size based on cell count
#'
#' @param n_cells Number of cells
#'
#' @return Optimal point size
#'
#' @details
#' Returns suggested point size based on data density:
#' - < 5000: 1.5
#' - 5000-10000: 1.2
#' - 10000-50000: 0.8
#' - 50000-100000: 0.5
#' - > 100000: 0.3
#'
#' @examples
#' \dontrun{
#' pt.size <- suggest_pt_size(50000)
#' }
#'
#' @export

suggest_pt_size <- function(n_cells) {

  if (n_cells < 5000) {
    return(1.5)
  } else if (n_cells < 10000) {
    return(1.2)
  } else if (n_cells < 50000) {
    return(0.8)
  } else if (n_cells < 100000) {
    return(0.5)
  } else {
    return(0.3)
  }
}


#' Auto-optimize UMAP Plot
#'
#' @description Create UMAP plot with automatically optimized parameters
#'
#' @param object A Seurat object
#' @param group.by Metadata column to color by
#' @param palette Color palette name
#' @param ... Additional arguments passed to plot_umap
#'
#' @return A ggplot object with optimized parameters
#'
#' @examples
#' \dontrun{
#' p <- plot_umap_optimized(seurat_obj, group.by = "seurat_clusters")
#' }
#'
#' @export

plot_umap_optimized <- function(object,
                                group.by = "seurat_clusters",
                                palette = "gradient_full",
                                ...) {

  n_cells <- ncol(object)
  alpha <- suggest_alpha(n_cells)
  pt_size <- suggest_pt_size(n_cells)

  plot_umap(
    object,
    group.by = group.by,
    palette = palette,
    alpha = alpha,
    pt.size = pt_size,
    ...
  )
}
