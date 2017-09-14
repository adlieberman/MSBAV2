wizards_data <- read.table("15wizardsdata.txt", sep ="\t", header = TRUE)
averages_wizards_data <- c(mean(wizards_data$Height),mean(wizards_data$Weight), mean(wizards_data$Pushups), mean(wizards_data$Situps), mean(wizards_data$Juggles_5min), mean(wizards_data$Shuttle), mean(wizards_data$X40_yard_dash), mean(wizards_data$timed_mile))
round(averages_wizards_data, 2)

wz_data_scale <- wizards_data

wz_data_scale$Shuttle <- (wizards_data$Shuttle - mean(wizards_data$Shuttle))/sd(wizards_data$Shuttle)*-1
wz_data_scale$X40_yard_dash <- (wizards_data$X40_yard_dash - mean(wizards_data$X40_yard_dash))/sd(wizards_data$X40_yard_dash)*-1
wz_data_scale$timed_mile <- (wizards_data$timed_mile - mean(wizards_data$timed_mile))/sd(wizards_data$timed_mile)*-1
wz_data_scale$Pushups <- scale(wizards_data$Pushups)
wz_data_scale$Situps <- scale(wizards_data$Situps)
wz_data_scale$Juggles_5min <- scale(wizards_data$Juggles_5min)

wz_data_scale <- transform(wz_data_scale, mean_scale = (Pushups+Situps+Juggles_5min+timed_mile+Shuttle+X40_yard_dash)/6)

wz_data_scale$Rank <- rank(-wz_data_scale$mean_scale)

final_rank <- cbind(wz_data_scale$mean_scale, wz_data_scale$Rank)
colnames(final_rank) <- c('Average Score', 'Rank')

final <- cbind(wizards_data, final_rank)
final
final_order <- final[order(final$Rank),]
final_order <- final_order[, 6:13]