print_dominance = function(ecosystem_type_i){
  
  p = ds_dominances_with_CI %>%
    filter(ecosystem_type == ecosystem_type_i) %>%
    ggplot(aes(x = day,
               y = mean_dominance,
               group = interaction(day, species),
               color = species)) +
    scale_x_continuous(breaks = unique(ds_ecosystems$day)) +
    geom_point(position = position_dodge(dodging),
               size = treatment_points_size) +
    geom_errorbar(aes(ymax = upper_95_CI,
                      ymin = lower_95_CI),
                  width = width_errorbar,
                  position = position_dodge(dodging)) + 
    geom_line(aes(group = species),
              position = position_dodge(dodging),
              linewidth = treatment_lines_linewidth) +
    labs(x = axis_names %>%
           filter(variable == "day") %>%
           pull(axis_name),
         y = axis_names %>%
           filter(variable == "dominance") %>%
           pull(axis_name),
         color = "") +
    coord_cartesian(ylim = c(0, 100)) +
    geom_rect(xmin = grey_background_xmin,
              xmax = grey_background_xmax,
              ymin = grey_background_ymin,
              ymax = grey_background_ymax,
              fill = grey_background_fill,
              alpha = grey_background_alpha,
              color = grey_background_color) +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.position = legend_position,
          legend.key.width = unit(legend_width_cm, "cm")) +
    geom_vline(xintercept = resource_flow_days,
               linetype = resource_flow_line_type,
               color = resource_flow_line_colour,
               linewidth = resource_flow_line_width)
  
  return(p)
  
}