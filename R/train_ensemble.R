#' Train an ensemble learner for semi-supervised text scoring
#'
#' This function takes in a corpus of text documents or a set of computed text features, along with a sample
#' of human-coded outcome values and trains an ensemble of machine learning models to predict the outcome as a
#' function of machine measures of text.
#'
#' @param x a \code{data.frame} or matrix of numeric text features.
#' @param y a vector of human-coded scores for the outcome of interest.
#' @param z optional indicator for treatment assignment. If specified, separate ensembles will
#' be trained for each treatment group;
#' @param n.tune an integer denoting the amount of granularity in the tuning parameter grid.
#' By default, this argument is the number of levels for each tuning parameters that should be generated by \link{train}.
#' @param cvf number of folds for cross validation
#' @param bounds a vector (y1, y2) specifying the lower and upper limits for prediction
#' @param ... additional arguments passed to \link{trainControl}.
#' @param return.all should all component models be returned? If `FALSE`, returns only the fitted ensemble(s).
#' @return a fitted model object
#' @export

train_ensemble <- function(x, y, z=NULL, n.tune=3, cvf=5,
                   bounds=NULL, ..., return.all=TRUE){

  tmp=list(x,y,n.tune)
  return(tmp)

}

train_ensemble = function( X, Z, Yobs, coded, n.tune = 3, bounds=NULL, preProc="zv",
                           model = "rf",seeds=NA,...
) {


  # Remove s_id and sampling weights from feature set for prediction
  population = data.frame(Z,Yobs,X)
  population$Yobs = as.numeric(population$Yobs)


  train = subset(population, coded==1)
  train0 = subset(train[train$Z==0,],select=-c(Z))
  train1 = subset(train[train$Z==1,],select=-c(Z))

  registerDoParallel(10)

  control0 = caret::trainControl(method="cv", number=5,
                                 savePredictions="final",
                                 predictionBounds = bounds,
                                 allowParallel=T,seeds=seeds)
  control1 = caret::trainControl(method="cv", number=5,
                                 savePredictions="final",
                                 predictionBounds = bounds,
                                 allowParallel=T,seeds=seeds)



  coded.X0 = as.matrix(subset(train0,select=-c(Yobs)))
  coded.X1 = as.matrix(subset(train1,select=-c(Yobs)))


  mod0 = caret::train(x=coded.X0, y=train0$Yobs,trControl=control0, preProcess=preProc,
                      tuneLength=n.tune, method=model,...)

  mod1 = caret::train(x=coded.X1, y=train1$Yobs,trControl=control1, preProcess=preProc,
                      tuneLength=n.tune, method=model,...)



  fit = list(mod0=mod0, mod1=mod1, coded=coded)


  return(fit)
}
