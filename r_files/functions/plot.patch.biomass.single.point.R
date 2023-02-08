plot.patch.biomass.single.point = function(metaecosystem_input,
                                           trophic_type_input,
                                           flow_input) {
  
  if(trophic_type_input == "autotrophic"){
    colour_lowest = colour_lowest_autotrophic
    colour_highest = colour_highest_autotrophic 
  }
  
  if(trophic_type_input == "heterotrophic"){
    colour_lowest = colour_lowest_heterotrophic
    colour_highest = colour_highest_heterotrophic
  }
  
  for(time_point_input in first_time_point:last_time_point) {
    
    print(paste("Time point number", time_point_input))
  
  plot = ds_patches %>%
    filter(
      time_point == time_point_input,
      metaecosystem == metaecosystem_input,
      trophic_type == trophic_type_input,
      flow == flow_input
    ) %>%
    ggplot(aes(x = patch_size_ml,
               y = bioarea_per_volume,
               group = patch_size_ml,
               fill = patch_size_ml)) +
    geom_boxplot() +
    labs(x = x_axis_patch_size,
         y = y_axis_patch_bioarea) +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = "none"
    ) +
    geom_hline(
      yintercept = 0,
      color = zero_line_colour,
      linetype = zero_line_line_type,
      linewidth = zero_line_size
    ) + 
    scale_fill_gradient(low = colour_lowest, 
                        high = colour_highest)
  
  plot
  
  print(plot)
  
  }
  
}