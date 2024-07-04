library(ggplot2)
library(dplyr)
library(grid)
library(gridExtra)

plot.metaecos.legend = function(data,
                                response_variable,
                                legend_rows = 4) {
  
  # Create the base plot to generate the legend
  plot <- data %>%
    
    # Manipulate
    
    filter(!is.na(!!sym(response_variable))) %>%
    summarySE(measurevar = response_variable,
              groupvars = c("day", "size", "connection")) %>%
    
    # Create plot
    
    ggplot(aes(x = day,
               y = get(response_variable),
               group = interaction(day, size, connection),
               color = size,
               linetype = connection)) +
    
    # Points
    
    geom_point(stat = "summary",
               fun = "mean",
               position = position_dodge(dodging)) +
    geom_errorbar(aes(ymax = get(response_variable) + ci,
                      ymin = get(response_variable) - ci),
                  width = width_errorbar,
                  position = position_dodge(dodging)) +
    scale_color_manual(values = treatment_colours) +
    
    # Lines
    
    geom_line(stat = "summary",
              fun = "mean",
              aes(group = interaction(size, connection)),
              position = position_dodge(dodging),
              linewidth = treatment_lines_linewidth) +
    scale_linetype_manual(values = treatment_linetypes) +
    
    # Axes and labels
    
    labs(x = axis_names$axis_name[axis_names$variable == "day"],
         y = axis_names$axis_name[axis_names$variable == response_variable],
         color = "") +
    guides(color = guide_legend(title = NULL,
                                nrow = legend_rows),
           linetype = guide_legend(title = NULL,
                                   nrow = legend_rows)) +
    
    # Other graphic elements
    
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.position = legend_position,
          legend.key.width = unit(legend_width_cm, "cm"),
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
  
  # Extract and display only the legend
  g <- ggplotGrob(plot)
  legend <- g$grobs[[which(sapply(g$grobs, function(x) x$name) == "guide-box")]]
  grid.newpage()
  grid.draw(legend)
  
  legend_plot <- ggplot() + 
    annotation_custom(legend) + 
    theme_void()
  
  return(legend_plot)
}

# Example usage (you need to provide the actual data and required variables):
# plot.metaecos.legend(your_data, "your_response_variable", legend_rows = 4)
