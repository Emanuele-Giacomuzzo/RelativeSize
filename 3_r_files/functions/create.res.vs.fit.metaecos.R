create.res.vs.fit.metaecos = function(model,
                                      data) {
  
  res_vs_fit = data %>%
    mutate(predicted = fitted(model),
           residuals = resid(model)) %>%
    plot_ly(x = ~ predicted,
            y = ~ residuals,
            type = "scatter",
            mode = "markers",
            marker = list(size = 5, color = "#4C78A8"),
            text = paste(
              " ID: ",
              data$system_nr,
              "<br>",
              "Day: ",
              data$day,
              "<br>",
              "Meta-ecosystem Type: ",
              data$metaecosystem_type,
              "<br>",
              "Biomass density: ",
              round(data$total_metaecosystem_bioarea_mm2, digits = 2),
              "<br>"),
            hoverinfo = "text") %>%
    plotly::layout(title = "Residuals vs. Fitted Values",
                   xaxis = list(title = "Fitted Values"),
                   yaxis = list(title = "Residuals"))
  
  return(res_vs_fit)
  
}
