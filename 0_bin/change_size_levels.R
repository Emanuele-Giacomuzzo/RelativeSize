ds_metaecosystems = ds_metaecosystems %>%
  mutate(size = factor(case_when(size == "S" ~ "6.43 ml",
                                 size == "SM" ~ "9.00 ml",
                                 size == "ML" ~ "15.00 ml",
                                 size == "L" ~ "45.00 ml"),
                       levels = c("6.43 ml", "9.00 ml", "15.00 ml", "45.00 ml")))