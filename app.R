Sys.setenv(RETICULATE_PYTHON='/Users/Hui/opt/anaconda3/envs/r-cl/bin/python')
library(shiny)
library(shinythemes)
library(reticulate)

# Define UI for application that draws a histogram
ui <- fluidPage(
	theme = shinytheme("spacelab"),
	titlePanel("Lindel with Rshiny"),
	
	sidebarLayout(
		sidebarPanel(
			textInput("sequence", label = "Please enter your sequence here:"),
			downloadButton("downloadTable", "Download Lindel result"),
		),
		mainPanel(
			tableOutput("result") )
		)
)

# Define server logic required to draw a histogram
server <- function(input, output) {
	use_virtualenv("lindel")
  setwd("/Users/Hui/CRISPRLindel/Lindel")
	source_python("RLindelprediction.py")
	
	datasetInput <- reactive({
		req(input$sequence)
		res <- rlp(input$sequence)
		e <- 'Error: No PAM sequence is identified.Please check your sequence and try again'
		if (res == e) {
			res <- 'No PAM sequence is identified. Please check your sequence and try again!'
		} else {
			res1<- data.frame(res)
			result <- t(res1)
			row.names(result) <- NULL
			col1Name <- result[1,1]
			colnames(result) <- c(col1Name, "Frequency", "Location")
			result <- result[2:nrow(result), ]
			res <- result
		} } )
	
	output$result <- renderTable( { datasetInput() } )
	
	output$downloadTable <- downloadHandler(
		filename <- "Lindel_result.csv",
		content <- function(file) {
			write.csv(datasetInput(), file, row.names = FALSE)
		}
	)
}

# Run the application
shinyApp(ui = ui, server = server)