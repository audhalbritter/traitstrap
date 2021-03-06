#' Bootstrap traits
#' @description Bootstrap impute traits
#' @param imputed_traits imputed trait and community data in long format
#' @param nrep number of bootstrap replicates
#' @param sample_size number of plants per sample
#' @description
#'
#' @return a tibble
#'
#' @importFrom stats var
#' @importFrom e1071 skewness kurtosis
#' @importFrom magrittr %>%
#' @importFrom dplyr slice_sample group_by summarise
#' @importFrom purrr map_dfr
#' @examples 
#' data(community)
#' data(trait)
#' imputed_traits <-trait_impute(comm = community, traits = trait,
#'                  scale_hierarchy = c("Site", "PlotID"),
#'                  taxon_col = "Taxon", value_col = "Value",
#'                  trait_col = "Trait", abundance_col = "Cover")
#' boot_traits <- trait_np_bootstrap(imputed_traits)
#' @export

trait_np_bootstrap <- function(imputed_traits, nrep = 100, sample_size = 200) {
  #  stopifnot(class(traits_com) == "imputed_traits")
  attrib <- attr(imputed_traits, "attrib")
  value_col <- attrib$value_col
  bootstrap_moments <- map_dfr(
    1:nrep,
    ~ {
      slice_sample(imputed_traits, n = sample_size,
                   replace = TRUE, weight_by = weight) %>%
        # get all the happy moments
        summarise(
          mean = mean(.data[[value_col]]),
          variance = var(.data[[value_col]]),
          skewness = skewness(.data[[value_col]]),
          kurtosis = kurtosis(.data[[value_col]])
        )
      },
    .id = "n"
  )

  attr(bootstrap_moments, "attrib") <- attrib

  # make bootstrap_moments an ordinary tibble
  class(bootstrap_moments) <-
    class(bootstrap_moments)[!class(bootstrap_moments) == "imputed_trait"]
  return(bootstrap_moments)
}
