plot.patches.replicates = function(data,
                                   patch_type_input,
                                   response_variable) {
  
  patch_type_input <- patch_type_input[order(match(patch_type_input, 
                                                   patch_types_ordered))]
  
  
  data %>%
    filter(patch_type %in% patch_type_input) %>%
    ggplot(
      aes(
        x = day,
        y = get(response_variable),
        group = culture_ID,
        fill = culture_ID,
        color = culture_ID,
        linetype = patch_type
      )
    ) +
    geom_line(stat = "summary", fun = "mean") +
    geom_vline(
      xintercept = resource_flow_days,
      linetype = resource_flow_line_type,
      color = resource_flow_line_colour,
      linewidth = resource_flow_line_width
    ) +
    labs(
      x = axis_names$axis_name[axis_names$variable == "day"],
      y = axis_names$axis_name[axis_names$variable == response_variable],
      linetype = ""
    ) +
    scale_linetype_manual(
      values = c(
        parameters_treatments$linetype[parameters_treatments$treatment == patch_type_input[1]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == patch_type_input[2]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == patch_type_input[3]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == patch_type_input[4]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == patch_type_input[5]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == patch_type_input[6]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == patch_type_input[7]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == patch_type_input[8]][1]
      )
    ) +
    scale_x_continuous(breaks = unique(data$day)) +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = legend_position
    )
  
}
