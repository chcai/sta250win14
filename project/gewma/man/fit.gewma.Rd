\name{fit.gewma}
\alias{fit.gewma}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Fit a time series using gewma.
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Fit an univariate time series using generalized exponentially weighted moving averages as predictors in forward stepwise selection.
}
\usage{
fit.gewma(X, M = 20, r = seq(0, 1, length.out = 2 + 5), alpha = seq(0, pi, length.out = 2 + 5))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{X}{
A mean-0 univariate time series, as a numeric vector is fine.
%%     ~~Describe \code{X} here~~
}
  \item{M}{
Defines search 'grid' of theta's. theta = -1 + 1:(2*M)/M
%%     ~~Describe \code{M} here~~
}
  \item{r}{
Defines search 'grid' of radii. Should be a sequence from 0 to 1. 0 and 1 will be removed internally.
%%     ~~Describe \code{r} here~~
}
  \item{alpha}{
Defines search 'grid' of alpha's. Should be a sequence from 0 to pi. 0 and pi will be removed internally.
%%     ~~Describe \code{alpha} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
The predictors are selected using forward stepwise selection with BIC.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
\item{fit}{The fitted model from foward stepwise selection.}
\item{...}{Should be of no interest to the user; are returned to make using predict.gewma more user friendly.}
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
\code{\link{predict.gewma}}
}
\examples{
%##---- Should be DIRECTLY executable !! ----
%##-- ==>  Define data, use random,
%##--	or do  help(data=index)  for the standard data sets.

%## The function is currently defined as
## Please see help page for predict.gewma.
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
\keyword{time}
\keyword{series}
