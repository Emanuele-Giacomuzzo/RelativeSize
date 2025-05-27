tidy.up.contrasts <- function(contrasts_ds, 
                              is_nested = FALSE) {
  
  # Turn contrasts into a data frame
  contrasts_ds = as.data.frame(contrasts_ds)
  
  # Create a new data frame for back-transformed results
  back_transformed <- contrasts_ds
  
  # Calculate multiplicative effect (exp(estimate))
  back_transformed$multiplicative_effect <- exp(contrasts_ds$estimate)
  
  # For first-level contrasts: express as ratios
  if (!is_nested) {
    # The multiplicative effect is already the ratio (level1/level2)
    back_transformed$ratio <- back_transformed$multiplicative_effect
    back_transformed$ratio_formatted <- sprintf("%.2f", back_transformed$ratio)
    
    # Calculate SE for the ratio using the delta method
    # For a function f(x) = exp(x), the derivative is f'(x) = exp(x)
    back_transformed$ratio_SE <- exp(contrasts_ds$estimate) * contrasts_ds$SE
    
  } else {
    # For nested contrasts: express as differences of ratios
    # When we take differences on log scale and back-transform, 
    # we get ratios of ratios, but we want differences of ratios
    
    # For clarity in presentation, we'll calculate (ratio1 - ratio2)
    # Note: this differs from exp(log(ratio1) - log(ratio2)) = ratio1/ratio2
    
    # The estimate is on log scale, so we need to compute
    # exp(estimate) - 1 to get the difference of ratios
    back_transformed$diff_ratio <- exp(contrasts_ds$estimate) - 1
    back_transformed$diff_ratio_formatted <- sprintf("%.3f", back_transformed$diff_ratio)
    
    # Calculate SE for the difference of ratios using the delta method
    back_transformed$diff_ratio_SE <- exp(contrasts_ds$estimate) * contrasts_ds$SE
  }
  
  # Create significance stars (similar to summary() output)
  back_transformed$significance <- ""
  back_transformed$significance[back_transformed$p.value < 0.05] <- "*"
  back_transformed$significance[back_transformed$p.value < 0.01] <- "**"
  back_transformed$significance[back_transformed$p.value < 0.001] <- "***"
  
  # Select and order columns for final output
  if (!is_nested) {
    result <- back_transformed[, c("contrast", 
                                   "ratio", 
                                   "ratio_SE",
                                   "p.value", 
                                   "significance")]
    
    # Rename columns
    result = result %>%
      rename(ratio_value = ratio,
             SE = ratio_SE,
             " " = significance)
  } else {
    result <- back_transformed[, c("contrast", 
                                   "diff_ratio", 
                                   "diff_ratio_SE",
                                   "p.value", 
                                   "significance")]
    
    # Rename columns
    result = result %>%
      rename(diff_of_ratios = diff_ratio,
             SE = diff_ratio_SE,
             " " = significance)
  }
  
  # Round numeric columns for display
  result$p.value <- round(result$p.value, 3)
  if (!is_nested) {
    result$ratio_value <- round(result$ratio_value, 3)
  } else {
    result$diff_of_ratios <- round(result$diff_of_ratios, 3)
  }
  result$SE <- round(result$SE, 3)
  
  return(result)
}
