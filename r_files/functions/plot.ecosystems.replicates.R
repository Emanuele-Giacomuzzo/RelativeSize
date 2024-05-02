plot.ecosystems.replicates = function(data,
                                      ecosystem_type_input,
                                      response_variable,
                                      legend_row_n_input = 2) {
  
  data %>%
    filter(ecosystem_type %in% ecosystem_type_input) %>%
    ggplot(aes(x = day,
               y = get(response_variable),
               group = ecosystem_ID,
               fill = ecosystem_ID,
               color = ecosystem_type,
               linetype = ecosystem_type)) +
    geom_line(stat = "summary", fun = "mean") +
    geom_vline(xintercept = resource_flow_days,
               linetype = resource_flow_line_type,
               color = resource_flow_line_colour,
               linewidth = resource_flow_line_width) +
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         linetype = "") +
    scale_color_manual(values = c("#e41a1c",
                                  "#e41a1c",
                                  "#4daf4a",
                                  "#4daf4a",
                                  "#377eb8",
                                  "#377eb8")) +
    scale_linetype_manual(values = treatment_linetypes) + 
    scale_x_continuous(breaks = unique(data$day)) +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.position = legend_position) +
    guides(color = guide_legend(order = 1,
                                title = NULL,
                                nrow = legend_row_n_input),
           linetype = guide_legend(order = 2,
                                   title = NULL,
                                   nrow = legend_row_n_input)) +
    geom_rect(xmin = grey_background_xmin,
              xmax = grey_background_xmax,
              ymin = grey_background_ymin,
              ymax = grey_background_ymax,
              fill = grey_background_fill,
              alpha = grey_background_alpha,
              color = grey_background_color)
  
}
