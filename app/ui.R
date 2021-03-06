#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

dashboardPage(
    skin = "green",
    title = "Quantifying Social Distancing",
    dashboardHeader(title = "Quantifying Social Distancing",
                    titleWidth = 300),
    dashboardSidebar( 
        sidebarMenu(
        menuItem("Home", tabName = "home", icon = icon("home")),
        menuItem("Map", tabName = "dashboard", icon = icon("compass")),
        menuItem("Parks Timelime", tabName = "sd", icon = icon("tree"),startExpanded = TRUE,
                 menuSubItem("Brooklyn",tabName = "sd1"),
                 menuSubItem("Bronx",tabName = "sd2"),
                 menuSubItem("Manhattan",tabName = "sd3"),  
                 menuSubItem("Queens",tabName = "sd4"), 
                 menuSubItem("Staten Island",tabName = "sd5")
                 ),
        menuItem("Transportation Timeline", tabName = "ts", icon = icon("car")),
        menuItem("Data", tabName = "source", icon = icon("database"))
    )
    ),
    dashboardBody(
        tabItems(
            # First tab content
            #home
            tabItem(tabName = "home",
                    fluidPage(
                        fluidRow(
                            box(width = 15, title = "Introduction", status = "success",
                                solidHeader = TRUE, h3(tags$b("Quantifying Social Distancing")),
                                h4("By Qinzhe Hu, Depeng Kong, Rui Liang, Yotam Segal, Hankun Shi"),
                                h5("Social Distancing is an important factor in the fight against the Pandemic.", tags$br(),"Nevertheless, to date, there has been very little research on how to quantify and measure social distancing.", tags$br(),tags$br(),"It is indeed a difficult task. People move around and it is virtually impossible to keep track on their interactions and physical distance from others.", tags$br(),"Accurately measuring social distancing would allow society to predict cases and inform decision makers by providing real-time data. This crucial step would enable to take highly targeted preemptive measures, rather than wide lock-downs." , tags$br(),tags$br(),"Indeed, some nations are using cellular tracking to measure social distancing and help with contact tracing, but in most countries this measure is unconstitutional and, in some regions, it is simply unfeasible.", tags$br(),tags$br(),tags$b("In this project we explore ways in which society can measure social distancing by using control variables: Park Gatherings, collected by NYC Department of Parks & Recreation, and Transportation data, collected by Apple."))
                               )),
                        fluidRow(box(width = 15, title = "User Guide", status = "success",
                                     solidHeader = TRUE, 
                                     tags$div(tags$ul(
                                         tags$li("Map: An interactive map of NYC, displaying cumulative park gatherings and confirmed Covid-19 cases"),
                                         tags$li("Parks Timelime: An interactive timelime of new daily updated park gatherings and confirmed Covid-19 cases"),
                                         tags$li("Transportation Timeline: An interactive timeline of transportation methods taken at NYC and new Covid-19 cases" ),
                                         tags$li("Data: Data sources we used in building this app")
                                     ))))
                    )),
            # Second tab content
            tabItem(tabName = "dashboard",
                    h2("Park Gathering and Covid-19", align = 'center'),
                    leafletOutput("map_park_covid", width = "100%", height = 800),
                    #absolutePanel(id = "control", class = "panel panel-default", fixed = T, draggable = TRUE,
                    #             top = 150, left = 300, right = "auto", bottom = "auto", width = 300, height = "auto",
                    #)
            ),
            # Third tab content
            tabItem(tabName = "sd1",
                    fluidPage(
                        h2("Brooklyn", align = 'center'),
                        fluidRow(
                            column( width = 12,h4("Park Gathering and Covid-19", align = 'center'), highchartOutput('BKdistPlot')
                            )  
                        )
                    )
                    
            ),
            tabItem(tabName = "sd2",
                    fluidPage(
                        h2("Bronx", align = 'center'),
                        fluidRow(
                            column( width = 12,h4("Park Gathering and Covid-19  ", align = 'center'), highchartOutput('BXdistPlot')
                            )  
                        )
                    )
                    
            ),
            tabItem(tabName = "sd3",
                    fluidPage(
                        h2("Manhattan", align = 'center'),
                        fluidRow(
                            column( width = 12,h4("Park Gathering and Covid-19  ", align = 'center'), highchartOutput('MNdistPlot')
                            )  
                        )
                    )
                    
            ),
            tabItem(tabName = "sd4",
                    fluidPage(
                        h2("Queens", align = 'center'),
                        fluidRow(
                            column( width = 12,h4("Park Gathering and Covid-19  ", align = 'center'), highchartOutput('QNdistPlot')
                            )  
                        )
                    )
                    
            ),
            tabItem(tabName = "sd5",
                    fluidPage(
                        h2("Staten Island", align = 'center'),
                        fluidRow(
                            column( width = 12,h4("Park Gathering and Covid-19  ", align = 'center'), highchartOutput('SIdistPlot')
                            )  
                        )
                    )
                    
            ),
            # Fourth tab content
            tabItem(tabName = "ts",
                    h2("Transportation", align = 'center'),
                    fluidPage(
                        fluidRow(
                            column( width = 12, highchartOutput('transPlot'))
                        ),
                    h6("*Transportation data is a 7-day moving average.")
            )
        ),
        # Fifth tab content
        tabItem(tabName = "source",
                h2("Data Sources", align = 'center'),
                fluidPage(
                    fluidRow(
                        box(width = 15, title = "Covid-19", status = "success",
                            solidHeader = TRUE,
                            h4("This dataset was collected by NYC Health Department."),
                            a("[https://github.com/nychealth/coronavirus-data]",href="https://github.com/nychealth/coronavirus-data")
                            )),
                    
                    fluidRow(
                        box(width = 15, title = "Park Gathering", status = "success",
                            solidHeader = TRUE,
                            h4("Collected by NYC Parks Open Data, this dataset contains park gathering in NY's 5 boroughs. This data was collected from 25.03.2020 until 30.06.2020 by Park employees, and it was updated on a daily frequency. We cleaned the dataset before processing. ")
                            ,
                            a("[https://data.cityofnewyork.us/dataset/Social-Distancing-Parks-Crowds-Data/gyrw-gvqc]",href="https://data.cityofnewyork.us/dataset/Social-Distancing-Parks-Crowds-Data/gyrw-gvqc"))),
                    fluidRow(
                        box(width = 15, title = "Transportation", status = "success",
                            solidHeader = TRUE,
                            h4("Collected by Apple, this dataset contains direction searches conducted by users around the globe. The data is available from 13.01.2020 to today, but trimmed from 01.03.2020 to 30.06.2020. The data is updated on a daily frequency. We cleaned the dataset before processing. ")
                            ,
                            a("[https://covid19-static.cdn-apple.com/mobility]",href="https://covid19-static.cdn-apple.com/mobility")
                            )),
                    fluidRow(
                        box(width = 15, title = "Geolocation", status = "success",
                            solidHeader = TRUE,
                            h4("We used NYC Parks dataset provided by NYC Department of Parks & Recreation to convert parks' IDs into their corresponding ZIP codes and coordinate locations.")
                            ,
                            a("[https://www.nycgovparks.org/bigapps/]",href="https://www.nycgovparks.org/bigapps/"))),
                    fluidRow(
                        box(width = 15, title = "Code", status = "success",
                            solidHeader = TRUE,
                            h4("The code for this project can be found on GitHub.")
                            ,
                            a("[https://github.com/TZstatsADS/Fall2020-Project2-group4]",href="https://github.com/TZstatsADS/Fall2020-Project2-group4")))
                ))
        )
    )
    )

