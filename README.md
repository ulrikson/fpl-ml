# FPL ML
Finding which variables that are important for predicting the total points outcome of FPL

## Findings
ICT and form are quite good predictors (R2 = 60%), making it an easy model to use IRL. There are statistically better models, but the benefit of more variables compared to the relative small gains in R2 don't justify including them. At least not when one should be able to use the model spontaneously, w/o software.  
Breaking ICT into its parts shows that creativity isn't helpful for predicting points.

## Conclusion
ICT (0.58 x ict_index) and Form (0.24 x form) will give a relatively good estimate of the total points (intercept=-0.07). Can break down ICT into Influence and Threat (Creativity not heplful). 
