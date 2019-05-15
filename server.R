#install.packages("leaflet")

library('shiny')
library('leaflet')

options(stringsAsFactors = F)
data<-read.csv("Moscow.csv", encoding = "UTF-8")
data<-data.frame(cbind(data$cards.date,data$cards.POG,data$cards.infoDtp.COORD_W,data$cards.infoDtp.COORD_L,data$region_name))
data2<-read.csv("Moscow oblast.csv", encoding = "UTF-8")
data2<-data.frame(cbind(data2$cards.date,data2$cards.POG,data2$cards.infoDtp.COORD_W,data2$cards.infoDtp.COORD_L,data2$region_name))
data<-rbind(data,data2)
rm(data2)
data[,1]<-as.Date(data[,1],format="%d.%m.%Y")
data[,2]<-as.numeric(data[,2])
data[,3]<-as.numeric(data[,3])
data[,4]<-as.numeric(data[,4])
colnames(data)<-c("date","POG","latitude","longitude","region_name")
regions<-c(unique(data$region_name))




#sample<-data[data$date<=input$userdate,]
### Map plotiing ----


### Define server logic required to draw a histogram ------
shinyServer(function(input, output) {
   
  
  
  
  sample <- reactive({
    
    sample<-data[input$userdate[1]<=data$date & data$date<=input$userdate[2] & data$region_name==input$userregion,]
    
 
    })
  output$regionSelector<-renderUI({
    selectInput("userregion"," Select region:",regions,selected=NULL)
  })
  
  
  output$mymap <- renderLeaflet({
    m<-leaflet()
    m<-addTiles(m)
    m<-addMarkers(m,lng=sample()$longitude,lat=sample()$latitude,label=sample()$date,
                clusterOptions=markerClusterOptions())
    m
    
  })
  
})
