#' This function gets your new R-package up and running. 
#' You only need to work out some clever code.
#'
#' @param wd Worikng directory (where the package should be created).
#' @param pname Package name.
#' @param scripts_dir Directory with scripts to be packaged.
#' @param scripts Names of scripts to be packaged.
#' @param install_after Set to TRUE if the package should be installed after creation.
#' @export
#' @examples
#' create_package(wd, pname, install=T, scripts_dir, script_name)
#' update_package(wd, pname, install=T)

create_package <- function(wd='', pname='', scripts_dir='', scripts ='', install_after=FALSE,
                           replace=TRUE){
  
  if (length(wd)==0){
    wd <- getwd()
    cat('The directory parameter \'wd\' was specified as empty. 
        The package repository will be created in the current directory.')
  }  
  
  if (length(pname)==0){
    pname <- 'mypackage'
    cat('The package name parameter \'pname\' was specified as empty. 
        The package will be called \'mypackage\'.')
  }
  
  if (length(scripts_dir)==0){
    cat('The package name parameter \'scripts_dir\' was specified as empty.')
    return(-1)
  }
  
  if (length(scripts)==0){
    cat('The package name parameter \'scripts_dir\' was specified as empty.')
    return(-1)
  }
  
  setwd(wd)
  
  #  Check if repository with this name already exists
  if(file.exists(pname)){
    if (replace)
      print('Package with this name already exists in repository and will be replaced.')
    else {
      print('Package with this name already exists in repository.')
      return(-1)
    }
  }
  
  devtools::create(pname)
  print('Package repository created.')
  
  setwd(paste("./", pname,"/R", sep=''))
  
  # write dummy function to an R-file
  script_name <- paste(pname,'_functions.R')
  
  # identify the folders
  new_folder <- getwd()
  
  # copy the files to the new folder
  file.copy(paste(scripts_dir, scripts, sep='/'), new_folder)
  print('R-scripts created.')
  
  devtools::document()
  print('Documentation created.')
  
  if (install_after){
    setwd(wd)
    devtools::install(pname)
    print(paste('Package ', pname, ' installed.', sep=''))
  }
}

#' This function updates a package.
#'
#' @param wd Worikng directory (where the package repository is located).
#' @param pname Package name.
#' @export
#' @examples
#' update_package(wd, pname, install=T)
update_package <- function(wd='', pname='', install_after=FALSE){
  setwd(wd)
  setwd(paste("./", pname,"/R", sep=''))
  devtools::document()
}