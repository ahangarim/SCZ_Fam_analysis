## Figures were generated in R.

library(ggridges)
library(ggplot2)
library(data.table)
library(data.table)
library(ggpubr)
library(plotrix)
library(dplyr)
library(gridExtra)
library(cowplot)

# Figure 1 was created using power point.

####### PLOTTING FIGURE 2 #########
####### PLOTTING FIGURE 2 #########
####### PLOTTING FIGURE 2 #########


boxLabels <- c("Narrow","Intermediate","Broad","Very Broad","Unaffected")

### PLOT BIP PRS
SCZ2 <- fread("BIP_PRS_OR.csv")
df <- data.frame(yAxis = length(boxLabels):1, 
                 boxOdds = SCZ2$OR, 
                 boxCILow = SCZ2$CI_lower, 
                 boxCIHigh = SCZ2$CI_upper
)
p <- ggplot(df, aes(x = boxOdds, y = yAxis))
p2 <- p + geom_vline(aes(xintercept = 1), size = .25, linetype = "dashed") +
  geom_errorbarh(aes(xmax = boxCIHigh, xmin = boxCILow), size = .5, height = .2, color = "gray50") +
  geom_point(size = 3.5, color = c("firebrick","firebrick","firebrick","firebrick","firebrick")) +
  theme_bw() +
  theme(panel.grid.minor = element_blank()) +
  scale_y_continuous(breaks = df$yAxis, labels = boxLabels) +
  scale_x_continuous(breaks = seq(0,10,1) ) +
  coord_trans(x = "log10") +
  ylab("") +
  xlab("Odds ratio") +
  annotate(geom = "text", y =1.1, x = 3.5, label ="", size = 3.5, hjust = 0) + theme(axis.text=element_text(size=15),axis.title=element_text(size=14,face="bold"))
BIP_OR <- p2


### PLOT MDD PRS
SCZ2 <- fread("MDD_PRS_OR.csv")
df <- data.frame(yAxis = length(boxLabels):1, 
                 boxOdds = SCZ2$OR, 
                 boxCILow = SCZ2$CI_lower, 
                 boxCIHigh = SCZ2$CI_upper
)
p <- ggplot(df, aes(x = boxOdds, y = yAxis))
p2 <- p + geom_vline(aes(xintercept = 1), size = .25, linetype = "dashed") +
  geom_errorbarh(aes(xmax = boxCIHigh, xmin = boxCILow), size = .5, height = .2, color = "gray50") +
  geom_point(size = 3.5, color = c("firebrick","firebrick","firebrick","firebrick","firebrick")) +
  theme_bw() +
  theme(panel.grid.minor = element_blank()) +
  scale_y_continuous(breaks = df$yAxis, labels = boxLabels) +
  scale_x_continuous(breaks = seq(0,10,1) ) +
  coord_trans(x = "log10") +
  ylab("") +
  xlab("Odds ratio") +
  annotate(geom = "text", y =1.1, x = 3.5, label ="", size = 3.5, hjust = 0) + theme(axis.text=element_text(size=15),axis.title=element_text(size=14,face="bold"))
MDD_OR <- p2

k<- grid.arrange(BIP_OR, MDD_OR, ncol=1)
ggsave("Fig2_ORs.svg",k)



###### PLOTTING FIGURE 3 #########
###### PLOTTING FIGURE 3 #########
###### PLOTTING FIGURE 3 #########

All <- fread("PRS_Fam.csv")
subs <- All
head(subs)

subs$diagnosis <- ifelse(grepl("d2",subs$diagnosis,ignore.case = T), "Narrow",
                         ifelse(grepl("d5",subs$diagnosis,ignore.case = T), "Intermediate",
                                ifelse(grepl("d8",subs$diagnosis,ignore.case = T), "Broad",
                                       ifelse(grepl("d9",subs$diagnosis,ignore.case = T), "Very Broad",
                                              ifelse(grepl("Control",subs$diagnosis,ignore.case = T), "Control",
                                                     ifelse(grepl("unaffected",subs$diagnosis,ignore.case = T),"Unaffected","NA"))))))

subs$diagnosis <- as.factor(subs$diagnosis)
subs$diagnosis <- ordered(subs$diagnosis, levels = c("Control","Unaffected","Very Broad","Broad","Intermediate","Narrow"))
class(subs$diagnosis)

table(subs$diagnosis)
#Control   Unaffected   Very Broad        Broad Intermediate       Narrow 
#2205          232          141           52          112          469 

#plot for SCZ_BIP
p <- ggplot(subs, aes(x = zscore_SCZ_BIP, y = diagnosis,fill=diagnosis,alpha=0.4)) +
  geom_density_ridges2(scale=3) + 
  scale_fill_cyclical(values = c("brown4","burlywood4","cadetblue4","cornflowerblue","deepskyblue3","deepskyblue"), guide = "legend") + 
  theme_classic() + theme(text = element_text(size=15,face = "bold"),legend.position="none")+ 
  labs(y="Density",x=" PRS (Z)")
control_get_mean <- subs[subs$diagnosis=="Control"] 
mean_control <- mean(control_get_mean$zscore_SCZ_BIP)
scz_bip_plot <- p+geom_vline(data=subs, aes(xintercept=mean_control),linetype="dashed")

