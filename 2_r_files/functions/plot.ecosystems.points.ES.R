plot.ecosystems.points.ES = function(data,
                                     trophic_type_selected,
                                     size_effect_selected,
                                     response_variable) {
  
  data %>%
    filter(time_point > 1,
           trophic_type == trophic_type_selected,
           size_effects == size_effect_selected) %>%
    ggplot(aes(x = day,
               y = get(response_variable),
               color = ecosystem_size_and_trophy,
               group = interaction(day, ecosystem_size_and_trophy))) +
    geom_point(stat = "summary",
               fun = "mean",
               position = position_dodge(dodging)) +
    geom_line(stat = "summary",
              fun = "mean",
              aes(group = ecosystem_size_and_trophy),
              position = position_dodge(dodging),
              linewidth = treatment_lines_linewidth) + 
    geom_errorbar(aes(ymin = get(paste0(response_variable, "_lower")),
                      ymax = get(paste0(response_variable, "_upper"))),
                  width = 0.2,
                  position = position_dodge(dodging)) +
    scale_x_continuous(breaks = unique(data$day)) +
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         color = "") +
    scale_color_manual(values = treatment_colours) + 
    scale_x_continuous(breaks = unique(data$day)) +
    geom_vline(xintercept = resource_flow_days,
               linetype = resource_flow_line_type,
               color = resource_flow_line_colour,
               linewidth = resource_flow_line_width) +
    geom_hline(yintercept = 0,
               linetype = zero_line_ES_line_type,
               color = zero_line_ES_colour,
               linewidth = zero_line_ES_line_width) +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.position = legend_position,
          legend.key.width = unit(legend_width_cm, "cm"),
          axis.text.x = element_text(size = paper_labels_size),
          axis.text = element_text(size = paper_labels_size),
          legend.text = element_text(size = paper_labels_size)) +
    guides(color = guide_legend(order = 1,
                                title = NULL,
                                nrow = 1)) +
    geom_rect(xmin = grey_background_xmin, 
              xmax = grey_background_xmax,
              ymin = grey_background_ymin, 
              ymax = grey_background_ymax, 
              fill = grey_background_fill, 
              alpha = grey_background_alpha,
              color = grey_background_color)
}
