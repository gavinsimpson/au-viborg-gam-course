pkgs <- c("mgcv", "gratia", "readxl", "scales", "ggplot2", "forcats",
          "dplyr")
vapply(pkgs, library, logical(1), character.only = TRUE, logical.return = TRUE)

# Growth data
# data are in sheet "growth data"
fn <- "./data/quail.xlsx"
excel_sheets(fn)

q_growth <- read_xlsx(fn, sheet = "growth analysis", na = "NA") %>%
  mutate(motherID = factor(motherID),
         eggID = factor(eggID),
         group = factor(group),
         sex = factor(sex)) %>%
  # make the label prettier for graphs
  mutate(sex = fct_recode(sex,
                          "Female" = "F",
                          "Male" = "M"),
         group = fct_recode(group,
                            "T[3]" = "T3",
                            "T[4]" = "T4",
                            "T[3]~T[4]" = "T3T4"))

# plotting code from
ggplot(q_growth, aes(day, mass, color = group)) +
  geom_line(aes(group = eggID)) +
  facet_wrap(~sex) +
  labs(x = "Days since hatching",
       y = "Body mass (g)",
       color = "Treatment",
       tag = "A") +
  scale_color_discrete(labels = str2expression,
    limits = c("CO", "T[3]", "T[4]", "T[3]~T[4]")) +
  theme(legend.text.align = 0)

ggplot(q_growth, aes(day, mass, color = group)) +
  stat_summary(fun = mean, geom = "line") +
  stat_summary(fun.data = mean_se, geom = "pointrange", fatten = 2) +
  facet_wrap(~sex) +
  labs(x = "Days since hatching",
       y = "Body mass (g)",
       color = "Treatment",
       tag = "B") +
  scale_color_discrete(labels = str2expression,
    limits = c("CO", "T[3]", "T[4]", "T[3]~T[4]")) +
  theme(legend.text.align = 0)

# model growth curves
ctrl <- gam.control(nthreads = 4)

m1 <- bam(mass ~ group + sex +
  s(day, by = sex) +
  s(day, eggID, bs = "fs") +
  s(motherID, bs = "re"),
data = q_growth,
family = Gamma(link = "log"),
method = "fREML",
control = ctrl,
discrete = TRUE)

draw(m1, rug = FALSE)
appraise(m1, method = "simulate")

q_growth <- q_growth %>%
  mutate(group_o = ordered(group),
         sex_o = ordered(sex))

m2 <- bam(mass ~ group_o + sex_o +
  s(day, k = 15) +
  s(day, by = group_o) +
  s(day, by = sex_o) +
  s(day, eggID, bs = "fs", k = 6) +
  s(motherID, bs = "re"),
data = q_growth,
family = Gamma(link = "log"),
method = "fREML",
control = ctrl,
discrete = TRUE)

draw(m2, rug = FALSE)
appraise(m2, method = "simulate")

m3 <- bam(mass ~ group_o + sex_o +
  s(day, k = 15) +
  s(day, by = group_o) +
  s(day, by = sex_o) +
  s(eggID, bs = "re") +
  s(motherID, bs = "re"),
data = q_growth,
family = Gamma(link = "log"),
method = "fREML",
control = ctrl,
discrete = TRUE)

draw(m3, rug = FALSE)
appraise(m3, method = "simulate")

m4 <- bam(
  mass ~ s(day, k = 15) +
    s(day, group, bs = "sz") +
    s(day, sex, bs = "sz") +
    s(day, group, sex, bs = "sz") +
    s(eggID, bs = "re") +
    s(motherID, bs = "re"),
  data = q_growth,
  family = Gamma(link = "log"),
  method = "fREML",
  control = ctrl,
  discrete = TRUE
)

draw(m4, rug = FALSE)
appraise(m4, method = "simulate")

m5 <- bam(
  mass ~ s(day, k = 15) +
    s(day, group, bs = "sz") +
    s(day, sex, bs = "sz") +
    s(day, group, sex, bs = "sz") +
    s(day, eggID, bs = "fs", k = 6) +
    s(motherID, bs = "re"),
  data = q_growth,
  family = Gamma(link = "log"),
  method = "fREML",
  control = ctrl,
  discrete = TRUE
)

draw(m5, rug = FALSE)
appraise(m5, method = "simulate")

# what smooths do we want to exclude?
sms <- smooths(m4)
sms

conditional_values(m4, condition = c("day", "group", "sex"),
  exclude = sms[4:5]) |>
  draw()
