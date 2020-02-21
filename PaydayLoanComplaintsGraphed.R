library(tidyverse)
library(ggplot2)
library(readxl)
PaydaayLoanComplaints <- read_excel("data/firm-level-complaints-data-2019-h1.xlsx",
                                    sheet = "(1.8) Consumer Credit", skip = 3)

LoanComplaintsSorted <- PaydaayLoanComplaints %>% arrange(`Percentage Upheld`)

LoanComplaintsSortedSelected <- LoanComplaintsSorted %>%
  select(c(`Firm Name...1`,`Percentage Upheld`))

colnames(LoanComplaintsSortedSelected) <- c("FirmName", "PercentUpheld")
  
ggplot(LoanComplaintsSortedSelected, aes(x=reorder(FirmName,PercentUpheld), y=PercentUpheld)) +
         geom_bar(stat="identity")

WorstOffenders <- LoanComplaintsSortedSelected %>%
  slice(c(5:26))

ggplot(WorstOffenders, aes(x=reorder(FirmName,PercentUpheld), y=PercentUpheld)) +
  geom_bar(stat="identity", fill="Orange") +
  labs(title = "Loan Company Complaints Not Upheld", subtitle = "An upheld complaint is one the loan company agrees fault on; these are the worst 25")+
  xlab("Lending Firm")+
  ylab("Upheld Claim Percent")
  theme_minimal()
