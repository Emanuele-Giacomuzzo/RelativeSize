plot.metaecos.replicates = function(data,
                                    system_type_i,
                                    response_variable) {
  
  system_type_i <- system_type_i[order(match(system_type_i, 
                                                     metaecosystem_types_ordered))]
  
  data %>%
    filter(system_type %in% system_type_i) %>%
    ggplot(
      aes(
        x = day,
        y = get(response_variable),
        group = system_nr,
        fill = system_nr,
        color = system_nr,
        linetype = system_type
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
        parameters_treatments$linetype[parameters_treatments$treatment == system_type_i[1]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == system_type_i[2]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == system_type_i[3]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == system_type_i[4]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == system_type_i[5]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == system_type_i[6]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == system_type_i[7]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == system_type_i[8]][1]
      )
    ) +
    scale_x_continuous(breaks = unique(ds_patches$day)) +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = legend_position
    )
  
}
