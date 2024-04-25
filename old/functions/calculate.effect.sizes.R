#RelativeSize
calculate.effect.sizes = function() {
  
  patch_type_count = 0
  for (patch_type_name in patch_treatments_and_controls$treatment) {
    patch_type_count = patch_type_count + 1
    variable_count = 0
      for (variable_i in patch_variables) {
        variable_count = variable_count + 1
        for (time_point_i in time_points) {
          if(time_point_i == 0) next
          
          isolated_type_name = patch_treatments_and_controls %>%
            filter(treatment == patch_type_name) %>%
            pull(control)
          
          treatment_and_control_rows = ds_patches %>%
            filter(patch_type == patch_type_name | patch_type == isolated_type_name,
                   time_point == time_point_i,
                   !is.na(!!sym(variable_i))) %>%
            group_by_at(all_of(columns_to_group_by)) %>%
            summarise(across(.cols = variable_i,
                             .fns = list(mean = mean,
                                  sd = sd)),
                      sample_size = n()) %>%
            rename_with(~ paste0(variable_i, "_sample_size"),
                        matches("sample_size")) %>%
            mutate(!!paste0(variable_i, "_d") := NA,
                   !!paste0(variable_i, "_d_upper") := NA,
                   !!paste0(variable_i, "_d_lower") := NA)
          
          treatment_row = treatment_and_control_rows %>%
            filter(patch_type == patch_type_name)
          
          control_row = treatment_and_control_rows %>%
            filter(patch_type == isolated_type_name)
          
          hedges_d = calculate.hedges_d(
            treatment_row[[paste0(variable_i, "_mean")]],
            treatment_row[[paste0(variable_i, "_sd")]],
            treatment_row[[paste0(variable_i, "_sample_size")]],
            control_row[[paste0(variable_i, "_mean")]],
            control_row[[paste0(variable_i, "_sd")]],
            control_row[[paste0(variable_i, "_sample_size")]]
          )
          
          new_row = treatment_and_control_rows %>%
            filter(patch_type == patch_type_name) %>%
            mutate(!!paste0(variable_i, "_d") := hedges_d$d,
                   !!paste0(variable_i, "_d_upper") := hedges_d$upper_CI,
                   !!paste0(variable_i, "_d_lower") := hedges_d$lower_CI)
          
          if (!exists("ds_patches_effect_size")) {ds_patches_effect_size = new_row} else
          {ds_patches_effect_size = rbind(ds_patches_effect_size, new_row)}
          
        }
      }
    }
  
  ds_patches_effect_size %>%
    group_by_at(all_of(columns_to_group_by)) %>%
    summarise(across(ends_with("_d") | ends_with("_d_upper") | ends_with("_d_lower"), list(mean = mean)))
  
  return(ds_patches_effect_size)
  
}
