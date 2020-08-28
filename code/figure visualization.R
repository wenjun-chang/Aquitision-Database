hist_2D_variables = function(data, data_style='row', xlab='digits', ylab='frequency', title='Multi-variable 2D Histogram'){
  if (data_style == 'row'){
    #transpose it to column style, what ggplot wants
    data = data.frame(t(data))
  }
  #intialize a df for plotting, columns = x, y, category
  plotting_data = data.frame(matrix(nrow = 0, ncol = 3))
  colnames(plotting_data) = c('x', 'y', 'category')

  #fill up df
  for (name in colnames(data)){
    single_category_data = data.frame(x=rownames(data), y=data[[name]], category=rep(name, nrow(data)))
    plotting_data = rbind(plotting_data, single_category_data)
  }

  #stacked 2d barplot with multiple groups
  #use position=position_dodge()
  library(ggplot2)
  hist2d_multiple = ggplot(data=plotting_data, aes(x=x, y=y, fill=category)) +
    geom_bar(stat="identity", position=position_dodge()) + scale_x_discrete(limits=rownames(data)) +
    scale_fill_grey(start=0.6, end=0.1) + scale_y_continuous(breaks=number_ticks(10)) +
    xlab(xlab) + ylab(ylab) + ggtitle(title) #ensure order of digit places
  #+ theme(legend.position="bottom") #legend position
  return(hist2d_multiple)
}
plot_table_by_columns = function(digits_table, name='', data_style='col', save=FALSE){
  plot_list = list()
  for (i in 1:length(digits_table)){
    curr_digit_place = colnames(digits_table)[i]
    hist_digit_place_i = hist_2D(digits_table[i], data_style=data_style, xlab='digits', ylab='frequency', title=paste(name, curr_digit_place), hline=NA)
    plot_list[[curr_digit_place]] = hist_digit_place_i
  }
  plots = plot_multiple_hist2d(plot_list)
  # if (save){
  #   filename = paste(name, '_2D_histograms.pdf', sep='')
  #   print(filename)
  #   ggsave(plots, file=paste(name, '_2D_histograms.pdf', sep=''))
  # }
  return(plots)
}

data = data.frame(AJG_2012 = c(0.509, 0.30, 1, 1, 0.929, 0.65),
                  MD_2012 = c(0.1875,  -1, NA, 1, 0, NA),
                  GOOG_2014 = c(-0.842, -0.842, 0.333, 0.269, 0.105, 0.667),
                  ENSG_2009 = c(0, -1, -1, -1, 0, NA),
                  IBM_2010 = c(0.176, 0.176, 0, 0.717, 1, 0.823))
rownames(data) = c('Acquisition Counts', 'Acquired Firm Names', 'Number of Individual Acquisition Cost', 'Total acquisition cost',
                   'Named Acquisitions in SDC found in 10K', 'Named Acquisitions in the 10-K found in SDC')
data

hist_2D_variables(data, data_style='col', xlab='indicator', ylab='percentage', title='10K compared to SDC: positive == 10K better')
hist_2D_variables(data, data_style='row', xlab='firm', ylab='percentage', title='10K compared to SDC: positive == 10K better')


t_data = data.frame(t(data))
plot_table_by_columns(t_data, name='', data_style='col', save=FALSE)

