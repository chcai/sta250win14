\name{predict.gewma}
\alias{predict.gewma}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Make predictions using gewma.
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Make predictions for an univariate time series using the fitted model from fit.gewma.
}
\usage{
\method{predict}{gewma}(object, n.pred = 10, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
The object returned by fit.gewma.
%%     ~~Describe \code{fit} here~~
}
  \item{n.pred}{
The number of predictions desired.
%%     ~~Describe \code{n.pred} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
Numeric vector of predictions.
}
\references{
%% ~put references to the literature/web site here ~
Burman and Shumway: Generalized Exponential Predictors for Time Series Forecasting (2006)
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{fit.gewma}}
}
\examples{
%##---- Should be DIRECTLY executable !! ----
%##-- ==>  Define data, use random,
%##--	or do  help(data=index)  for the standard data sets.

%## The function is currently defined as

X = arima.sim(list(order = c(1,0,1), ar = c(.5), ma = c(.5)), 100)
X = X - mean(X)

fit = fit.gewma(X)
predict(fit)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
\keyword{time}
\keyword{series}
