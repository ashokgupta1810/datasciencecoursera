#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Body Mass Calculator"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
          helpText("The body mass index (BMI), or Quetelet index, is a measure of relative weight based on an individual's mass and height.
             Devised between 1830 and 1850 by the Belgian polymath Adolphe Quetelet during the course of developing 'social physics', it is defined as the individual's body mass divided by the square of their height - with the value universally being given in units of kg/m^2. (Wikipedia)"), 
          numericInput(
              inputId = "mass",
              label = "your weight:",
              value = 70
          ),
          numericInput(
              inputId = "height",
              label = "your height:",
              value = 1.8
          )),
      
      # Show a plot of the generated distribution
      mainPanel(
          uiOutput("input"),
          uiOutput("result"),
          uiOutput("graph")
      )
   )
)

# Define server logic required to draw a histogram
# bmi <- function(mass, height) { bmi = mass / height^2 }
server <- function(input, output) {

    
        
        
    output$input <- renderText({
        unit.weight = "kg"
        unit.height = "m"
        paste0("You are ", "<strong>",input$mass, " ", unit.weight, " @ ", input$height, " ", unit.height, "</strong>")
    })
    
    output$result <- renderText({
       bmi = input$mass / input$height^2
       if      (bmi <  15.0) info = "<span style='color: red'>Very severely underweight</span>"
       else if (bmi <= 16.0) info = "<span style='color: red'>Severely underweight</span>"
       else if (bmi <= 18.5) info = "<span style='color: orange'>Underweight</span>"
       else if (bmi <= 25.0) info = "<span style='color: green'>Normal (healthy weight)</span>"
       else if (bmi <= 30.0) info = "<span style='color: orange'>Overweight</span>"
       else if (bmi <= 35.0) info = "<span style='color: red'>Obese Class I (Moderately obese)</span>"
       else if (bmi <= 40.0) info = "<span style='color: red'>Obese Class II (Severely obese)</span>"
       else                  info = "<span style='color: red'>Obese Class III (Very severely obese)</span>"
       
       paste0("Your BMI is ", "<code>", round(bmi, 2), "</code>", ", which is: ", info)
       
    })
    output$graph <- renderText({
        "<img style='width: 40em; margin-top: 1em' src='https://upload.wikimedia.org/wikipedia/commons/e/e9/Body_mass_index_chart.svg' title='Body mass index chart (Wikipedia)' />"
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

