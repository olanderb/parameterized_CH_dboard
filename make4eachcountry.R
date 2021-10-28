library(tidyverse)
library(readxl)
library(flexdashboard)
library(tmap)

cadre_harmonise_caf_ipc <- read_excel("cadre_harmonise_caf_ipc.xlsx")

reports <- tibble(
  adm0_name = unique(cadre_harmonise_caf_ipc$adm0_name),
  filename = stringr::str_c("CH-report-", adm0_name, ".html"),
  params = purrr::map(adm0_name, ~ list(country = .))
)
reports

reports %>% 
  select(output_file = filename, params) %>% 
  purrr::pwalk(rmarkdown::render, input = "parameterized_CHdashboard.Rmd")

