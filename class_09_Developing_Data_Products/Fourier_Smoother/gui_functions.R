
#Function for smoother by high frequency on down
fourier_smoother_high_freq = function(Threshold) {
  # fourier_sim_data()
  # Threshold=0.5
  # print(Threshold)
  Threshold=Threshold/100
  X.hold = fft(sim_data)
  # plot(sim_data)
  # plot(Mod(X.hold[0:((length(X.hold)-1)/2)]))
  
  
  n=length(X.hold)/2
  thresh_ind_start=round(n*(1-Threshold))
  thresh_ind_end= 2*n-thresh_ind_start
  ind_len=thresh_ind_end-thresh_ind_start
  # print(ind_len)  
  if (ind_len>1) X.hold[thresh_ind_start:thresh_ind_end]=0
  # plot(Mod(X.hold[0:((length(X.hold)-1)/2)]))
  X.unf=fft(X.hold,inverse=TRUE)/length(sim_data)
  X.unf=as.double(X.unf)
  # plot(X.unf)
  plot.df=data.frame(x=1:length(sim_data),sim_data=sim_data,clean=X.unf)
  g=ggplot()+theme_bw()+
    geom_line(data=plot.df,aes(x=x,y=sim_data))+
    geom_line(data=plot.df,aes(x=x,y=clean),color="blue",size=1.5)+
    ylab("Simulated Data")+xlab("Time")+ggtitle("High Frequency Filtering")
  g
}



#Function for smoother by low amplitude on up

fourier_smoother_low_amp = function(Threshold){
  # Threshold=20
  # print(Threshold)
  Threshold=Threshold/100
  X.hold = fft(sim_data)
  # plot(sim_data)
  # plot(Mod(X.hold[0:((length(X.hold)-1)/2)]))
  
  
  cutoff=quantile(Mod(X.hold),Threshold)
  cutoff_ind=which(Mod(X.hold)<cutoff)
  
  if (length(cutoff_ind)>1) X.hold[cutoff_ind]=0
  # plot(Mod(X.hold[0:((length(X.hold)-1)/2)]))
  X.unf=fft(X.hold,inverse=TRUE)/length(sim_data)
  X.unf=as.double(X.unf)
  # plot(X.unf)
  plot.df=data.frame(x=1:length(sim_data),sim_data=sim_data,clean=X.unf)
  g=ggplot()+theme_bw()+
    geom_line(data=plot.df,aes(x=x,y=sim_data))+
    geom_line(data=plot.df,aes(x=x,y=clean),color="blue",size=1)+
    ylab("Simulated Data")+xlab("Time")+ggtitle("Low Ampliturde Filtering")
  g
  
  
  
}
# 
# 
# fourier_sim_data = function(){
#   
#   
#   return(sim_data)
# }
