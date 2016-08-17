shinyUI(pageWithSidebar(
  headerPanel("Character frequency in text"),
  sidebarPanel(textInput("id1", "Enter text to analyze", value = "", width = 1000, placeholder = NULL)),
  mainPanel(
    h3('Output'),
    h4('You entered'),
    verbatimTextOutput("oid1"),
    h4('Sorted frequency table'),
    tableOutput("count_table"),
    h4('Percentage plot'),
    plotOutput("percentageplot")
  )
))

