plot.metaecos.points.ES = function(data,
                                   response_variable) {
  
  data %>%
    
    # Create plot
    
    ggplot(aes(x = day,
               y = get(response_variable),
               color = size,
               group = interaction(day, size))) +
    
    # Points
    
    geom_point(stat = "summary",
               fun = "mean",
               position = position_dodge(dodging)) +
    geom_errorbar(aes(ymin = get(paste0(response_variable, "_lower")),
                      ymax = get(paste0(response_variable, "_upper"))),
                  width = 0.2,
                  position = position_dodge(dodging)) +
    scale_color_manual(values = treatment_colours) + 
    
    # Lines
    
    geom_line(stat = "summary",
              fun = "mean",
              aes(group = size),
              position = position_dodge(dodging),
              linewidth = treatment_lines_linewidth) + 
    
    # Axes and labels
    
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         color = "") +
    scale_x_continuous(breaks = unique(data$day)) +
    guides(color = guide_legend(title = NULL, nrow = 1),
           linetype = guide_legend(title = NULL, nrow = 1)) +
    
    # Other graphic elements
    
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.position = legend_position,
          legend.key.width = unit(legend_width_cm, "cm")) +
    geom_rect(xmin = grey_background_xmin, 
              xmax = grey_background_xmax,
              ymin = grey_background_ymin, 
              ymax = grey_background_ymax, 
              fill = grey_background_fill, 
              alpha = grey_background_alpha,
              color = grey_background_color) +
    geom_hline(yintercept = 0,
               linetype = zero_line_ES_line_type,
               color = zero_line_ES_colour,
               linewidth = zero_line_ES_line_width) +
    geom_vline(xintercept = resource_flow_days,
               linetype = resource_flow_line_type,
               color = resource_flow_line_colour,
               linewidth = resource_flow_line_width)
  
}
