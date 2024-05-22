plot.metaecos.points = function(data,
                                response_variable,
                                legend_rows = 4) {
  
  data %>%
    
    # Manipulate
    
    filter(!is.na(!!sym(response_variable))) %>%
    summarySE(measurevar = response_variable,
              groupvars = c("day", "size", "connection")) %>%
    
    # Create plot
    
    ggplot(aes(x = day,
               y = get(response_variable),
               group = interaction(day, size, connection),
               color = size,
               linetype = connection)) +
    
    # Points
    
    geom_point(stat = "summary",
               fun = "mean",
               position = position_dodge(dodging)) +
    geom_errorbar(aes(ymax = get(response_variable) + ci,
                      ymin = get(response_variable) - ci),
                  width = width_errorbar,
                  position = position_dodge(dodging)) +
    scale_color_manual(values = treatment_colours) +
    
    # Lines
    
    geom_line(stat = "summary",
              fun = "mean",
              aes(group = interaction(size, connection)),
              position = position_dodge(dodging),
              linewidth = treatment_lines_linewidth) +
    scale_linetype_manual(values = treatment_linetypes) +
    
    # Axes and labels
    
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         color = "") +
    guides(color = guide_legend(title = NULL,
                                nrow = legend_rows),
           linetype = guide_legend(title = NULL,
                                   nrow = legend_rows)) +
    
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
    geom_vline(xintercept = resource_flow_days,
               linetype = resource_flow_line_type,
               color = resource_flow_line_colour,
               linewidth = resource_flow_line_width)
    
  
}
