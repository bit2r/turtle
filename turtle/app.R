
library(shiny)
library(TurtleGraphics)

ui <- fluidPage(

    # App title ----
    titlePanel("거북이"),

    # Sidebar layout with input and output definitions ----
    sidebarLayout(

        # Sidebar panel for inputs ----
        sidebarPanel(

            sliderInput(inputId = "move",
                        label = "거북이 이동:",
                        min = 1,
                        max = 50,
                        value = 1),

            sliderInput(inputId = "angle",
                        label = "거북이 방향:",
                        min = 1,
                        max = 360,
                        value = 1)

        ),

        # Main panel for displaying outputs ----
        mainPanel(

            # Output: Turtle Playground ----
            plotOutput(outputId = "turtlePlot")

        )
    )
)


server <- function(input, output) {

    turtle <- reactiveValues(position = 0)

    observeEvent(input$move, {
        turtle$position <- turtle$position + input$move
    })


    output$turtlePlot <- renderPlot({

        turtle_init(mode = "clip")

        turtle_move(dist = turtle$position)
        turtle_right(angle = input$angle)

    })

}

shinyApp(ui, server)

