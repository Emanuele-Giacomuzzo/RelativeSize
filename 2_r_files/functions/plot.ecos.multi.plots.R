plot.ecos.multi.plots = function(data){
  
  for(trophy_i in 1:length(trophy_selected)) {
    
    print(trophy_selected[trophy_i])
    
    ggarrange(plot.ecosystems.points.legend(data %>% 
                                              filter(disturbance_percentage == "fixed"),
                                            trophy_selected[trophy_i],
                                            response_variable_selected,
                                            legend_row_n_input = 4),
              plot.ecosystems.points(data %>% 
                                       filter(disturbance_percentage == "fixed"),
                                     trophy_selected[trophy_i],
                                     response_variable_selected,
                                     legend_row_n_input = 4)  +
                rremove("xlab") +
                theme(axis.text.x = element_blank(),
                      axis.ticks.x = element_blank(),
                      legend.position = "none") +
                font("legend.text", size = size_legend) +
                font("ylab", size = size_y_axis) +
                ggtitle(fixed_label),
              plot.ecosystems.points(data %>% 
                                       filter(disturbance_percentage == "decreasing_with_size"),
                                     trophy_selected[trophy_i],
                                     response_variable_selected,
                                     legend_row_n_input = 4)  +
                font("xlab", size = size_y_axis) +
                font("ylab", size = size_y_axis) +
                ggtitle(relative_label) +
                scale_x_continuous(breaks = unique(ds_metaecosystems$day)) +
                theme(legend.position = "none"),
              heights = c(0.2, 0.6, 0.6),
              nrow = 3,
              align = "v") %>%
      print()
  }
}
