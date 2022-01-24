#Vaccination coverage and vaccination card usuage
#load libraries
library (data.table)
library (ggplot2)
library (ggpubr)
library (dplyr)
library(tidyverse)

#clear workspace
rm (list = ls ())

#read file with plot data
plot_data <- fread ("Figure 1.csv")

#draw plot
p <- ggplot (plot_data, aes(x=reorder (Category, desc (specific_order)), y = Coverage, fill = Level)) + 
  geom_bar(position="dodge", stat="identity")  +
  geom_errorbar (aes (ymin = LL, ymax = UL, width = 0.25), 
                 position=position_dodge(.9), col = "black") +
  labs (y="Coverage (%)") + 
  scale_fill_brewer(palette="Blues") +
  scale_y_continuous(limits = c(0,100)) +
  theme_bw () + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme(legend.title = element_blank(), axis.ticks = element_blank(), legend.text = element_text(size = 18)) + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  theme (axis.title.x = element_blank ()) +
  theme (strip.text.y = element_text (size = 15))  + 
  theme (text = element_text(size=21))
 

#print chart
print (p)

# save plot to file
ggsave (filename = "plot_vac.jpg", 
        plot = p, 
        units = "in", width = 14, height = 6, 
        dpi = 600)

ggsave (filename = "plot_vac.eps", 
        plot = p, 
        units = "in", width = 14, height = 6,
        device = cairo_ps)
  
