#################### SPS loading screen functions ######################

#' render the app UI
#' Combine mainUI defined in ui.R and add the loading screen and more
#' @param mainUI a normal shiny page ui
#'
#' @return a `fluidPage`
#'
#' @examples
#' ui <- fluidPage()
#' server <- function(input, output, session) {}
#' mainUI <- shinyApp(ui, server)
#' spsUI(mainUI)
spsUI <- function(mainUI){
    fluidPage(
        if (getOption("sps")$loading_screen)
        {tagList(
            div(id = "app-main", style = "margin-left: -2em; margin-right: -2em; height:auto;", class = "shinyjs-hide",
                mainUI
            ),
            div(id = "loading-screen", style="height: 100vh; width: 100vw; overflow: hidden;",
                sytle="z-index:100; position:absolute;",
                tags$style('
                    #toapp{
                      border: none;
                      background: none;
                      z-index:100;
                        top: 85%;
                        left: 50%;
                      position:absolute;
                      display:block;
                      transform: translate(-50%, -50%);
                    }
                    #toapp:active {
                      transform: translate(-50%, -10%);
                    }
                               '),
                actionBttn(inputId = "toapp", "Continue to app", icon = icon("angle-double-right"), size = "lg"),
                renderLoading(),
                if(getOption('sps')$loading_particles) {
                    if (!requireNamespace("particlesjs", quietly = TRUE)){
                        msg("Option loading_particles is `true` but package particlesjs is not installed. Try `remotes::install_github('dreamRs/particlesjs')`",
                            "SPS-WARING", "orange")
                        div()
                    } else {
                        particlesjs::particles(
                            target_id ="loading-screen",
                            element_id = "particles",
                            config = "www/particlesjs-config.json"
                        )
                    }
                }
            )
        )}
        else
        {
            div(id = "app-main", style='position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px;', mainUI)
        }
    )
}

# Use this on UI
renderLoading <- function(){
    switch(getOption("sps")$loading_theme %>% as.character(),
           "vhelix" = loadingVhelix(),
           loading404()
    )
}
# Use this on server
serverLoadingScreen <- function(input, output, session){
    observeEvent(input$toapp,{
        shinyjs::hide("loading-screen", anim = TRUE, animType = "fade")
        shinyjs::show("app-main", anim = TRUE, animType = "fade")
    })
}


#### loading screen collections
loading404 <- function(){
    includeHTML("www/nyan.html")
}

loadingVhelix <- function(){
        includeHTML("www/vhelix.html")
}