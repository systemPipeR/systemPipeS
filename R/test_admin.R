# # Internal quick testing app for admin page
#
# addResourcePath("sps", "www")
#
# for (i in 1:10){
#     db$accAdd(paste0("user", i), "dsads!dddddd")
# }
#
# if (interactive()){
#     shinyApp(
#         div(
#             tags$head(
#                 shinytoastr::useToastr(),
#             ),
#             adminUI()
#         ),
#         function(input, output, session) {
#             shared <- reactiveValues()
#             observeEvent(1, {
#                 shared$admin$current_user <- "admin"
#                 shared$admin$users$acc_event <- 0
#             }, once = TRUE)
#             observe({shared$topInput[['admin-left_sidebar']] <- input[['admin-left_sidebar']]})
#             admin_infoServer("admin-info", shared)
#             admin_usersServer("admin-users", shared)
#
#         }
#     )
# }
