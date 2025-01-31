plot.ecos.sizes.one.by.one.means = function(data = ds_ecosystems,
                                            trophy_selected = "heterotrophic",
                                            response_variable_selected = "simpson",
                                            light_colour = light_colour_hetero,
                                            dark_colour = dark_colour_hetero,
                                            y_upper_limit = 2.4,
                                            legend_row_n_selected = 1) {
  
  # Set parameters & initialise list to store plots
  
  ecos_colours = c("fixed" = dark_colour,
                   "relative" = light_colour)
  
  p = list()
  plot_n = 0
  
  # Plot ecosystems size by size
  
  for (eco_size_i in 1:length(ecosystem_sizes_ml)) {
    for(volume_disturbed_i in 1:length(volume_disturbed_across_sizes_levels)){
      
      # Define parameter
      
      plot_n = plot_n + 1
      
      # Prepare data
      
      data_for_plotting = data %>%
        filter(ecosystem_size_ml == ecosystem_sizes_ml[eco_size_i],
               volume_disturbed_across_sizes == 
                 volume_disturbed_across_sizes_levels[volume_disturbed_i],
               trophic_type == trophy_selected) %>%
        mutate(ecosystem_size_ml = factor(paste(sprintf("%.2f", 
                                                        ecosystem_size_ml), 
                                                "ml"),
                                          levels = c("45.00 ml",
                                                     "15.00 ml",
                                                     "9.00 ml",
                                                     "6.43 ml"))) %>% 
        summarySE(measurevar = response_variable_selected,
                  groupvars = c("day",
                                "ecosystem_size_ml",
                                "connection",
                                "volume_disturbed_across_sizes")) %>% 
        filter(complete.cases(.))
      
      # Plot data
      
      p[[plot_n]] = data_for_plotting %>%
        ggplot(aes(x = day,
                   y = get(response_variable_selected),
                   group = interaction(day, 
                                       connection, 
                                       volume_disturbed_across_sizes),
                   color = volume_disturbed_across_sizes,
                   linetype = connection)) +
        geom_point(stat = "summary",
                   fun = "mean",
                   position = position_dodge(dodging),
                   size = treatment_points_size_small) +
        geom_line(stat = "summary",
                  fun = "mean",
                  aes(group = interaction(ecosystem_size_ml, 
                                          connection, 
                                          volume_disturbed_across_sizes)),
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
        scale_color_manual(values = ecos_colours) +
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
        annotate("text",
                 x = -Inf,
                 y = Inf,
                 label = paste(ecosystem_sizes_ml[eco_size_i], "ml"),
                 hjust = -0.5,
                 vjust = 1.5,
                 size = 5)
      
      # Modify the plot
      
      p[[plot_n]] = p[[plot_n]] + coord_cartesian(ylim = c(0, 
                                                           y_upper_limit))
      
      if (plot_n %in% c(1:6)) {
        p[[plot_n]] = p[[plot_n]] + theme(axis.title.x = element_blank(),
                                          axis.text.x = element_blank(),
                                          axis.ticks.x = element_blank())}
      
      if (plot_n %in% c(2, 4, 6, 8)) {
        p[[plot_n]] = p[[plot_n]] + theme(axis.title.y = element_blank(),
                                          axis.text.y = element_blank(),
                                          axis.ticks.y = element_blank())}
      
      if (plot_n %in% c(1:8)) {
        p[[plot_n]] = p[[plot_n]] + theme(legend.position = "none")}
    }
  }
  
  # Create a shared legend
  
  # Extract legends individually
  color_legend <- suppressWarnings(cowplot::get_legend(
    data %>%
      ggplot(aes(x = day,
                 y = get(response_variable_selected),
                 group = interaction(day, 
                                     connection, 
                                     volume_disturbed_across_sizes),
                 color = volume_disturbed_across_sizes)) +
      geom_line(aes(group = interaction(ecosystem_size_ml, 
                                        connection, 
                                        volume_disturbed_across_sizes)),
                linewidth = treatment_lines_linewidth) +
      labs(color = "") +
      scale_color_manual(values = c(dark_colour, light_colour)) +
      theme(legend.key = element_blank(),
            legend.key.width = unit(legend_width_cm, "cm"),
            legend.text = element_text(size = paper_labels_size)) +
      guides(color = guide_legend(title = NULL, nrow = 1)))
  )
  
  linetype_legend <- suppressWarnings(cowplot::get_legend(
    data %>%
      ggplot(aes(x = day,
                 y = get(response_variable_selected),
                 group = interaction(day, 
                                     connection, 
                                     volume_disturbed_across_sizes),
                 linetype = connection)) +
      geom_line(aes(group = interaction(ecosystem_size_ml, 
                                        connection, 
                                        volume_disturbed_across_sizes)),
                linewidth = treatment_lines_linewidth) +
      scale_linetype_manual(values = treatment_linetypes) +
      theme(legend.key = element_blank(),
            legend.key.width = unit(legend_width_cm, "cm"),
            legend.text = element_text(size = paper_labels_size)) +
      guides(linetype = guide_legend(title = NULL, nrow = 1))
  ))
  
  # Combine legends horizontally
  combined_legend <- cowplot::plot_grid(color_legend, linetype_legend, nrow = 1, align = "h", axis = "t")
  
  # Arrange the plots in a grid
  plot_grid_combined <- gridExtra::arrangeGrob(
    p[[1]],   
    p[[2]],   
    p[[3]],   
    p[[4]],   
    p[[5]],   
    p[[6]],   
    p[[7]],   
    p[[8]],   
    nrow = 4,
    ncol = 2,
    heights = c(1, 1, 1, 1.15)  # Adjust row proportions if necessary
  )
  
  # Combine legend and plots
  final_combined_plot <- cowplot::plot_grid(
    combined_legend, 
    plot_grid_combined, 
    ncol = 1, 
    rel_heights = c(0.2, 1)  # Adjust legend and plot proportions
  )
  
  # Render the plot
  grid::grid.newpage()
  grid::grid.draw(final_combined_plot)
  
}
