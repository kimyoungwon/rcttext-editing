% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract_taaco.R
\name{extract_taaco}
\alias{extract_taaco}
\title{Import and merge text features generated using TAACO}
\usage{
extract_taaco(
  file,
  meta = NULL,
  ID.meta = NULL,
  drop_para = FALSE,
  drop_sent = TRUE
)
}
\arguments{
\item{file}{Filename where TAACO results are stored}

\item{meta}{Optional \code{data.frame} with additional
document-level variables to include in output.}

\item{ID.meta}{If \code{meta} is specified, character vector with
name of variables used for merging.}

\item{drop_para}{Drop paragraph level measures of cohesion from
features (TRUE/FALSE).}

\item{drop_sent}{Drop adjacent overlap  between sentences
(TRUE/FALSE).}
}
\value{
Returns a \code{data.frame} of text features.
}
\description{
This method helps support feature extraction using TAACO.  You will
have to use the external TACCO program to generate these features;
these methods just help move back and forth from R to TACCO.
}
\details{
See \code{prep_external()} for generating text files that would be
ready for TAACO analysis. Call this on the corpus to make files
that can be read in and processed easily.

Once external processing is complete, \code{extract_taaco()} reads
output and log files produced by the TAACO program and returns a
\code{data.frame} that can be merged with other feature sets.

The "Filename" column in the read file should be the IDs (with a
'.txt' suffix that will be dropped).  The results can then be
merged with `meta`, if passed,
}
