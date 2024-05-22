plot.ecosystems.replicates.one.by.one = function(data,
                                                 response_variable,
                                                 legend_row_n_input = 2) {
  
  ecosystem_size_and_trophy_selected = data %>% filter(trophic_type == trophy_selected) %>% pull(ecosystem_size_and_trophy) %>% unique()
  
  for (i in 1:length(ecosystem_size_and_trophy_selected)) {
    
    p = data %>%
      
      # Manipulate
      
      filter(ecosystem_size_and_trophy == ecosystem_size_and_trophy_selected[i]) %>%
      
      # Create plot
      
      ggplot(aes(x = day,
                 y = get(response_variable),
                 group = ecosystem_ID,
                 linetype = connection)) +
      
      # Lines
      
      geom_line(stat = "summary", 
                fun = "mean") +
      scale_linetype_manual(values = treatment_linetypes) +
      
      # Axes and labels
      
      labs(x = axis_names$axis_name[axis_names$variable == "day"],
           y = axis_names$axis_name[axis_names$variable == response_variable],
           linetype = "") +
      guides(linetype = guide_legend(order = 2, title = NULL, nrow = legend_row_n_input)) +
      scale_x_continuous(breaks = unique(data$day)) +
      
      # Other graphic elements
      
      theme_bw() +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            legend.position = legend_position) +
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
    
    print(ecosystem_size_and_trophy_selected[i])
    print(p)
    
  }
  
}
