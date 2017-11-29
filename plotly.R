install.packages("plotly")
library(plotly)
# import plotly
# 
# import plotly.plotly as py
# import plotly.graph_objs as go
# 
# # Create random data with numpy
# import numpy as np
# 
# N = 1000
# random_x = np.random.randn(N)
# random_y = np.random.randn(N)
# 
# # Create a trace
# trace = go.Scatter(
#   x = random_x,
#   y = random_y,
#   mode = 'markers'
# )
# 
# data = [trace]
# 
# # Plot and embed in ipython notebook!, 오프라인으로 데이터를 보기
# plotly.offline.plot(data)
p <- plot_ly(midwest, x = ~percollege, color = ~state, type = "box")
p


library(plotly)
today <- Sys.Date()
tm <- seq(0, 600, by = 10)
x <- today - tm
y <- rnorm(length(x))
p <- plot_ly(x = ~x, y = ~y, mode = 'lines', text = paste(tm, "days from today"))

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
chart_link = api_create(p, filename="timeseries/1")
chart_link


library(plotly)
now_ct <- as.POSIXct(temp2$Time)
tm <- seq(0, 600, by = 10)
x <- now_ct - tm
y <- rnorm(length(x))

p <- plot_ly(x =  as.POSIXct(temp2$Time), y = temp2$Value, mode = 'lines', split = temp2$Name)

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
chart_link = api_create(p, filename="timeseries/3")
chart_link
