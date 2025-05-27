plot.ecos.contrasts = function(data = contrasts,
                               trophic_type_selected = "heterotrophic",
                               response_variable_selected = "simpson",
                               light_colour = light_colour_hetero,
                               dark_colour = dark_colour_hetero,
                               legend_row_n_selected = 1) {
  
  
  # Set parameters & initialise list to store plots
  
  ecos_colours = c("fixed" = dark_colour,
                   "relative" = light_colour)
  
  volume_disturbed_types = c("Fixed disturbance",
                             "Relative disturbance")
  
  if(trophic_type_selected == "heterotrophic"){
    ecos_colours = c("Fixed disturbance" = dark_colour_hetero,
                     "Relative disturbance" = light_colour_hetero)
    
    title_selected = "Heterotrophic patch level"
  }
  
  if(trophic_type_selected == "autotrophic"){
    ecos_colours = c("Fixed disturbance" = dark_colour_auto,
                     "Relative disturbance" = light_colour_auto)
    
    title_selected = "Autotrophic patch level"
  }
  
  # Change factor names 
  
  data = data %>%
    mutate(size = as.numeric(str_extract(contrast, "\\d+\\.?\\d*")),  # Extract the numeric part
           volume_disturbed_across_sizes = ifelse(grepl("fixed", contrast), "fixed", "relative"),
           volume_disturbed_across_sizes = case_when(
             volume_disturbed_across_sizes == "fixed" ~ "Fixed disturbance",
             volume_disturbed_across_sizes == "relative" ~ "Relative disturbance",
             TRUE ~ volume_disturbed_across_sizes))
  
  
  data %>%
    ggplot(aes(x = factor(size),
               y = percentage,
               color = volume_disturbed_across_sizes,
               group = volume_disturbed_across_sizes)) +
    geom_point(position = position_dodge(dodging),
               size = treatment_points_size_small) +
    geom_errorbar(aes(ymax = upper.CL,
                      ymin = lower.CL),
                  width = 0,
                  position = position_dodge(dodging)) +
    labs(x = "Patch size (ml)",
         y = axis_names$axis_name[axis_names$variable == paste0(response_variable_selected, "_contrast")],
         color = "",
         title = title_selected) +
    scale_color_manual(values = ecos_colours) +
    geom_hline(yintercept = 0,
               color = zero_line_colour,
               linetype = zero_line_line_type,
               linewidth = zero_line_line_width) +
    theme_bw() +
    theme(text = element_text(size = paper_labels_size),  # Set base size for all text
          axis.text = element_text(size = paper_labels_size),  # Axis numbers
          axis.title = element_text(size = paper_labels_size),  # Axis labels
          legend.text = element_text(size = paper_labels_size),  # Legend text
          legend.title = element_text(size = paper_labels_size),  # Legend titlepanel.grid.major = element_blank(),
          plot.title = element_text(size = paper_labels_size, 
                                    face = "bold",  # Make title bold
                                    hjust = 0.5),  # Center the title
          
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.key.width = unit(legend_width_cm, "cm"),
          legend.position = "top") +
    guides(color = guide_legend(title = NULL,
                                nrow = legend_row_n_selected))
  
}
