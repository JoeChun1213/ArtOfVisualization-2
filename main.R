
library(tidyverse)
library(ggseg)  # ggplot + Segmentation
library(ggseg3d)   
library(magick)
## AFNI FSL FREESURFER

## surface (Cortex)   # Inner parts (Subcortex)

## DK atlas (Desikan-Killany atlas)
Atlas <- read_csv("~/Documents/Data Analysis/Gitrepos/20.ArtOfVisualiztion-R/Atlas.csv")   
Data <- read_csv("~/Documents/Data Analysis/Gitrepos/20.ArtOfVisualiztion-R/Data.csv")


colnames(Data)<-paste0("Time",c(1:ncol(Data)))


for (k in 1:ncol(Data)){
  
  Atlas['TE']<- rep(as.numeric(unlist(Data[k])),3)
  
  p<- Atlas %>% ggseg(mapping=aes(fill=TE),
                position="stacked",
                color="black") +
  theme_brain2()+
  scale_fill_gradientn(colours = c("dodgerblue4","light blue","white","yellow","firebrick"),
                       limits=c(min(Data),max(Data)))+
  guides(fill=guide_colourbar(barheight = 1,barwidth = 25,
                              label.theme = element_text(colour = "black",angle=0),
                              nbin=68,label.position = "bottom"))+
  theme(legend.title=element_text(size=26),
        legend.position = "bottom",
        text=element_text(size=26),
        legend.title.align=0.5,
        legend.text.align=0.5)

  print(p)

  ggsave(plot=p,file=paste0("~/Downloads/Brain/Brain",k),device = 'png') 
  
}


## making gif in R
image<-list.files("~/Downloads/Brain/")    # Get the list of files in the folder
img_list<-lapply(image,image_read)          #Read the image files one by one


img_joined<-image_join(img_list)          # join the images in the reading order

img_animated<-image_animate(img_joined,fps=1)   #Animate the list of images with 2 frames per sec

img_animated   # To view the animation file 
