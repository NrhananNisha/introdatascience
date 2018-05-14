Shiny Apps Code

library(shiny)

ui <- fluidPage(
  
  # App title ----
  titlePanel("Bilangan Graduan Universiti Awam Mengikut Jantina"),
  
  sidebarLayout(
    sidebarPanel(

      selectInput("dataset", "Choose a Dataset :",
                  choices = c("Data")), 
      
      numericInput("obs", "Number of observations to view:", 300),
      
      # Include clarifying text ----
      helpText("Note: while the data view will show only the specified",
               "number of observations, the summary will still be based",
               "on the full dataset."),
      
      actionButton("update", "Update View")
      
      
    ),
    
    
    
    
    
    mainPanel(
      
      
      
      h4("Scatter Plot"),
      plotOutput("plot"),

      h4("Summary"),
      verbatimTextOutput("summary"),
      
      h4("Table"),
      tableOutput("view")
      
      
      
      

     
    )
    
  )
)


server <- function(input, output) {

  csvInput <- eventReactive(input$update, {
    switch(input$dataset,
           "Data" = Data,
    )
  }, ignoreNULL = FALSE)
  

  
  output$summary <- renderPrint({
    Data <- csvInput()
    summary(Data)
  })
  output$view <- renderTable({
    head(csvInput(), n = isolate(input$obs))
  })
  
  output$plot <- renderPlot({
    Data<- csvInput()
    pairs(Data)})
  
  
  
  
  
  
}
shinyApp(ui, server)
