plot.metaecos.boxplots = function(flow_input,
                                  response_variable) {
  
  if(trophic_type_input == "autotrophic"){
    colour_lowest = colour_lowest_autotrophic
    colour_highest = colour_highest_autotrophic 
  }
  
  if(trophic_type_input == "heterotrophic"){
    colour_lowest = colour_lowest_heterotrophic
    colour_highest = colour_highest_heterotrophic
  }
  
  ds_metaecosystems %>%
    filter(
      flow == flow_input
    ) %>%
    ggplot(aes(
      x = day,
      y = get(response_variable),
      group = interaction(day, patch_size_ml),
      fill = patch_size_ml
    )) +
    geom_boxplot() +
    geom_vline(
      xintercept = resource_flow_days,
      linetype = resource_flow_line_type,
      color = resource_flow_line_colour,
      linewidth = resource_flow_line_width
    ) +
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         fill = axis_names$axis_name[axis_names$variable == "patch_size_ml"]) +
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
      linewidth = zero_line_line_width
    ) +
    scale_fill_gradient(low = colour_lowest, 
                        high = colour_highest)

}
