plot.patches.points.raw = function(data,
                                   patch_type_input,
                                   response_variable,
                                   legend_row_n_input = 2) {
  
  patch_type_input <- patch_type_input[order(match(patch_type_input,
                                                   patch_types_ordered))]
  
  data %>%
    filter(patch_type %in% patch_type_input,!is.na(!!sym(response_variable))) %>%
    summarySE(measurevar = response_variable,
              groupvars = c("day", "patch_type")) %>%
    ggplot(aes(
      x = day,
      y = get(response_variable),
      group = interaction(day, patch_type),
      color = patch_type
    )) +
    geom_point(
      stat = "summary",
      fun = "mean",
      position = position_dodge(dodging),
      size = treatment_points_size
    ) +
    geom_line(
      stat = "summary",
      fun = "mean",
      aes(group = patch_type),
      position = position_dodge(dodging),
      linewidth = treatment_lines_linewidth
    )
}
