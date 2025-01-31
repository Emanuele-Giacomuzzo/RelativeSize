plot.ecos.sizes.one.by.one.means = function(data,
                                            trophy_selected,
                                            disturbance_percentage_selected,
                                            response_variable_selected,
                                            legend_row_n_input = 2) {
  
  
  # Set parameters
  
  if(trophy_selected == "autotrophic"){
    treatment_colours = treatment_colours_autotrophic} 
  
  if(trophy_selected == "heterotrophic"){
    treatment_colours = treatment_colours_heterotrophic}
  
  p = NULL
  
  # Plot ecosystems size by size 
  
  for (ecosystem_size_i in 1:length(ecosystem_sizes_ml)) {
    
    # Prepare data
    
    data_for_plotting = data %>%
      filter(ecosystem_size_ml == ecosystem_sizes_ml[ecosystem_size_i],
             trophic_type == trophy_selected,
             disturbance_percentage == disturbance_percentage_selected) %>%
      mutate(ecosystem_size_ml = factor(paste(sprintf("%.2f", ecosystem_size_ml), "ml"),
                                        levels = c("45.00 ml", "15.00 ml", "9.00 ml", "6.43 ml"))) %>%
      summarySE(measurevar = response_variable_selected,
                groupvars = c("day", "ecosystem_size_ml", "connection"))
    
    # Plot data
    
    p[[ecosystem_size_i]] = data_for_plotting %>%
      ggplot(aes(x = day,
                 y = get(response_variable_selected),
                 group = interaction(day, ecosystem_size_ml, connection),
                 color = ecosystem_size_ml,
                 linetype = connection)) +
      geom_point(stat = "summary",
                 fun = "mean",
                 position = position_dodge(dodging),
                 size = treatment_points_size) +
      geom_line(stat = "summary",
                fun = "mean",
                aes(group = interaction(ecosystem_size_ml, connection)),
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
      scale_color_manual(values = treatment_colours) +
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
            legend.position = legend_position,
            legend.key.width = unit(legend_width_cm, "cm"),
            axis.text.x = element_text(size = paper_labels_size),
            axis.text = element_text(size = paper_labels_size),
            legend.text = element_text(size = paper_labels_size)) +
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
  
  # Bind the four plots together
  
  gridExtra::grid.arrange(p[[1]], 
                          p[[2]], 
                          p[[3]], 
                          p[[4]], 
                          nrow = 2, 
                          ncol = 2)
  
}
