#' List of France's Geographical Information
#'
#' A list of 4 datasets containing geographical information about French administration borders.
#'
#' @format A named list of 4 datasets:
#' \describe{
#'   \item{country}{The external border of France}
#'   \item{region}{The name and code of French regions}
#'   \item{dept}{The name and code of French departments}
#'   \item{insee}{The name and code of French towns}
#' }
#'
#' @details Each dataset is in the `sf` format and contains at least 4 features:
#' \describe{
#'   \item{name_fr}{The name of county}
#'   \item{code_insee}{The code of the county}
#'   \item{code_insee_parent}{The code of the parent level county}
#'   \item{geo_shape}{A list of geo_shape informations which can be ploted.}
#' }
#'
#' @source Sources for all 4 datasets:
#' \describe{
#'   \item{country}{\url{https://data.opendatasoft.com/explore/dataset/countries-codes@public/information/?lang=fr}}
#'   \item{region}{\url{https://data.opendatasoft.com/explore/dataset/regions-francaises-openstreetmap@public/information/?lang=fr}}
#'   \item{dept}{\url{https://data.opendatasoft.com/explore/dataset/geoflar-departements-2015@public/information/?lang=fr}}
#'   \item{insee}{\url{https://data.opendatasoft.com/explore/dataset/code-postal-code-insee-2015@public/information/?lang=fr}}
#' }
#'
"cartofr"
