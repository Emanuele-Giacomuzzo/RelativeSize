summarize_populations <- function (traj.data, 
                                   sum.data, 
                                   write = FALSE, 
                                   to.data, 
                                   merged.data.folder, 
                                   video.description.folder, 
                                   video.description.file, 
                                   total_frames) 
{
    if (!exists("fps")) 
        stop("frames per second not specified (fps)")
    if (!exists("measured_volume")) 
        stop("measured volume not specified (measured_volume)")
    pop_output <- read.table(paste(to.data, video.description.folder, 
        video.description.file, sep = ""), sep = "\t", header = TRUE)
    
    pop_count_table <- tapply(traj.data$Major, 
                              list(as.factor(traj.data$file), 
                                   as.factor(traj.data$frame)), 
                              length)
    
    help_cnt_rep <- which(is.element(pop_output$file, dimnames(as.matrix(rowMeans(pop_count_table)))[[1]]))
    pop_output$indiv_per_frame <- 0
    pop_output$indiv_per_frame[help_cnt_rep] <- as.numeric(apply(pop_count_table, 
        1, sum, na.rm = T))/total_frames
    pop_output$indiv_per_volume <- 0
    
    pop_output$indiv_per_volume[help_cnt_rep] <- as.numeric(apply(pop_count_table, 
        1, sum, na.rm = T))/total_frames/measured_volume
    
    pop_count_table2 <- tapply(traj.data$Area, list(as.factor(traj.data$file), 
        as.factor(traj.data$frame)), sum)
    help_cnt_rep <- which(is.element(pop_output$file, dimnames(as.matrix(rowMeans(pop_count_table2)))[[1]]))
    pop_output$bioarea_per_frame <- 0
    pop_output$bioarea_per_frame[help_cnt_rep] <- as.numeric(apply(pop_count_table2, 
        1, sum, na.rm = T))/total_frames
    pop_output$bioarea_per_volume <- 0
    
    pop_output$bioarea_per_volume[help_cnt_rep] <- as.numeric(apply(pop_count_table2, 
        1, sum, na.rm = T))/total_frames/measured_volume
    
    sum.data$file <- sub("-.*$", "", sum.data$id)
    pop_output$major_mean <- NA
    pop_output$major_sd <- NA
    pop_output$minor_mean <- NA
    pop_output$minor_sd <- NA
    pop_output$major_mean[help_cnt_rep] <- as.numeric(tapply(sum.data$mean_major, 
        sum.data$file, mean, na.rm = T))
    pop_output$major_sd[help_cnt_rep] <- as.numeric(tapply(sum.data$mean_major, 
        sum.data$file, sd, na.rm = T))
    pop_output$minor_mean[help_cnt_rep] <- as.numeric(tapply(sum.data$mean_minor, 
        sum.data$file, mean, na.rm = T))
    pop_output$minor_sd[help_cnt_rep] <- as.numeric(tapply(sum.data$mean_minor, 
        sum.data$file, sd, na.rm = T))
    sum.data$gross_speed <- sum.data$gross_disp/sum.data$duration
    pop_output$gross_speed_mean <- NA
    pop_output$gross_speed_sd <- NA
    pop_output$net_speed_mean <- NA
    pop_output$net_speed_sd <- NA
    pop_output$sd_turning_mean <- NA
    sum.data$gross_speed <- sum.data$gross_disp/sum.data$duration
    pop_output$gross_speed_mean[help_cnt_rep] <- as.numeric(tapply(sum.data$gross_speed, 
        sum.data$file, mean, na.rm = T))
    pop_output$gross_speed_sd[help_cnt_rep] <- as.numeric(tapply(sum.data$gross_speed, 
        sum.data$file, sd, na.rm = T))
    pop_output$net_speed_mean[help_cnt_rep] <- as.numeric(tapply(sum.data$net_speed, 
        sum.data$file, mean, na.rm = T))
    pop_output$net_speed_sd[help_cnt_rep] <- as.numeric(tapply(sum.data$net_speed, 
        sum.data$file, sd, na.rm = T))
    pop_output$sd_turning_mean[help_cnt_rep] <- as.numeric(tapply(sum.data$sd_turning, 
        sum.data$file, mean, na.rm = T))
    if (write == TRUE) {
        save(pop_output, file = paste0(to.data, merged.data.folder, 
            "Population_Data.RData"))
    }
    return(as.data.frame(pop_output))
}
