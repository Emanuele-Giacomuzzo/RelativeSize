#Function checked on 2/11/2023
import.protist.morph.data = function() {
  
  time_points_ds = NULL
  for (time_point_i in 0:7) {
    
    time_points_ds[[time_point_i+1]] = read.csv(here("data", "individuals", paste0("t", time_point_i,".csv"))) %>%
      mutate(file =  as.numeric(str_extract(file, "\\d+"))) #Extracts file number from string
    
    time_points_ds[[time_point_i+1]] = time_points_ds[[time_point_i+1]] %>%
      mutate(time_point = time_point_i,
             day = sampling_days[time_point_i + 1]) %>%
      select(time_point,
             day,
             file,
             culture_ID,
             mean_area,
             N_frames)
    
  }
  
  ds_individuals = time_points_ds %>%
    bind_rows() %>%
    left_join(culture_info,
              by = "culture_ID") %>%
    select(time_point,
           day, 
           file, 
           culture_ID, 
           system_nr,
           eco_metaeco_type,
           flow,
           flow_ml,
           patch_size,
           patch_size_ml,
           trophic_type,
           metaecosystem, 
           metaecosystem_type,
           patch_size_ml, 
           mean_area,
           N_frames
    )
  
  return(ds_individuals)
  
}
