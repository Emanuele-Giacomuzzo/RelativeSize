plot.metaecos.replicates.legend <- function(data, 
                                            response_variable) {
  
  # Create the base plot to generate the legend
  plot <- data %>%
    mutate(ecosystem_size_ml = factor(paste(sprintf("%.2f", 
                                                    ecosystem_size_ml), 
                                            "ml"),
                                      levels = c("45.00 ml", 
                                                 "15.00 ml", 
                                                 "9.00 ml", 
                                                 "6.43 ml"))) %>%
    ggplot(aes(x = day,
               y = get(response_variable),
               group = system_nr,
               fill = system_nr,
               color = system_nr,
               linetype = ecosystem_size_ml)) +
    geom_line(stat = "summary", fun = "mean") +
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         linetype = "") +
    scale_x_continuous(breaks = sampling_days) +
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
  
  # Extract the legend
  g <- ggplotGrob(plot)
  legend <- g$grobs[[which(sapply(g$grobs, function(x) x$name) == "guide-box")]]
  
  # Create a blank plot and add the legend as annotation
  legend_plot <- ggplot() + 
    annotation_custom(legend) + 
    theme_void()
  
  return(legend_plot)
}
