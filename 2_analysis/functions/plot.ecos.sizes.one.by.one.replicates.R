plot.ecos.sizes.one.by.one.replicates = function(data,
                                                 trophy_selected,
                                                 disturbance_percentage_selected,
                                                 response_variable,
                                                 legend_row_n_input = 2) {
  
  p = NULL

  for (ecosystem_size_i in 1:length(ecosystem_sizes_ml)) {
    
    p[[ecosystem_size_i]] = data %>%
      
      # Manipulate
      
      filter(ecosystem_size_ml == ecosystem_sizes_ml[ecosystem_size_i],
             trophic_type == trophy_selected,
             disturbance_percentage == disturbance_percentage_selected) %>%
      mutate(ecosystem_size_ml = factor(paste(sprintf("%.2f", ecosystem_size_ml), "ml"),
                                        levels = c("45.00 ml", "15.00 ml", "9.00 ml", "6.43 ml"))) %>%
      
      # Create plot
      
      ggplot(aes(x = day,
                 y = get(response_variable),
                 group = ecosystem_ID,
                 color = connection)) +
      
      # Lines
      
      geom_line(stat = "summary", 
                fun = "mean") +
      
      # Axes and labels
      
      labs(x = axis_names$axis_name[axis_names$variable == "day"],
           y = axis_names$axis_name[axis_names$variable == response_variable],
           color = "",
           title = paste(ecosystem_sizes_ml[ecosystem_size_i], "ml")) +
      guides(linetype = guide_legend(order = 2, title = NULL, nrow = legend_row_n_input)) +
      scale_x_continuous(breaks = unique(data$day)) +
      
      # Other graphic elements
      
      theme_bw() +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            legend.position = legend_position,
            axis.text.x = element_text(size = paper_labels_size),
            axis.text = element_text(size = paper_labels_size),
            legend.text = element_text(size = paper_labels_size)) +
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
    
    # print(paste("Showing only the replicates for", ecosystem_sizes_ml[ecosystem_size_i], "ml"))
    # print(p)
    
  }
  
  gridExtra::grid.arrange(p[[1]], p[[2]], p[[3]], p[[4]], nrow = 2, ncol = 2)
  
}
