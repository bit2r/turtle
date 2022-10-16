library(TurtleGraphics)

turtle_init(mode = "clip")
turtle_forward(dist=30)
turtle_backward(dist=10)


turtle_right(90)
turtle_forward(dist=30)
turtle_backward(dist=10)

show_turtle <- function() {
  png('turtle.png')
    turtle_init()
    turtle_do({
      turtle_move(20)
      turtle_right(90)
      turtle_move(20)
      turtle_right(90)
      turtle_move(20)
      turtle_right(90)


      turtle_move(20)
      turtle_right(90)
    })
  dev.off()
}

show_turtle()

turtle_init()
turtle_setpos(x = 30, y = 50)
turtle_do({
  for(i in 1:180) {
    turtle_forward(dist = 1)
    turtle_right(angle = 2)
    Sys.sleep(0.01)
  }
})


# meta programming --------------------------------------------------------
library(rlang)

turtle_go <- rlang::expr(turtle_move(10))
eval(turtle_go)


turtle_order <- "turtle_move(5)"

turtle_go <- rlang::parse_expr(turtle_order)
eval(turtle_go)

