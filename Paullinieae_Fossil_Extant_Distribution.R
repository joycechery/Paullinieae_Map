#Pull the lat long points from BIEN for extant Paullinieae
library("BIEN")
genera<- c("Serjania", "Paullinia", "Cardiospermum", "Lophostigma", "Thinouia", "Urvillea")
records <- BIEN_occurrence_genus(genera)
records <- records[!is.na(records$latitude),]
write.csv(records, "records.csv", row.names = FALSE)

#Export to edit
#1.Remove the invasive range of Cardiospermum corindum according to Gildenhuys et al 2015 [-16.38727	14.88797]
#2. Remove the invasive range of Cardiospermum grandiflorum according to Gildenhuys et al 2013, which is all African occurences
#3. Remove the invasive range of Cardiospermum halicacabumaccording to Gildenhuys et al 2013, which is all African occurences
#4. Added rows for fossil record occurences
#4. Added rows for Cardiospermum pechuelii dataset from GBIF (GBIF.org (11 January 2021) GBIF Occurrence Download https://doi.org/10.15468/dl.7yscgt)
#5. Imported the data back here:

records<-read.csv("records.csv")

library ("rnaturalearth")
#World Map
world <- ne_countries(scale='medium',returnclass = 'sf')

#Central America Map
CA <- ne_countries(scale='medium',returnclass = 'sf')
class(world)

library("ggplot2")
#plot panama map
ggplot(data = CA) +
  geom_sf(fill = "grey87", colour= "grey87", lwd= 0) +
  geom_point(data = records, mapping = aes(x = longitude, y = latitude), colour = "grey40", size =4, alpha=.6) + #scale_color_manual(values=my_pallete) +
  geom_point(data = records[2:9,], mapping = aes(x = records[2:9,]$longitude, y = records[2:9,]$latitude),
             shape=23, fill="grey99",colour="black", lwd=17 , stroke= 3, alpha=.95) +
  geom_point(data = records[1,], mapping = aes(x = records[1,]$longitude, y = records[1,]$latitude),
             shape="*", fill="red",colour="red", lwd=10 , stroke=1) +
  coord_sf(xlim = c(-96.15, -78), ylim = c(6, 20), expand = FALSE) +
  xlab("Longitude")+ ylab("Latitude")+
  theme(panel.grid.major = element_line(colour = "grey15", linetype = "dashed",
                                        size = 0.3), panel.background = element_rect(fill = "white"),
        panel.border = element_rect(fill = NA), 
        axis.text.x = element_text(color = "black", size = 17, angle = 0, hjust = .5, vjust = .5, face = "plain"),
        axis.text.y = element_text(color = "black", size = 17, angle = 0, hjust = .5, vjust = .5, face = "plain"),) 

#world map 
ggplot(data = world) +
  geom_sf(fill = "grey87", colour= "grey87", lwd= 0) +
  geom_point(data = records, mapping = aes(x = longitude, y = latitude), colour = "grey40", size =2, alpha=.5) +
  geom_point(data = records[2:9,], mapping = aes(x = records[2:9,]$longitude, y = records[2:9,]$latitude),
             shape=23, fill="white",colour="black", lwd=7 , stroke= 1.5, alpha=.98) +
  geom_point(data = records[1,], mapping = aes(x = records[1,]$longitude, y = records[1,]$latitude),
             shape="*", fill="red",colour="red", lwd=4 , stroke= 1.5) +
  coord_sf(xlim = c(-160, 60), ylim = c(-70, 40), expand = FALSE) +
  xlab("Longitude")+ ylab("Latitude")+
  theme(panel.grid.major = element_line(colour = "grey15", linetype = "dashed",
                                        size = 0.1), panel.background = element_rect(fill = "white"),
        panel.border = element_rect(fill = NA), 
        axis.text.x = element_text(color = "grey20", size = 10, angle = 0, hjust = .5, vjust = .5, face = "plain"),
        axis.text.y = element_text(color = "grey20", size = 10, angle = 0, hjust = .5, vjust = .5, face = "plain"),) 
