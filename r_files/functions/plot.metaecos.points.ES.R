plot.metaecos.points.ES = function(data,
                                  metaecosystem_type_i,
                                  response_variable) {
  
  metaecosystem_type_i <- metaecosystem_type_i[order(match(metaecosystem_type_i, 
                                                           metaecosystem_types_ordered))]
  
  data_filtered = data %>%
    filter(!time_point == 0,
           system_type %in% metaecosystem_type_i)
  
  data_filtered$system_type <- factor(data_filtered$system_type, 
                                     levels = metaecosystem_type_i)
  
  data_filtered %>%
    filter(!time_point == 0,
           system_type %in% metaecosystem_type_i) %>%
    ggplot(aes(
      x = day,
      y = get(response_variable),
      color = system_type,
      group = interaction(day, system_type),
      linetype = system_type
    )) +
    geom_point(stat = "summary",
               fun = "mean",
               position = position_dodge(dodging)) +
    geom_line(
      stat = "summary",
      fun = "mean",
      aes(group = system_type),
      position = position_dodge(dodging),
      linewidth = treatment_lines_linewidth
    ) + 
    geom_errorbar(aes(ymin = get(paste0(
      response_variable, "_lower"
    )),
    ymax = get(paste0(
      response_variable, "_upper"
    ))),
    width = 0.2,
    position = position_dodge(dodging)) +
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         color = "") +
    scale_linetype_manual(
      values = c(
        parameters_treatments$linetype[parameters_treatments$treatment == metaecosystem_type_i[1]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == metaecosystem_type_i[2]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == metaecosystem_type_i[3]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == metaecosystem_type_i[4]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == metaecosystem_type_i[5]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == metaecosystem_type_i[6]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == metaecosystem_type_i[7]][1],
        parameters_treatments$linetype[parameters_treatments$treatment == metaecosystem_type_i[8]][1]
      )
    ) +
    scale_color_manual(
      values = c(
        parameters_treatments$colour[parameters_treatments$treatment == metaecosystem_type_i[1]][1],
        parameters_treatments$colour[parameters_treatments$treatment == metaecosystem_type_i[2]][1],
        parameters_treatments$colour[parameters_treatments$treatment == metaecosystem_type_i[3]][1],
        parameters_treatments$colour[parameters_treatments$treatment == metaecosystem_type_i[4]][1],
        parameters_treatments$colour[parameters_treatments$treatment == metaecosystem_type_i[5]][1],
        parameters_treatments$colour[parameters_treatments$treatment == metaecosystem_type_i[6]][1],
        parameters_treatments$colour[parameters_treatments$treatment == metaecosystem_type_i[7]][1],
        parameters_treatments$colour[parameters_treatments$treatment == metaecosystem_type_i[8]][1]
      )
    ) + 
    scale_x_continuous(breaks = unique(data$day)) +
    geom_vline(
      xintercept = resource_flow_days,
      linetype = resource_flow_line_type,
      color = resource_flow_line_colour,
      linewidth = resource_flow_line_width
    ) +
    geom_hline(
      yintercept = 0,
      linetype = zero_line_ES_line_type,
      color = zero_line_ES_colour,
      linewidth = zero_line_ES_line_width
    ) +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = legend_position,
      legend.key.width = unit(legend_width_cm, "cm")
    ) +
    guides(color = guide_legend(title = NULL,
                                nrow = 2),
           linetype = guide_legend(title = NULL,
                                   nrow = 2))
}
