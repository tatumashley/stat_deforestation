library(shiny)
library(ggplot2)
library(scales)
library(shinythemes)
library(bslib)
library(RCurl)
library(jpeg)

# Data
data1 <- data.frame(
  year = seq(2001, 2023),
  tree_cover_loss_ha = c(
    465542.98, 1621765.13, 1570575.59, 2016477.16, 1824425.47, 1415580.30,
    1149563.43, 1075145.50, 700169.31, 1153025.31, 803048.89, 1116088.23,
    632093.51, 940904.59, 828870.02, 2830977.44, 2134649.25, 1347132.98,
    1361094.44, 1704091.54, 1548658.40, 1772689.80, 1136874.10
  )
)

data2 <- data.frame(
  year = seq(2001, 2023),
  tree_cover_loss_ha = c(
    2746361.5567061, 3507049.44035898, 3248526.73442801, 3848770.7897087,
    3486562.7054962, 2876804.74696719, 2621820.17792644, 2444308.03831688,
    1817901.23275872, 2688896.17626597, 1923363.69454662, 2918633.14102396,
    1945506.25269363, 2693134.29548953, 2222772.41753093, 5378844.03454082,
    4519833.1714337, 2948462.08026938, 2696748.79925483, 3291391.78652612,
    2991909.30595056, 3308930.39154353, 2806057.58670084
  )
)

reasons3 <- c("Commodity driven deforestation", "Forestry", "Shifting agriculture", "Unknown", "Urbanization", "Wildfire")
trees3 <- c(29838617.82, 8640372.92, 21395805.2, 4139366.63, 4139366.63, 17743.73)
data3 <- data.frame(Reasons = reasons3, Trees = trees3)

year4 <- c(2001:2022)
carbon4 <- c(294948898.895008, 961863425.532789, 918066075.513721, 1228168921.47661, 1159220419.15249,
            892119519.004294, 703941480.740412, 681432846.060986, 462699343.699583, 724195154.636736,
            509213023.734653, 716700087.396985, 408186451.152455, 604050068.021692, 538144044.46617,
            1860243092.27781, 1296951330.75754, 897620831.542712, 904870797.44049, 1074057251.32116,
            1034785796.24898, 1219536764.98504)

data4 <- data.frame(Year = year4, Carbon = carbon4)

data5 <- data.frame(
  year = seq(2001, 2023),
  tree = c(
    92019.9871252689, 168992.516980507, 78138.0980791237, 123521.159893012, 
    149894.206842748, 146457.103653263, 154990.553671123, 121474.367083827, 
    218277.183539104, 265180.203300461, 148638.571243267, 211233.585714702, 
    351217.366498728, 439344.689043858, 322813.547244832, 499559.860922239, 
    471867.835424507, 481248.477330724, 475245.778051637, 490612.951188146, 
    499058.97107874, 512672.107098215, 526132.339739291
  )
)

data6 <- data.frame(
  year = seq(2001, 2023),
  tree_cover_loss_ha = c(
    455516.738970457, 514476.688199546, 274739.999366126, 400044.273963771, 
    485292.878750268, 453170.612811972, 462903.287611366, 404830.729350617, 
    635215.191560369, 810712.388681355, 429540.078693384, 630999.551152769, 
    920604.22145108, 1337961.08501101, 928115.638094076, 1381278.34884399, 
    1467956.65757784, 1373807.41228497, 1220177.45279689, 1309975.50808118, 
    1247857.46993346, 1220169.12199451, 1324890.10508342
  )
)

reasons7 <- c("Commodity driven deforestation", "Forestry", "Shifting agriculture", "Unknown", "Urbanization", "Wildfire")
trees7 <- c(36611417.08, 4768754.615, 8758464.557, 32689601.44, 3187849.32, 1059104.051)
data7 <- data.frame(Reasons = reasons7, Trees = trees7)

year8 <- c(2001:2022)
carbon8 <- c(62570728.6499209, 112916170.974888, 52903279.910486, 82204253.0590407, 
            100163255.331967, 98365281.4968749, 106481248.055896, 81820594.5057405, 
            150527749.247861, 178125484.344466, 100655655.112063, 144923369.287356, 
            247183483.608495, 299824170.293301, 225390815.620797, 353363283.603299, 
            331726143.832717, 337520383.518898, 338845049.995761, 350574830.679665, 
            355095592.158248, 369854122.445971)

data8 <- data.frame(Year = year8, Carbon = carbon8)

