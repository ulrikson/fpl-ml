library(leaps)

fpl = read.csv("fpl.csv")

full.model = lm(total_points ~ 
           ict_index + 
           selected + 
           transfers_in + 
           transfers_out + 
           value + 
           was_home +
           difficult +
           form, 
         data=fpl
         )

#* as the goal is to create a model that's easy to use w/o software
#* we limit the number of coefficients to 3
step.model <- regsubsets(total_points ~ 
                       ict_index + 
                       selected + 
                       transfers_in + 
                       transfers_out + 
                       value + 
                       was_home +
                       difficult +bo
                       form,
                     data = fpl, 
                     nvmax = 3,
                     method = "backward")
summary(step.model)
#* 1: only ict
#* 2: ict + form
#* 3: ict + value + form

only_ict = lm(total_points ~ ict_index, data=fpl)
ict_form = lm(total_points ~ ict_index + form, data=fpl)
ict_form_value = lm(total_points ~ ict_index + form + value, data=fpl)

anova(ict_form, only_ict) # form+ict better than ict
anova(ict_form_value, ict_form) # form+value+ict better than form+ict

summary(only_ict)
summary(ict_form)
summary(ict_form_value)

# Summarize: look at ICT and Form, they're the most important


# Splitting ICT into it I, C and T ------------------------------------------------------------

i_c_t_form = lm(total_points ~ influence + creativity + threat + form, data=fpl)
i_t_form = lm(total_points ~ influence + threat + form, data=fpl)
anova(i_c_t_form, i_t_form)
# Model not better with creativity

summary(i_t_form)
# Summarize: Look at influence, threat and form
