plot.metaecos.replicates = function(data,
                                    response_variable) {
  
  data %>%
    
    # Create plot
    
    ggplot(aes(x = day,
               y = get(response_variable),
               group = system_nr,
               fill = system_nr,
               color = system_nr,
               linetype = size)) +
    
    # Lines
    
    geom_line(stat = "summary", fun = "mean") +
    
    # Axes and labels
    
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         linetype = "") +
    scale_x_continuous(breaks = sampling_days) +
    
    # Other graphic elements
    
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.position = legend_position,
          axis.text.x = element_text(size = paper_labels_size),
          axis.text = element_text(size = paper_labels_size),
          legend.text = element_text(size = paper_labels_size)) +
    geom_vline(xintercept = resource_flow_days,
               linetype = resource_flow_line_type,
               color = resource_flow_line_colour,
               linewidth = resource_flow_line_width)
   
}