data9 <- data.frame(
  year = seq(2001, 2023),
  tree = c(
    10238.09836849000000000, 23529.78773425080000000, 15365.85033484100000000, 25102.87714829860000000, 
    16365.19274141340000000, 24784.75429220230000000, 25053.19991710380000000, 33901.37065753640000000, 
    23179.99519477640000000, 32759.56221710390000000, 26449.83749155880000000, 39700.83718178500000000, 
    30630.46496777290000000, 58477.80836185900000000, 77940.70601307900000000, 80232.22680359120000000, 
    63580.79860878200000000, 77265.80279364880000000, 57963.14716378620000000, 44864.90988622420000000, 
    43338.36586523420000000, 74969.52275522220000000, 47743.75844982350000000
  )
)

data10 <- data.frame(
  year = seq(2001, 2023),
  tree = c(
    36005.13509686910000000, 54575.50220283400000000, 31805.61402673570000000, 58329.43331145350000000, 
    39021.21608219120000000, 56388.40530135570000000, 49173.00345922210000000, 71045.21116784170000000, 
    49210.43941119160000000, 68761.27146652490000000, 53046.45901355750000000, 73333.39482874120000000, 
    56667.73028963180000000, 105664.41478776100000000, 180806.56705686900000000, 177925.92697005600000000, 
    117509.25452260100000000, 117935.02736154900000000, 95134.67482187430000000, 78439.73384573720000000, 
    76613.32149021470000000, 142078.82409512500000000, 83764.99133130850000000
  )
)

reasons11 <- c("Commodity driven deforestation", "Forestry", "Shifting agriculture", "Urbanization", "Wildfire")
trees11 <- c(14686.59252, 49148.35344, 185326.7593, 16389.46751, 43912.44099)
data11 <- data.frame(Reasons = reasons11, Trees = trees11)

year12 <- c(2001:2022)
carbon12 = c(
  8701775.067060520000000, 19959041.404649500000000, 13238995.703802900000000, 21306952.632361400000000, 
  13603110.185324700000000, 20820054.066763000000000, 21223826.775004800000000, 28359519.672732200000000, 
  19437093.840490400000000, 27709834.944404200000000, 22798801.102187000000000, 34808918.463970600000000, 
  26789902.174099300000000, 49845120.216073400000000, 65071454.809772700000000, 64908483.736883600000000, 
  54369955.724579000000000, 65368493.342313600000000, 49560615.491922200000000, 37732963.216469000000000, 
  36700231.735274700000000, 63605173.766625400000000
)

data12 <- data.frame(Year = year12, Carbon = carbon12)

library(RCurl)
myurl <- "https://i.kisscc0.com/20180517/kpw/kisscc0-amazon-rainforest-forest-floor-tropical-rainforest-nature-5afd5c4a3b22a8.2777891415265536742422.jpg"
my_image <-  readJPEG(getURLContent(myurl))

