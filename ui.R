library('shiny')
library('leaflet')



ui <- fluidPage(
  
  titlePanel("Car Accidents in Russia"),
  

  sidebarPanel(sliderInput("userdate","Car accidents dates:",
                           min=as.Date("2018-01-01","%Y-%m-%d"),
                           max=as.Date("2018-11-01","%Y-%m-%d"),
                           value=c(as.Date("2018-02-01"),as.Date("2018-10-01")),
                           timeFormat="%Y-%m-%d"),
               uiOutput("regionSelector")
               
               
               ),
  
  
  mainPanel( 
    
    #this will create a space for us to display our map
    leafletOutput(outputId = "mymap")
  
    )
  )