plot_metaecos_biomass = function(flow_input) {
  
  if(trophic_type_input == "autotrophic"){
    colour_lowest = colour_lowest_autotrophic
    colour_highest = colour_highest_autotrophic 
  }
  
  if(trophic_type_input == "heterotrophic"){
    colour_lowest = colour_lowest_heterotrophic
    colour_highest = colour_highest_heterotrophic
  }
  
  plot = ds_metaecosystems %>%
    filter(
      flow == flow_input
    ) %>%
    ggplot(aes(
      x = day,
      y = total_bioarea,
      group = interaction(day, patch_size_ml),
      fill = patch_size_ml
    )) +
    geom_boxplot() +
    geom_vline(
      xintercept = resource_flow_days,
      linetype = resource_flow_line_type,
      color = resource_flow_line_color,
      linewidth = resource_flow_line_size
    ) +
    labs(x = x_axis_date,
         y = y_axis_tot_bioarea,
         fill = legend_fill_patch_size) +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = legend_position
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
  
  return(plot)
}
