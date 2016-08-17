library(shiny)
library(stringr)
library(ggplot2)

## the following function unordered_table takes a string of text as input 
## converts it to all lowercase
## and returns a data frame whose first column is letters of alphabet
## and second column is number of instances of each letter in mystring
## and third column is the frequeny (as a percentage) with which each letter appears

unordered_table<-function(mystring)
{ mystring<-tolower(mystring)
  count_vector<-as.integer("")
  j<-1
  for (i in letters)  { count_vector[j]<-str_count(mystring, i)
      j<-j+1
    }
  len<-sum(count_vector)
  freq<-100*count_vector/len
  df<-data.frame(letters, count_vector, freq)
}

## the function ordered_table takes a string of text as input
## calls the underordered_table function on that string
## then sorts the table based on count of each letter in decreasing frequency

ordered_table<-function(mystring)
{
  df<-unordered_table(mystring)
  df<-df[order(df$count_vector, decreasing=TRUE),]
  names(df)<-c("Letter", "Count", "Frequency (percentage)")
  df
}  
  
## the percentage_plot function takes a string of text as input
## call the unordered table function to get the frequency of each letter in the string
## then makes a scatterplot with the letters on the x-axis and the percentage on y-axis
percentage_plot<-function(mystring)
{
  df<-unordered_table(mystring)
  ggplot(df, aes(x=letters, y=freq)) + geom_point() + labs(y="Percentage")
}

shinyServer(
  function(input, output) {
    output$oid1 = renderPrint({input$id1})
    output$count_table = renderTable({ ordered_table(input$id1)})
    output$percentageplot = renderPlot({ percentage_plot(input$id1)})
  } )
