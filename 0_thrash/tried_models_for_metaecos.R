# model = lmer(bioarea_mm2_per_ml  ~
#                size * conn * dis_per +
#                (1 | system_nr) +
#                (1 | time_point),
#              data = data_for_analysis)

# TAKE OFF SYSTEM NR RANDOM EFFECT
# model = lmer(bioarea_mm2_per_ml  ~ 
#                size * conn * dis_per + 
#                (1 | time_point),
#              data = data_for_analysis)

# USE TIME POINT INSTEAD OF RANDOM EFFECT AS MODELLING HETEROSCEDASTICITY
# model <- gls(bioarea_mm2_per_ml ~ size * conn * dis_per,
#              weights = varIdent(form = ~ 1 | time_point), 
#              data = data_for_analysis,
#              control = glsControl(opt = "optim", maxIter = 1000))

# ADD TEMPORAL CORRELATION
# model <- gls(bioarea_mm2_per_ml ~ size * conn * dis_per, 
#              weights = varIdent(form = ~ 1 | time_point),  # Allow variance heterogeneity across days
#              correlation = corAR1(form = ~ 1 | time_point),  # Model autocorrelation if needed
#              data = data_for_analysis,
#              control = glsControl(opt = "optim", maxIter = 1000))

# COMBINE FIXED EFFECTS AND HETEROSCEDASTICITY MODELLING
# model <- lme(bioarea_mm2_per_ml ~ size * conn * dis_per,
#              random = ~ 1 | system_nr,
#              weights = varIdent(form = ~ 1 | time_point),
#              correlation = corAR1(form = ~ 1 | system_nr),
#              data = data_for_analysis)

# --- PLOT MODEL RESIDUALS WITHOUT DARMA--- #

# Extract residuals and fitted values

# residuals_raw <- residuals(model, type = "response")
# fitted_values <- fitted(model)
# 
# 
# # Plot Residuals vs Fitted
# plot(fitted_values, residuals_raw, 
#      main = "Residuals vs Fitted", 
#      xlab = "Fitted values", 
#      ylab = "Residuals", 
#      pch = 20)
# abline(h = 0, col = "red", lwd = 2)  # Add horizontal line at 0
# 
# # Plot Standardised Residuals vs Fitted
# 
# plot(model) 
# 
# # QQ Plot for raw residuals
# 
# qqnorm(residuals_raw, main = "Normal Q-Q Plot of Residuals")
# qqline(residuals_raw, col = "red")  # Add reference line
# 
# # Plot Cook's Distance
# 
# hat_values <- diag(model$varBeta)
# mse <- sum(residuals_raw^2) / length(residuals_raw)
# p <- length(coef(model))  # Number of parameters in the model
# cooks_d <- (residuals_raw^2) / (p * mse) * (hat_values / (1 - hat_values)^2)
# 
# plot(cooks_d, 
#      main = "Cook's Distance", 
#      xlab = "Observation", 
#      ylab = "Cook's Distance", 
#      pch = 20)
# abline(h = 4 / length(cooks_d), col = "red", lwd = 2)  # Threshold line for influential points
# 
# # Autocorrelation of residuals
# 
# acf(residuals_raw, 
#     main = "Autocorrelation of Residuals")