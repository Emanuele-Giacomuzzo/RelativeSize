plot.patches.biomass.ES = function(trophic_type_input,
                                   flow_input,
                                   response_variable) {
  
  if(trophic_type_input == "autotrophic"){
    colour_lowest = colour_lowest_autotrophic
    colour_highest = colour_highest_autotrophic 
  }
  
  if(trophic_type_input == "heterotrophic"){
    colour_lowest = colour_lowest_heterotrophic
    colour_highest = colour_highest_heterotrophic
  }
  
  ds_patches_effect_size %>%
    filter(trophic_type == trophic_type_input,
           flow == flow_input) %>%
    filter(!is.na(day), !is.na(get(response_variable))) %>%
    ggplot(aes(x = day,
               y = get(response_variable),
               group = patch_size_ml,
               color = patch_size_ml)) +
    geom_point(position = position_dodge(dodging_effect_sizes)) +
    geom_line(aes(group = patch_size_ml),
              position = position_dodge(dodging_effect_sizes)) +
    geom_errorbar(
      aes(ymin = bioarea_per_volume_d_lower,
          ymax = bioarea_per_volume_d_upper),
      width = .2,
      position = position_dodge(dodging_effect_sizes)
    ) +
    labs(
      x = x_axis_date,
      y = y_axis_patch_bioarea_ES,
      color = ""
    ) +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = legend_position
    ) +
    geom_vline(
      xintercept = resource_flow_days,
      linetype = resource_flow_line_type,
      color = resource_flow_line_color,
      linewidth = resource_flow_line_size
    ) +
    geom_hline(
      yintercept = 0,
      linetype = "dotted",
      color = "black",
      linewidth = 0.7
    ) +
    scale_color_gradient(low = colour_lowest, 
                        high = colour_highest)
  
}
