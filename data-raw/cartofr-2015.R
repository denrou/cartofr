library(dplyr)
library(fodr)
library(sf)
library(usethis)

dataset_country  <- fodr_dataset("ods", "countries-codes")
map_country      <- dataset_country$get_records(q = "cou_text_fr=France")$geo_shape[[1]][12:21] %>%
  st_polygon() %>%
  as("Spatial") %>%
  st_as_sf() %>%
  mutate(code_insee = 0, name_fr = "France")

dataset_region <- fodr_dataset("ods", "regions-francaises-openstreetmap")
map_region     <- dataset_region$get_records()
insee_outremer <- unlist(map_region[c(8, 11, 13, 16, 17), "code_insee"])
map_region     <- map_region %>%
  filter(!code_insee %in% insee_outremer) %>%
  mutate(code_insee_parent = 0) %>%
  select(code_insee, code_insee_parent, name_fr, geo_shape) %>%
  st_as_sf() %>%
  st_simplify(preserveTopology = TRUE, dTolerance = 0.05)

dataset_dept <- fodr_dataset("ods", "geoflar-departements-2015")
map_dept     <- dataset_dept$get_records() %>%
  filter(!code_reg %in% insee_outremer) %>%
  mutate(code_insee = code_dept, code_insee_parent = code_reg, name_fr = nom_dept) %>%
  st_as_sf()

dataset_insee <- fodr_dataset("ods", "code-postal-code-insee-2015")
map_insee     <- dataset_insee$get_records() %>%
  filter(!code_reg %in% insee_outremer) %>%
  mutate(code_insee = insee_com, code_insee_parent = code_dept, name_fr = nom_com) %>%
  st_as_sf()

cartofr <- list(
  country = map_country,
  region  = map_region,
  dept    = map_dept,
  insee   = map_insee
)

use_data(cartofr, overwrite = TRUE)
