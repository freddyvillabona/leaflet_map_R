{
library("readxl")
library("leaflet")
library("leafem")
}

logo <- "https://www.r-project.org/logo/Rlogo.svg"

data <- read_excel("dat.xlsx")
d <- 1

icons <- awesomeIcons(
  icon = "beer",
  iconColor = 'black',
  library = 'ion'
)


map <- leaflet(data) %>% 
  addTiles() %>%
  
  # Base groups
  addTiles(group = "OSM (default)") %>%
  addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
  
  addCircles(lng = ~data$long, 
             lat = ~data$lat, 
             weight = 8, 
             color="red",
             radius = ~d, 
             popup = ~data$text, 
             label = ~data$text, 
             group="Location") %>%
  
  addAwesomeMarkers(lng = ~data$long, 
                    lat = ~data$lat,icon=icons,
                    label = ~data$text,
                    group="Location") %>%
  
  # Layers control
  addLayersControl(
    baseGroups = c("OSM (default)",  "Toner Lite"),
    overlayGroups = c("Location"),
    options = layersControlOptions(collapsed = FALSE))  %>%
  addScaleBar() %>%
  addMouseCoordinates() %>%
  addLogo(logo, url = "https://www.r-project.org/logo/")

map

#FV
