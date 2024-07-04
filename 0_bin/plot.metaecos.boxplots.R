plot.metaecos.boxplots = function(data,
                                  system_type_input,
                                  response_variable) {
  
  data %>%
    filter(
      system_type %in% system_type_input
    ) %>%
    ggplot(aes(
      x = day,
      y = get(response_variable),
      group = interaction(day, system_type),
      fill = system_type
    )) +
    geom_boxplot(width = boxplot_width) +
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         fill = "") +
    scale_linetype_manual(values = scale_linetype) +
    scale_fill_manual(values = colours) +
    geom_vline(
      xintercept = resource_flow_days,
      linetype = resource_flow_line_type,
      color = resource_flow_line_colour,
      linewidth = resource_flow_line_width
    ) +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = legend_position
    )
  
}
