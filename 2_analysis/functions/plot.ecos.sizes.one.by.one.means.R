plot.ecos.sizes.one.by.one.means = function(data = ds_ecosystems,
                                            trophy_selected = "heterotrophic",
                                            response_variable_selected = "simpson",
                                            light_colour = light_colour_hetero,
                                            dark_colour = dark_colour_hetero,
                                            y_upper_limit = 2.4,
                                            legend_row_n_selected = 1) {
  
  # Set parameters & initialise list to store plots
  
  if (trophy_selected == "autotrophic") {
    treatment_colours = treatment_colours_autotrophic
  } 
  if (trophy_selected == "heterotrophic") {
    treatment_colours = treatment_colours_heterotrophic
  }
  
  p = list()
  
  # Plot ecosystems size by size
  
  # Inside the loop where plots are created
  
  for (i in 1:length(ecosystem_sizes_ml)) {
  
  # Prepare data
    
  data_for_plotting = data %>%
    filter(ecosystem_size_ml == ecosystem_sizes_ml[i],
           trophic_type == trophy_selected) %>%
    mutate(ecosystem_size_ml = factor(paste(sprintf("%.2f", ecosystem_size_ml), "ml"),
                                      levels = c("45.00 ml", "15.00 ml", "9.00 ml", "6.43 ml"))) %>%
    summarySE(measurevar = response_variable_selected,
              groupvars = c("day",
                            "ecosystem_size_ml", 
                            "connection", 
                            "disturbance_percentage")) %>%
    filter(complete.cases(.)) 
  
  # Plot data
  p[[i]] = data_for_plotting %>%
    ggplot(aes(x = day,
               y = get(response_variable_selected),
               group = interaction(day, connection, disturbance_percentage),
               color = disturbance_percentage,
               linetype = connection)) +
    geom_point(stat = "summary",
               fun = "mean",
               position = position_dodge(dodging),
               size = treatment_points_size_small) +
    geom_line(stat = "summary",
              fun = "mean",
              aes(group = interaction(ecosystem_size_ml, connection, disturbance_percentage)),
              position = position_dodge(dodging),
              linewidth = treatment_lines_linewidth) +
    geom_errorbar(aes(ymax = get(response_variable_selected) + ci,
                      ymin = get(response_variable_selected) - ci),
                  width = width_errorbar,
                  position = position_dodge(dodging)) +
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable_selected],
         color = "") +
    scale_x_continuous(breaks = unique(data$day)) +
    scale_color_manual(values = c(dark_colour, light_colour),
                       labels = disturbance_labels) +
    scale_linetype_manual(values = treatment_linetypes) +
    geom_vline(xintercept = resource_flow_days,
               linetype = resource_flow_line_type,
               color = resource_flow_line_colour,
               linewidth = resource_flow_line_width) +
    geom_hline(yintercept = 0,
               color = zero_line_colour,
               linetype = zero_line_line_type,
               linewidth = zero_line_line_width) +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.key.width = unit(legend_width_cm, "cm"),
          axis.text = element_text(size = paper_labels_size),
          legend.text = element_text(size = paper_labels_size)) +
    geom_rect(xmin = grey_background_xmin, 
              xmax = grey_background_xmax,
              ymin = grey_background_ymin, 
              ymax = grey_background_ymax, 
              fill = grey_background_fill, 
              alpha = grey_background_alpha,
              color = grey_background_color) +
    guides(color = guide_legend(title = NULL,
                                nrow = legend_row_n_selected),
           linetype = guide_legend(title = NULL,
                                   nrow = legend_row_n_selected)) +
    annotate("text", x = -Inf, y = Inf, label = paste(ecosystem_sizes_ml[i], "ml"), hjust = -0.5, vjust = 1.5, size = 5)  # Add (a), (b), (c), (d)
    
  # Set y-axis limits to go only up to a certain upper limit
  p[[i]] = p[[i]] + coord_cartesian(ylim = c(0, y_upper_limit))  # Use coord_cartesian to set y-axis limits

  # Remove x-axis for top plots
  if (i %in% c(1, 2)) {
    p[[i]] = p[[i]] + theme(axis.title.x = element_blank(),
                            axis.text.x = element_blank(),
                            axis.ticks.x = element_blank())
  }
  
  # Remove y-axis for right-hand plots
  if (i %in% c(2, 4)) {
    p[[i]] = p[[i]] + theme(axis.title.y = element_blank(),
                            axis.text.y = element_blank(),
                            axis.ticks.y = element_blank())
  }
  
  # Remove the legend for the 2nd, 3rd, and 4th plots
  if (i %in% c(2, 3, 4)) {
    p[[i]] = p[[i]] + theme(legend.position = "none")
  }

    
    # Remove x-axis for top plots
    if (i %in% c(1, 2)) {
      p[[i]] = p[[i]] + theme(axis.title.x = element_blank(),
                              axis.text.x = element_blank(),
                              axis.ticks.x = element_blank())
    }
    
    # Remove y-axis for right-hand plots
    if (i %in% c(2, 4)) {
      p[[i]] = p[[i]] + theme(axis.title.y = element_blank(),
                              axis.text.y = element_blank(),
                              axis.ticks.y = element_blank())
    }
    
    # Remove the legend for the 2nd, 3rd, and 4th plots
    if (i %in% c(2, 3, 4)) {
      p[[i]] = p[[i]] + theme(legend.position = "none")
    }
  }
  
  # Extract the legend from the first plot
  legend <- suppressWarnings(cowplot::get_legend(p[[1]]))
  
  # Remove the legend from the first plot
  p[[1]] <- p[[1]] + theme(legend.position = "none")
  
  # Arrange the four plots in a 2x2 grid
  plot_grid_combined <- gridExtra::arrangeGrob(
    p[[1]],  # Top-left plot (has x and y axis, no legend)
    p[[2]],  # Top-right plot (no x, no y, no legend)
    p[[3]],  # Bottom-left plot (has y, no x, no legend)
    p[[4]],  # Bottom-right plot (no y, has x, no legend)
    nrow = 2,
    ncol = 2
  )
  
  # Combine the legend on top of the plot grid
  cowplot::plot_grid(legend, plot_grid_combined, ncol = 1, rel_heights = c(0.2, 1))
  
}
