#Plot for each time point the relationship between patch size and the response variable

plot.metaecos.boxplots.time.points = function(flow_input,
                                              response_variable) {
  if (trophic_type_input == "autotrophic") {
    colour_lowest = colour_lowest_autotrophic
    colour_highest = colour_highest_autotrophic
  }
  
  if (trophic_type_input == "heterotrophic") {
    colour_lowest = colour_lowest_heterotrophic
    colour_highest = colour_highest_heterotrophic
  }
  
  for (time_point_input in first_time_point:last_time_point) {
    print(paste("Time point number", time_point_input))
    
    print(
      ds_metaecosystems %>%
        filter(flow == flow_input,
               time_point == time_point_input) %>%
        ggplot(
          aes(
            x = patch_size_ml,
            y = get(response_variable),
            group = patch_size_ml,
            fill = patch_size_ml
          )
        ) +
        geom_boxplot() +
        labs(x = axis_names$axis_name[axis_names$variable == "patch_size_ml"],
             y = axis_names$axis_name[axis_names$variable == response_variable]) +
        theme_bw() +
        theme(
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.position = "none"
        ) +
        geom_hline(
          yintercept = 0,
          color = zero_line_colour,
          linetype = zero_line_line_type,
          linewidth = zero_line_line_width
        ) +
        scale_fill_gradient(low = colour_lowest,
                            high = colour_highest)
    )
    
  }
}
