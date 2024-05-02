create.res.vs.fit.metaecos.ES = function(model,
                                         data,
                                         response_variable) {
  
  res_vs_fit = data %>%
    mutate(predicted = fitted(model),
           residuals = resid(model)) %>%
    plot_ly(x = ~ predicted,
            y = ~ residuals,
            type = "scatter",
            mode = "markers",
            marker = list(size = 5, color = "#4C78A8"),
            text = paste(
              "Day: ",
              data$day,
              "<br>",
              "Meta-ecosystem Type: ",
              data$system_type),
            hoverinfo = "text") %>%
    plotly::layout(title = "Residuals vs. Fitted Values",
                   xaxis = list(title = "Fitted Values"),
                   yaxis = list(title = "Residuals"))
  
  return(res_vs_fit)
  
}
