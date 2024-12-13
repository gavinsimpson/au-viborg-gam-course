# Analyse the Rat hormone data from Fahrmeir et al (2013) Regression: Models,
#  Methods and Applications. Springer
pkgs <- c("mgcv", "lme4", "ggplot2", "readr", "dplyr", "forcats", "tidyr",
          "gratia")

# load packages
vapply(pkgs, library, logical(1), character.only = TRUE, logical.return = TRUE,
       quietly = TRUE)

# load data
rats_url <- "https://bit.ly/rat-hormone"
rats <- read_table(rats_url, col_types = "dddddddddddd-")
# ignore the warning - it"s due to trailing white space at the ends of each
#   row in the file

rats <- rats %>%
    mutate(treatment = fct_recode(factor(group, levels = c(1, 2, 3)),
                                  Low = "1",
                                  High = "2",
                                  Control = "3"),
           treatment = fct_relevel(treatment, c("Control", "Low", "High")),
           subject = factor(subject))

rats %>%
    na.omit() %>%
    count(subject) %>%
    count(n, name = "n_rats")

plt_labs <- labs(y = "Head height (distance in pixels)",
                 x = "Age in days",
                 colour = "Treatment")

ggplot(rats, aes(x = time, y = response,
    group = subject, colour = treatment)) +
    geom_point(size = 1) +
    geom_line() +
    facet_wrap(~ treatment, ncol = 3) +
    plt_labs

ggplot(rats, aes(x = transf_time, y = response,
                 group = subject, colour = treatment)) +
  geom_point(size = 1) +
  geom_line() +
  facet_wrap(~ treatment, ncol = 3) +
  plt_labs

m1_lmer <- lmer(response ~ treatment:transf_time +
                    (1 | subject) + (0 + transf_time | subject),
                data = rats)

m0_lmer <- lmer(response ~ treatment:transf_time +
                  (1 + transf_time | subject),
                data = rats)

m1_gam <- gam(response ~ treatment:transf_time +
                  s(subject, bs = "re") +
                  s(subject, transf_time, bs = "re"),
              data = rats, method = "REML")

fixef(m1_lmer)

coef(m1_gam)[1:4]

summary(m1_lmer)$varcor

variance_comp(m1_gam)

summary(m1_lmer)

summary(m1_gam)

edf(m1_gam)

new_data <- tidyr::expand(rats, nesting(subject, treatment),
                          transf_time = unique(transf_time))

m1_pred <- fitted_values(m1_gam, data = new_data, scale = "response")

ggplot(m1_pred, aes(x = transf_time, y = .fitted, group = subject,
                    colour = treatment)) +
    geom_line() +
    facet_wrap(~ treatment) +
    plt_labs

# plotting the population level effects
# identify the smooths associated with random effects
sms <- smooths(m1_gam)
sms
# here both smooths are random effect smooths

# We want to exclude any random effects when we predict or estimate from the
# model to get the population level effects
conditional_values(m1_gam, condition = c("transf_time", "treatment"),
                   exclude = sms[1:2]) |>
  draw()

# we can achieve the same using the marginaleffects package
library("marginaleffects")
avg_slopes(m1_gam, variable = "transf_time", by = "treatment",
           exclude = sms[1:2])

# Instead we see the estimated slope per group
plot_slopes(m1_gam, variable = "transf_time", by = "treatment",
            exclude = sms[1:2])

# if we want to compute differences of slopes we can use the hypothesis argument
# in this example we are asking for comparisons with the reference level, the controls
avg_slopes(m1_gam, variable = "transf_time", by = "treatment",
           exclude = sms[1:2],
           hypothesis = difference ~ reference | group)

# In this variant we ask for pairwise comparisons of the treatment levels
avg_slopes(m1_gam, variable = "transf_time", by = "treatment",
           exclude = sms[1:2],
           hypothesis = "pairwise")

m2_lmer <- lmer(response ~ treatment:transf_time +
                    (1 | subject),
                data = rats)
m2_gam <- gam(response ~ treatment:transf_time +
                  s(subject, bs = "re"),
              data = rats, method = "REML")

summary(m2_lmer)$varcor

variance_comp(m2_gam)

AIC(m2_gam, m1_gam)

draw(m2_gam, parametric = FALSE)
