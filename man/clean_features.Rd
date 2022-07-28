% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean_features.R
\name{clean_features}
\alias{clean_features}
\title{Clean and simplify feature set}
\usage{
clean_features(
  meta,
  ignore = NULL,
  uniqueCut = 2,
  freqCut = 99,
  verbose = FALSE
)
}
\arguments{
\item{meta}{The set of features}

\item{ignore}{List of column names to ignore when simplifying
(e.g., ID column and other columns that should be preserved).}

\item{uniqueCut}{Param for carat's nearZeroVar}

\item{freqCut}{Param for carat's nearZeroVar}

\item{verbose}{Print out progress to console.}

\item{cor}{Cutoff of how correlated features should be before dropping one.}

\item{remove.lc}{TRUE means remove colinear combinations of features.}
}
\value{
Updated meta with fewer columns of the preserved features.
}
\description{
Given set of generatred features, simplify set of features using
carat package.
}