#plot for nonSCZ_BIP
p <- ggplot(subs, aes(x = zscore_nonSCZ_BIP, y = diagnosis,fill=diagnosis,alpha=0.4)) +
  geom_density_ridges2(scale=3) + 
  scale_fill_cyclical(values = c("brown4","burlywood4","cadetblue4","cornflowerblue","deepskyblue3","deepskyblue"), guide = "legend") + 
  theme_classic() + theme(text = element_text(size=15,face = "bold"),legend.position="none")+ 
  labs(y="Density",x=" PRS (Z)")
control_get_mean <- subs[subs$diagnosis=="Control"] 
mean_control <- mean(control_get_mean$zscore_nonSCZ_BIP)
nonscz_bip_plot <- p+geom_vline(data=subs, aes(xintercept=mean_control),linetype="dashed")

#plot for SCZ_MDD
p <- ggplot(subs, aes(x = zscore_SCZ_MDD, y = diagnosis,fill=diagnosis,alpha=0.4)) +
  geom_density_ridges2(scale=3) + 
  scale_fill_cyclical(values = c("brown4","burlywood4","cadetblue4","cornflowerblue","deepskyblue3","deepskyblue"), guide = "legend") + 
  theme_classic() + theme(text = element_text(size=15,face = "bold"),legend.position="none")+ 
  labs(y="Density",x=" PRS (Z)")
control_get_mean <- subs[subs$diagnosis=="Control"] 
mean_control <- mean(control_get_mean$zscore_SCZ_MDD)
scz_mdd_plot <- p+geom_vline(data=subs, aes(xintercept=mean_control),linetype="dashed")

#plot for SCZ_MDD
p <- ggplot(subs, aes(x = zscore_nonSCZ_MDD, y = diagnosis,fill=diagnosis,alpha=0.4)) +
  geom_density_ridges2(scale=3) + 
  scale_fill_cyclical(values = c("brown4","burlywood4","cadetblue4","cornflowerblue","deepskyblue3","deepskyblue"), guide = "legend") + 
  theme_classic() + theme(text = element_text(size=15,face = "bold"),legend.position="none")+ 
  labs(y="Density",x=" PRS (Z)")
control_get_mean <- subs[subs$diagnosis=="Control"] 
mean_control <- mean(control_get_mean$zscore_nonSCZ_MDD)
nonscz_mdd_plot <- p+geom_vline(data=subs, aes(xintercept=mean_control),linetype="dashed")


#put them together in one plot with 4 panels
k<- grid.arrange(scz_bip_plot, scz_mdd_plot,nonscz_bip_plot,nonscz_mdd_plot ncol=2)
ggsave("Fig3_Density.svg",k)



####### PLOTTING FIGURE 4 ###########
####### PLOTTING FIGURE 4 ###########
####### PLOTTING FIGURE 4 ###########

boxLabels <- c("SCZ","BIP","MDD","LDL")
df <- fread("ptdt_1.csv")
df$Group <- as.factor(df$Group)
df$Group <- ordered(df$Group, levels = c("SCZ","BIP","MDD","LDL"))


p <- ggplot(data=df,
           aes(x = Group,y = boxOdds, ymin = boxCILow, ymax =boxCIHigh))+ coord_cartesian(ylim = c(-0.5,1.2)) +
  geom_pointrange(aes(col=Group))+
  geom_hline(aes(fill=yAxis),yintercept =0, linetype=3)+
  xlab('Polygenic Risk Score')+ ylab("Mean pTDT deviation")+
  geom_errorbar(aes(ymin=boxCILow, ymax=boxCIHigh,col=Group),width=0.2,cex=0.5)+ 
  theme(plot.title=element_text(size=10,face="bold"),
        axis.text.x=element_text(face="bold"),
        axis.title=element_text(size=12,face="bold")) + theme_classic() + theme(legend.position="none", axis.text = element_text(size=12),axis.title = element_text(size=15),axis.text.x = element_text(angle = 45, hjust=1)) + 
  scale_color_manual(values = c("SCZ" = "darkred", "BIP" = "darkred","MDD" ="darkred","LDL"="skyblue"))

fig4a <- p 


boxLabels = c("SCZfactor in BIP","nonSCZ factor in BIP","SCZ factor in MDD","nonSCZfactor in MDD")
df <- fread("ptdt_2.csv")
df$Group <- as.factor(df$Group)
df$Group <- ordered(df$Group, levels = c("SCZfactor in BIP","nonSCZ factor in BIP","SCZfactor in MDD","nonSCZ factor in MDD"))

p <- ggplot(data=df,
           aes(x = Group,y = boxOdds, ymin = boxCILow, ymax =boxCIHigh))+ coord_cartesian(ylim = c(-0.5,1.2)) +
  geom_pointrange(aes(col=Group))+
  geom_hline(aes(fill=yAxis),yintercept =0, linetype=3)+
  xlab('Polygenic Risk Score')+ ylab("Mean pTDT deviation")+
  geom_errorbar(aes(ymin=boxCILow, ymax=boxCIHigh,col=Group),width=0.2,cex=0.5)+ 
  theme(plot.title=element_text(size=10,face="bold"),
        axis.text.x=element_text(face="bold"),
        axis.title=element_text(size=12,face="bold")) + theme_classic() + theme(legend.position="none", axis.text = element_text(size=12),axis.title = element_text(size=15),axis.text.x = element_text(angle = 45, hjust=1)) + 
  scale_color_manual(values = c("SCZfactor in BIP" = "darkred", "nonSCZ factor in BIP" = "skyblue","SCZfactor in MDD" ="darkred","nonSCZ factor in MDD"="skyblue"))

fig4b <- p



k<- grid.arrange(fig4a, fig4b, ncol=1)
ggsave("ptdt_combined.svg",k)
