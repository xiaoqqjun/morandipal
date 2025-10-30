#' Morandi Color Palettes
#'
#' @description A collection of 17 professional Morandi-style color palettes
#' optimized for scientific visualization and single-cell RNA-seq analysis.
#'
#' @name morandi_palettes
#' @docType data
#'
#' @format A list containing 7 color palette schemes, each with carefully
#' selected hex color codes.
#'
#' @details
#' Available palettes:
#' - complete_17: Full 17-color palette
#' - warm_theme: Warm colors (red, gold, pink)
#' - cool_green: Cool colors (cyan, green, mint)
#' - purple_elegant: Purple and pink shades
#' - neutral_pro: Professional neutral grays
#' - harmony_blend: Balanced multi-color blend
#' - gradient_full: Complete gradient from dark to light
#'
#' @examples
#' data(morandi_palettes)
#' names(morandi_palettes)
#' morandi_palettes$complete_17

palette_complete_17 <- c(
  "#C1747B",  # Almond Red
  "#BDD9B6",  # Mint Green
  "#DBB0D4",  # Purple Pink
  "#929F74",  # Gray Green
  "#636363",  # Deep Gray
  "#DEA368",  # Caramel Gold
  "#8ED19B",  # Medium Green
  "#DBE6B3",  # Light Yellow-Green
  "#679AC3",  # Blue
  "#57B3C3",  # Cyan
  "#9EA0A4",  # Light Gray
  "#CADD93",  # Yellow Green
  "#E1C270",  # Golden Yellow
  "#7B537D",  # Deep Purple
  "#CF8DB4",  # Rose Pink
  "#377EB7",  # Deep Blue
  "#BDBFC3"   # Pale Gray
)

palette_warm <- c(
  "#C1747B", "#D08181", "#DF8787", "#DEA368", "#E0A873",
  "#E2AD7E", "#E1C270", "#DFC16F", "#DDBE6D", "#CF8DB4",
  "#D09BB6", "#D1A9B8", "#C89FB0", "#C295A8", "#BC8BA0"
)

palette_cool_green <- c(
  "#57B3C3", "#5FB4BF", "#67B5BB", "#8ED19B", "#8FCA9C",
  "#90C39D", "#BDD9B6", "#BAD4B2", "#B7CFAE", "#679AC3",
  "#6BA0C7", "#6FA6CB", "#7EB0D3", "#8DBADB", "#9CC4E3"
)

palette_purple_elegant <- c(
  "#7B537D", "#8A65A0", "#9977BC", "#DBB0D4", "#DAB3D5",
  "#D9B6D6", "#CF8DB4", "#D49EBC", "#D9AFC4", "#BDBFC3",
  "#C0B8BD", "#C3B1B7", "#C6AAB1", "#C9A3AB", "#CC9CA5"
)

palette_neutral_pro <- c(
  "#636363", "#737373", "#838383", "#9EA0A4", "#9BA0A3",
  "#989FA2", "#929F74", "#919D76", "#909B78", "#BDBFC3",
  "#B8BAC0", "#B3B5BD", "#AEAFBA", "#A9AAB7", "#A4A5B4"
)

palette_harmony_blend <- c(
  "#CADD93", "#C8DB94", "#C6D995", "#DBE6B3", "#D9E4B4",
  "#D7E2B5", "#377EB7", "#4B86BE", "#5F8EC5", "#8ED19B",
  "#8CCCA2", "#8AC7A9", "#88C2B0", "#86BDB7", "#84B8BE"
)

palette_gradient_full <- c(
  "#636363", "#7B537D", "#377EB7", "#929F74", "#C1747B",
  "#679AC3", "#DEA368", "#57B3C3", "#9EA0A4", "#DBB0D4",
  "#CF8DB4", "#8ED19B", "#BDD9B6", "#E1C270", "#CADD93",
  "#DBE6B3", "#BDBFC3"
)

morandi_palettes <- list(
  complete_17 = palette_complete_17,
  warm_theme = palette_warm,
  cool_green = palette_cool_green,
  purple_elegant = palette_purple_elegant,
  neutral_pro = palette_neutral_pro,
  harmony_blend = palette_harmony_blend,
  gradient_full = palette_gradient_full
)

usethis::use_data(morandi_palettes, overwrite = TRUE)