ui <- fluidPage(
  theme = bs_theme(version = 5, bootswatch = "minty"),
  headerPanel("Deforestation"),
  mainPanel(
    tabsetPanel(
      tabPanel("About",
                 fluidRow(
                   column(width = 4, align = "center",
                          img(src = myurl, width = "300%")),
                 ),
                 fluidRow(
                   column(width = 12,
                          p("Deforestation, the widespread clearing of forests for various purposes such as agriculture, logging, and urbanization, stands as a critical environmental challenge with far-reaching consequences. 
                          Rainforests, renowned for their unparalleled biodiversity and crucial role in regulating the Earth's climate, are particularly vulnerable to deforestation. 
                          The loss of these vital ecosystems not only leads to the displacement and extinction of countless plant and animal species but also disrupts essential ecological processes.
                          One of the most alarming outcomes of deforestation is its significant contribution to carbon emissions and climate change. 
                          Trees act as natural carbon sinks, absorbing carbon dioxide from the atmosphere during photosynthesis and storing it in their biomass. 
                          However, when forests are cleared or degraded, this stored carbon is released back into the atmosphere, exacerbating the greenhouse effect and contributing to global warming. 
                          Furthermore, the removal of trees diminishes the Earth's capacity to absorb carbon emissions, creating a dangerous feedback loop that intensifies climate change. 
                          Thus, addressing deforestation is not only crucial for safeguarding biodiversity but also for mitigating the impacts of climate change and ensuring a sustainable future for generations to come."))
                 )),
      tabPanel("The Amazon", 
               tabsetPanel(
                 tabPanel("Rainforest Tree Loss",
                          plotOutput("amazon_plot1", click = "plot_click1"),
                          verbatimTextOutput("info1"),
                          p("This bar graph represents the amount of tree coverage, in hectares, that the Amazon Rainforest has lost each year over a 23 year period. 
                            From this, it is obvious that there are some fluctuations in this region regarding tree coverage loss. In the early 2000s there was a steady increase, but it dipped from 2005 until 2015, after which there was a large spike.
                            This is an indication that deforestation is still a prevalent problem, but it does seem to be decreasing; 
                            after the spike there is a decrease until it levels off at about 1.7 million hectares per year.
                            This is still a large amount of loss per year, but there are large efforts going into preserving this rainforest and its abundant biodiversity.
                            Unfortunately, this is not something that is true for the other two rainforests, as will be observed later.")
                 ),
                 tabPanel("Tree Loss in Surrounding Region",
                          plotOutput("amazon_plot2", click = "plot_click2"),
                          verbatimTextOutput("info2"),
                          p("This provides a similar analysis as in the Rainforest Tree Loss tab, but it expans the tree coverage loss to the region surrounding the rainforest, as well.
                            It is a well known facts that rainforests are the subject of large tree loss do to an extensive list of reasons, but surrounding cities and regions are also losing tree coverage.
                            This lack of green space is one of the many causes contributing to the heat waves occuring in major concrete cities. 
                            As can observed from the scale of this graph, the tree coverage loss including the regions surrounding the Amazon rainforest is doubled in most cases. 
                            Though the tree loss is more level throughout the year, indicating that there is not an increase, there is still an average of 3 million hectares being lost every year.")
                 ),
                 tabPanel("Drivers of Tree Loss",
                          plotOutput("amazon_plot3"),
                          p("This pie chart illustrates the breakdown of tree loss by reason.The main culprit for deforestation in the Amazon appears to be commodity driven deforestation.
                            Commodity-driven deforestation refers to the process of clearing forests to make way for the production of commodities such as palm oil, soybeans, cattle, and timber. 
                            This type of deforestation is primarily motivated by economic interests, driven by the demand for these commodities in global markets. 
                            Large-scale agricultural expansion, often facilitated by industrial farming practices and land conversion, is a leading driver of deforestation in many tropical regions. 
                            The conversion of forests into agricultural land not only results in the loss of biodiversity and ecosystem services but also contributes significantly to carbon emissions and climate change. 
                            Though this is the main driver for deforestation for this rainforest, it is important to note that it still makes up less than 50% of the total tree loss; 
                            there are many elements that need to be further observed in order to slow down, and eventually counteract and stop, deforestation.")
                 ),
                 tabPanel("Carbon Emissions",
                          plotOutput("amazon_plot4",click = "plot_click4"),
                          verbatimTextOutput("info4"),
                          p("This line graph helps to demonstrate the effects of deforestation relating to carbon emissions. It is important to note that rainforests, forests in general actually, tend to absorb about twice as much carbon as they emit into the atmosphere.
                            This makes these areas major carbon sinks, which is very important in maining the state of the environment. Deforestation causes these forests to emit more carbon and absorb less, thus hastening the climate crisis.
                            The best line helps to demonstrate how the carbon emissions from the rainforests are changing each year.
                            As is evident by this model, carbon emissions have been increasing over this 23 year period; there are sinks and spikes in the data so it has not been rising consistantly every year, but overall it is important to note that it is rising.")
                 ),
                 tabPanel("Stats",
                          p("put stats here"))
               )
      ),
      tabPanel("The Congo", 
               tabsetPanel(
                 tabPanel("Rainforest Tree Loss",
                          plotOutput("congo_plot5",click = "plot_click5"),
                          verbatimTextOutput("info5"),
                          p("This bar graph represents the amount of tree coverage, in hectares, that the Congo Rainforest has lost over a 23 year period. Similar to the Amazon rainforest, there is a large amount of tree loss every year, 
                            but where the Amazon has leveled off, the Congo has drastically increased the hectares of tree loss every year.
                            It is important to note that it is on a much smaller scale, but it is also a smaller rainforest, so it is a very comparable percentage when being compared to the Amazon.
                            This steady increase is not a good sign; this is obviously in part due to the tree loss, but also because there seems to have been less of a conservation effort in this region than there has been in the Amazon.")
                 ),
                 tabPanel("Tree Loss in Surrounding Region",
                          plotOutput("congo_plot6",click = "plot_click6"),
                          verbatimTextOutput("info6"),
                          p("This plot illustrates the surrounding tree cover loss in Congo over the years. This is similar to the rainforest loss in the pattern; the bar graphs seem to be very similar.
                            The surrounding coverage, however, is nearly triple that of the rainforest coverage loss- this includes the rainforest along with surrounding regions, so it follows that the surroundings regions have lost double the amount of tree coverage than the rainforest.
                            This is likely due to growing populations and urbanization in this part of the world. Even though urbanization may not be a leading cause, supporting urban populations takes an enormous amount of agricultural land.")
                 ),
                 tabPanel("Drivers of Tree Loss",
                          plotOutput("congo_plot7"),
                          p("This pie chart illustrates the breakdown of tree loss in Congo by reason. The leading cause in this region is also commodity driven deforestation, much like the Amazon.
                            However, there is much more 'Unknown' data, so there could be a multitude of other leading causes that are just not represented by this dataset fully.")
                 ),
                 tabPanel("Carbon Emissions",
                          plotOutput("congo_plot8",click = "plot_click8"),
                          verbatimTextOutput("info8"),
                          p("This is a model of the carbon emissions of the Congo. While the Amazon does have an increasing level of carbon emissions,
                            it somewhat pales to this rainforest. The sacles are slightly different, which is something of note, but considering the varying sizes of the rainforests,
                            the emissions from the Congo are increasing at a larger rate; this makes sense considering the tree coverage loss is increasing at a larger rate than that of the Amazon which has leveled off.
                            There are also fewer large deviations from the best fit line in this model than in the model for carbon emissions in the Amazon region;
                             which indicates there may be more statistical certainty in the increase of carbon emissions in the Congo, unless something is done to combat this.")
                 ),
                 tabPanel("Stats",
                          p("put stats here"))
               )
      ),
      tabPanel("New Guinea", 
               tabsetPanel(
                 tabPanel("Rainforest Tree Loss",
                          plotOutput("papua_plot9",click = "plot_click9"),
                          verbatimTextOutput("info9"),
                          p("This plot illustrates the rainforest tree cover loss in Papua New Guinea over the years. This is on an even smaller scale than the Congo, but once again it should be noted that this is a smaller rainforest.
                            There is a rather steady increase in tree loss, much like in the Congo, but - similarly to the Amazon - there are more rises and falls and if the current pattern continues, it appears like the loss may level out, or steady.
                            Though there will still be loss, steady loss is an improvement from increasing loss.")
                 ),
                 tabPanel("Tree Loss in Surrounding Region",
                          plotOutput("papua_plot10",click = "plot_click10"),
                          verbatimTextOutput("info10"),
                          p("This plot illustrates the surrounding tree cover loss in Papua New Guinea over the years. Much like in the other rainforests, it has a pattern similar to that of rainforest tree loss, but on a larger scale.
                            However, it is only about double that of the rainforests, if that. This means that, overall, there is less tree cover loss (by percentage) than occurs in the other regions surrounding the Amazon and the Congo.")
                 ),
                 tabPanel("Drivers of Tree Loss",
                          plotOutput("papua_plot11"),
                          p("This pie chart illustrates the breakdown of tree loss in Papua New Guinea by primary drivers; unlike in the other two rainforests, the primary driver is shifting agriculture.
                            Shifting agriculture, also known as slash-and-burn or swidden agriculture, is a traditional farming method practiced in many tropical regions worldwide. 
                            It involves clearing patches of forest, burning the vegetation to release nutrients into the soil, and then cultivating crops for a few years until the soil fertility declines. 
                            Afterward, farmers abandon the plot and move to a new area, allowing the land to regenerate naturally over time. 
                            While shifting agriculture can be sustainable when practiced in small-scale and with long fallow periods, rapid population growth and the expansion of commercial agriculture have led to its intensification and subsequent environmental degradation. 
                            This can be increased by commodity driven deforestation. Though they are categorized separately, the economical and market need for goods may increase the practice of shifting agriculture.")
                 ),
                 tabPanel("Carbon Emissions",
                          plotOutput("papua_plot12",click = "plot_click12"),
                          verbatimTextOutput("info12"),
                          p("The carbon emissions are at a large increase in the Papua New Guinea rainforest, much like in the Congo.
                            There have been larger deviations from the best fit line on the past seven years; there is both a large spike and a large dip in the carbon emissions;
                            though, overall, there is still an increase in the emissions :(")
                 ),
                 tabPanel("Stats",
                          p("put stats here"))
               )
      ),
      tabPanel("References",
               fluidRow(
                 column(width = 12,
                        uiOutput("references_text"))
               ))
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  output$amazon_plot1 <- renderPlot({
    ggplot(data1, aes(x = factor(year), y = tree_cover_loss_ha)) +
      geom_bar(stat = "identity", fill = "darkgreen") +
      labs(x = "Year", y = "Rainforest Tree Cover Loss (hectares)", title = "Deforestation in the Amazon Region (2001-2023)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      scale_x_discrete(labels = function(x) substring(x, 3)) + 
      scale_y_continuous(labels = comma)
  })
  
  output$amazon_plot2 <- renderPlot({
    ggplot(data2, aes(x = factor(year), y = tree_cover_loss_ha)) +
      geom_bar(stat = "identity", fill = "green") +
      labs(x = "Year", y = "Surrounding Tree Cover Loss (hectares)", title = "Tree Cover Loss in Brazil (2001-2023)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      scale_x_discrete(labels = function(x) substring(x, 3)) + 
      scale_y_continuous(labels = comma)
  })
  
  output$amazon_plot3 <- renderPlot({
    pie(data3$Trees, labels = data3$Reasons, main = "Tree Loss by Reason", col = rainbow(length(data3$Trees)))
  })
  
  output$amazon_plot4 <- renderPlot({
    fit <- lm(Carbon ~ Year, data = data4)
    pred_2050 <- predict(fit, newdata = data.frame(Year = 2050))
    df_ext <- data.frame(Year = c(year4, 2024:2050))
    pred_ext <- predict(fit, newdata = df_ext)
    
    plot(data4$Year, data4$Carbon, type = "l", lwd = 2, col = "darkgreen", xlab = "Year", ylab = "Carbon Emissions (Mg)",
         main = "Carbon Emissions vs. Year")
    
    lines(df_ext$Year, pred_ext, col = "lightblue", lwd = 2)
    
    legend("topright", legend = c("Data", "Best-fit Line"),
           col = c("darkgreen", "lightblue"), lwd = c(2, 2), lty = c(1, 1))
  })
  
  output$congo_plot5 <- renderPlot({
    ggplot(data5, aes(x = factor(year), y = tree)) +
      geom_bar(stat = "identity", fill = "darkgreen") +
      labs(x = "Year", y = "Rainforest Tree Cover Loss (hectares)", title = "Deforestation in the Congo (2001-2023)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      scale_x_discrete(labels = function(x) substring(x, 3)) + 
      scale_y_continuous(labels = comma)
  })
  
  output$congo_plot6 <- renderPlot({
    ggplot(data6, aes(x = factor(year), y = tree_cover_loss_ha)) +
      geom_bar(stat = "identity", fill = "green") +
      labs(x = "Year", y = "Surrounding Tree Cover Loss (hectares)", title = "Tree Cover Loss in the Congo Region (2001-2023)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      scale_x_discrete(labels = function(x) substring(x, 3)) + 
      scale_y_continuous(labels = comma)
  })
  
  output$congo_plot7 <- renderPlot({
    pie(data7$Trees, labels = data7$Reasons, main = "Tree Loss by Reason", col = rainbow(length(data7$Trees)))
  })
  
  output$congo_plot8 <- renderPlot({
    fit <- lm(Carbon ~ Year, data = data8)
    pred_2050 <- predict(fit, newdata = data.frame(Year = 2050))
    df_ext <- data.frame(Year = c(year8, 2024:2050))
    pred_ext <- predict(fit, newdata = df_ext)
    
    plot(data8$Year, data8$Carbon, type = "l", lwd = 2, col = "darkgreen", xlab = "Year", ylab = "Carbon Emissions (Mg)",
         main = "Carbon Emissions vs. Year")
    
    lines(df_ext$Year, pred_ext, col = "lightblue", lwd = 2)
    
    legend("topright", legend = c("Data", "Best-fit Line"),
           col = c("darkgreen", "lightblue"), lwd = c(2, 2), lty = c(1, 1))
  })
  
  output$papua_plot9 <- renderPlot({
    ggplot(data9, aes(x = factor(year), y = tree)) +
      geom_bar(stat = "identity", fill = "darkgreen") +
      labs(x = "Year", y = "Rainforest Tree Cover Loss (hectares)", title = "Deforestation in New Guinea Rainforest (2001-2023)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      scale_x_discrete(labels = function(x) substring(x, 3)) + 
      scale_y_continuous(labels = comma)
  })
  
  output$papua_plot10 <- renderPlot({
    ggplot(data10, aes(x = factor(year), y = tree)) +
      geom_bar(stat = "identity", fill = "green") +
      labs(x = "Year", y = "Surrounding Tree Cover Loss (hectares)", title = "Tree Cover Loss in the Papua New Guinea Region (2001-2023)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      scale_x_discrete(labels = function(x) substring(x, 3)) + 
      scale_y_continuous(labels = comma)
  })
  
  output$papua_plot11 <- renderPlot({
    pie(data11$Trees, labels = data11$Reasons, main = "Tree Loss by Reason", col = rainbow(length(data11$Trees)))
  })
  
  output$papua_plot12 <- renderPlot({
    fit <- lm(Carbon ~ Year, data = data12)
    pred_2050 <- predict(fit, newdata = data.frame(Year = 2050))
    df_ext <- data.frame(Year = c(year12, 2024:2050))
    pred_ext <- predict(fit, newdata = df_ext)
    
    plot(data12$Year, data12$Carbon, type = "l", lwd = 2, col = "darkgreen", xlab = "Year", ylab = "Carbon Emissions (Mg)",
         main = "Carbon Emissions vs. Year")
    
    lines(df_ext$Year, pred_ext, col = "lightblue", lwd = 2)
    
    legend("topright", legend = c("Data", "Best-fit Line"),
           col = c("darkgreen", "lightblue"), lwd = c(2, 2), lty = c(1, 1))
  })
  
  output$info1 <- renderText({
    paste0("x=", input$plot_click1$x, "\ny=", input$plot_click1$y)
  })
  output$info2 <- renderText({
    paste0("x=", input$plot_click2$x, "\ny=", input$plot_click2$y)
  })
  output$info4 <- renderText({
    paste0("x=", input$plot_click4$x, "\ny=", input$plot_click4$y)
  })
  output$info5 <- renderText({
    paste0("x=", input$plot_click5$x, "\ny=", input$plot_click5$y)
  })
  output$info6 <- renderText({
    paste0("x=", input$plot_click6$x, "\ny=", input$plot_click6$y)
  })
  output$info8 <- renderText({
    paste0("x=", input$plot_click8$x, "\ny=", input$plot_click8$y)
  })
  output$info9 <- renderText({
    paste0("x=", input$plot_click9$x, "\ny=", input$plot_click9$y)
  })
  output$info10 <- renderText({
    paste0("x=", input$plot_click10$x, "\ny=", input$plot_click10$y)
  })
  output$info12 <- renderText({
    paste0("x=", input$plot_click12$x, "\ny=", input$plot_click12$y)
  })
  output$my_image <- renderImage({
    list(src = myurl, width = "300%")
  }, deleteFile = FALSE)
  
  output$references_text <- renderText({
    references <- c(
      "<a href='https://shiny.posit.co/r/articles/build/layout-guide/'>Shiny Layout Guide</a>",
      "<a href='https://stackoverflow.com/questions/12888120/loading-png-files-directly-from-url/12888177#12888177'>Stack Overflow: Loading PNG files directly from URL</a>",
      "<a href='https://rstudio.github.io/bslib/articles/bs5-variables/index.html'>bslib: Bootstrap 5 Variables</a>",
      "<a href='https://www.globalforestwatch.org/dashboards/country/COD/'>Global Forest Watch: Congo Dashboard</a>",
      "<a href='https://www.globalforestwatch.org/dashboards/country/BRA/?map=eyJjYW5Cb3VuZCI6dHJ1ZX0%3D'>Global Forest Watch: Brazil Dashboard</a>",
      "<a href='https://www.globalforestwatch.org/dashboards/country/PNG/?location=WyJjb3VudHJ5IiwiUE5HIl0%3D&map=eyJjYW5Cb3VuZCI6dHJ1ZX0%3D'>Global Forest Watch: Papua New Guinea Dashboard</a>",
      "<a href='https://www.youtube.com/watch?v=XoCgToAuzsU'>YouTube: Shiny Tutorial</a>"
    )

    references_html <- paste(references, collapse = "<br>")
    HTML(references_html)
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
