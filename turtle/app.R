
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
            plotOutput(outputId = "turtlePlot"),
            verbatimTextOutput(outputId = "turtle_program"),

        )
    )
)


server <- function(input, output) {

    turtle <- reactiveValues(position = 0,
                             program = "")

    observeEvent(input$move, {
        turtle$position <- turtle$position + input$move
    })

    ### 주사위 던지기 이력 ------------------
    program_val <- c()

    program_history <- reactive({
        program_val <<- c(program_val,glue::glue("turtle_move({turtle$position})"))
    })


    observeEvent(input$move, {
        turtle$program <- glue::glue("turtle_move({turtle$position})")
    })

    output$turtlePlot <- renderPlot({

        turtle_init(mode = "clip")

        turtle_go <- rlang::parse_expr(program_history())
        eval(turtle_go)
        turtle_right(angle = input$angle)

    })

    output$turtle_program <- renderText({

        # print(glue::glue("{turtle$program}"))
        print(program_history())

    })

}

shinyApp(ui, server)

