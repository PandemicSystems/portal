library(tidyverse)

habitats <- read_csv("IUCNRedListHabitatAssociations_Mammals_25Jan2022.csv")
taxonomy <- read_csv("MammalTaxonomyDictionary_15Jul2022.csv")
carnivores <- read_csv("CarnivoreTraits22Mar2021.csv")

orders <- unique(taxonomy$order)
families <- unique(taxonomy$family)
genuses <- unique(taxonomy$genus)


library(shiny)

ui = fluidPage(
  selectInput(inputId = "Order",
              label = "Select Order",
              choices = orders),
  selectInput(inputId = "Family",
              label = "Select Family",
              choices = NULL),
  textOutput('test')
)

server <- function(input,output,session) {
  
  observeEvent(input$Order,{
    fams <- taxonomy %>% filter(order==input$Order) %>% pull(family) %>% unique()
    
    updateSelectInput(session,'Family', 
                      choices = fams)
  })
  
  output$test = renderText({
    gens <- taxonomy %>% filter(family==input$Family) %>% pull(genus) %>% unique()
    text = paste(gens,sep=', ')
  })
}

shinyApp(ui, server)