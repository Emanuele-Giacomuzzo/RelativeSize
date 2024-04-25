plot.metaecos.points = function(data,
                                response_variable,
                                legend_rows = 4) {
  
  metaecosystem_type_i = unique(ds_metaecosystems$metaecosystem_type)
  metaecosystem_type_i = metaecosystem_type_i[order(match(metaecosystem_type_i,
                                                          metaecosystem_types_ordered))]
  data %>%
    filter(!is.na(!!sym(response_variable))) %>%
    summarySE(measurevar = response_variable,
              groupvars = c("day", "size", "connection")) %>%
    ggplot(aes(x = day,
               y = get(response_variable),
               group = interaction(day, size, connection),
               color = size,
               linetype = connection)) +
    geom_point(stat = "summary",
               fun = "mean",
               position = position_dodge(dodging)) +
    geom_line(stat = "summary",
              fun = "mean",
              aes(group = interaction(size, connection)),
              position = position_dodge(dodging),
              linewidth = treatment_lines_linewidth) +
    geom_errorbar(aes(ymax = get(response_variable) + ci,
                      ymin = get(response_variable) - ci),
                  width = width_errorbar,
                  position = position_dodge(dodging)) +
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         color = "") +
    scale_linetype_manual(values = scale_linetype) +
    scale_color_manual(values = colours) +
    geom_vline(xintercept = resource_flow_days,
               linetype = resource_flow_line_type,
               color = resource_flow_line_colour,
               linewidth = resource_flow_line_width) +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.position = legend_position,
          legend.key.width = unit(legend_width_cm, "cm")) +
    guides(color = guide_legend(title = NULL,
                                nrow = legend_rows),
           linetype = guide_legend(title = NULL,
                                   nrow = legend_rows))
  
}
