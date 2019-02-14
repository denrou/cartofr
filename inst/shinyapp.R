library(cartofr)
library(dplyr)
library(leaflet)
library(sf)
library(shiny)

data(cartofr)

ui <- fluidRow(
    column(
        width = 12, align = "center",
        leafletOutput("map", height = 900, width = 900)
    )
)

server <- function(input, output) {
    id_val <- reactiveVal(0)

    data_map <- reactive({
        req(id_val())
        filter_insee <- input$map_shape_click$id
        res          <- cartofr[[id_val() + 1]]
        if (!is.null(filter_insee) && filter_insee > 0 && id_val() > 0) {
            res <- res %>%
                filter(code_insee_parent == filter_insee)
        }
        res
    })
    output$map <- renderLeaflet({
        centroid <- suppressWarnings(st_centroid(data_map()))
        data_map() %>%
            leaflet(options = leafletOptions(zoomControl = FALSE)) %>%
            addPolygons(color = "black", weight = 2, fillColor = "gray", fillOpacity = 0.2, layerId = ~code_insee) %>%
            addTiles() %>%
            addProviderTiles("CartoDB.PositronNoLabels") %>%
            addLabelOnlyMarkers(label = ~name_fr, data = centroid, labelOptions = labelOptions(noHide = TRUE, textOnly = TRUE, textsize = 20, direction = "center")) %>%
            addMiniMap(tiles = "CartoDB.Positron", zoomLevelFixed = 3)
    })

    observe({
        req(input$map_shape_click)
        isolate(id_val((id_val() + 1) %% length(cartofr)))
    })
}

# Run the application
shinyApp(ui = ui, server = server)
