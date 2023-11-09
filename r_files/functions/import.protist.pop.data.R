import.protist.pop.data = function() {
  
  #Assemble the dataset. When importing the data, each row is a video.
  time_points_ds = NULL
  for (time_point_i in 0:7) {
    
    #File paths
    pop_data_file_path = here("data", "populations", paste0("t", time_point_i, ".csv"))
    Ble_ID_file_path = here("data","species_ID_40_threshold", paste0("t", time_point_i, ".csv"))
    main_ID_file_path = here("data", "species_ID_13_threshold", paste0("t", time_point_i, ".csv"))
    
    #Import data
    species_ID_Ble = read.csv(Ble_ID_file_path) %>%
      select(file,
             Ble,
             Cep,
             Spi)
    
    species_ID_main = read.csv(main_ID_file_path) %>%
      select(file,
             Ble:Tet) %>%
      rename(
        Ble_main_analysis = Ble,
        Cep_main_analysis = Cep,
        Spi_main_analysis = Spi
      )
    
    #Merge data
    time_points_ds[[time_point_i + 1]] = read.csv(pop_data_file_path) %>%
      left_join(species_ID_Ble,
                by = "file") %>%
      left_join(species_ID_main,
                by = "file")
    
    #Manipulate columns
    time_points_ds[[time_point_i + 1]] = time_points_ds[[time_point_i + 1]] %>%
      mutate(time_point = time_point_i,
             day = sampling_days[(time_point_i + 1)],
             file = as.double(str_extract(file, "\\d+"))) %>%
      rename(Spi_te = Spi.te) %>%
      select(
        time_point,
        day,
        file,
        culture_ID,
        bioarea_per_volume,
        indiv_per_volume,
        Ble,
        Cep,
        Col,
        Eup,
        Lox,
        Pau,
        Pca,
        Spi,
        Spi_te,
        Tet,
        Ble_main_analysis,
        Cep_main_analysis,
        Spi_main_analysis
      )
    
  }
  
  ds_patches = time_points_ds %>%
    bind_rows() %>%
    left_join(culture_info,
              by = "culture_ID") 
  
  return(ds_patches)
  
}
