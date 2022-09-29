library(readr)
hw_messy_data <- read_csv("~/Downloads/hw-messy-data.csv")
View(hw_messy_data)

summary(hw_messy_data)
hw_messy_data[!complete.cases(hw_messy_data),]

summary(na.omit(hw_messy_data))

# - to omit particular elements - here omitting the rows with missing prices
removed_missing_prices <- hw_messy_data[-which(is.na(hw_messy_data$price)),]
summary(removed_missing_prices)

table(hw_messy_data$item)
# overwrite the item field witht the lowercase equivalent of the values in the field
hw_messy_data$item <- tolower(hw_messy_data$item)
hw_messy_data$item <- sub("nachoes","nachos", hw_messy_data$item)
# overwrite the item field with french fries if the field = fries, otherwise keep the same
hw_messy_data$item <- ifelse(hw_messy_data$item == "fries", "french fries", hw_messy_data$item)

# R has regular expressions for pattern matching!
# regexpr returns position of the found pattern
regex( "*mac*", hw_messy_data$item)
# grepl return true/false whether or not pattern was found
hw_messy_data$item <- ifelse(grepl("*mac*", hw_messy_data$item),"mac-n-cheese", hw_messy_data$item)

# date came in as a text field, convert it to a date
hw_messy_data$item <- as.Date(hw_messy_data$date, format="%m/%d/%y")
summary(hw_messy_data)

aggregate(hw_messy_data$price, list(hw_messy_data$item,hw_messy_data$date),
                                    mean, na.rm=TRUE)

#strsplit takes a string and a string to split on
split_addtnl_field <- strsplit(hw_messy_data$addtnl,"-")
?strsplit

# create a nwe column in our dataframe named weather
hw_messy_data$weather <- ""

for (x in 1:12142) hw_messy_data$weather[x,7] <- split_addtnl_field[[x]][1]