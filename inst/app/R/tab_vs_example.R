######################SPS My custom plotting tab tab######################
## creation date: 2021-01-24 21:32:04
## Author:

# vs_example UI
vs_exampleUI <- spsEzUI(
    desc = "
    This example tab is created by the `spsNewTab` function.
    Read more about tabs in SPS on [our website](https://systempipe.org/sps/adv_features/tabs/).

    #### Write some description of this tab in markdown format
    - you should ...
        1. eg 1.
        2. eg 2.
        - **Notice**: ...`this` ...


    ```
    some code demo ...
    ```
    ",
    tab_title = "My custom plotting tab",
    plot_title = "My Plot",
    plot_control =  shiny::tagList(
        # add some UI to toggle different plot options in a `tagList`
        # this example adds a text input to allow users to modify plot title,
        # see server code on how we can use it
        # remember to add `ns('ID')` around your ID. All tabs in SPS are built on
        # top of Shiny modules, use `ns()` to indicate namespace. This function
        # is not found when you write it, but will be valid once SPS runs it.
        shiny::fluidRow(
            class = "center-child",
            clearableTextInput(
                inputId = ns("plot_title"),
                label = "Plot title",
                value = "Example plot"
            )
        ) %>%
            bsHoverPopover("Plot title", "Type your plot title", placement = "top")
    )
)

# vs_example server
vs_exampleServer <- spsEzServer(
    plot_code = {
        # data passed from data loading is a reactiveValues object, data stored in `mydata$data`
        plot_data <- mydata$data
        # some validations, make sure users give you the right data format
        spsValidate({
            stopifnot(inherits(plot_data, "data.frame"))                        # require a dataframe
            stopifnot(nrow(plot_data) > 1)                                      # has least one row
            if (!all(c("Sepal.Length", "Sepal.Width") %in% colnames(plot_data)))# has two required columns
                stop("Require column 'Sepal.Length' and 'Sepal.Width'")

            TRUE # give it a TRUE if all checks passed.
            },
            verbose = FALSE # only show messages when fail
        )
        # actual plot code
        ggplot2::ggplot(plot_data) +
            ggplot2::geom_point(ggplot2::aes(x = Sepal.Length, y = Sepal.Width)) +
            # grab user defined title from plot control by `input$+control_ID`,
            # no need to add `ns()` on server end.
            ggplot2::ggtitle(input$plot_title)
    },
    other_server_code = {
        # additional server code for this tab you want to run
        msg("My tab xxx runs", "", "green")
    }
)
