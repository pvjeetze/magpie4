#' @title foodmodelstat
#' @description MAgPIE food model statistics with information about convergance and number of iterations
#' 
#' @export
#' 
#' @param gdx GDX file
#' @param file a file name the output should be written to using write.magpie
#' @return A MAgPIE object containing number of iterations and convergance information for each time step
#' @author Jan Philipp Dietrich
#' @examples
#' 
#'   \dontrun{
#'     x <- foodmodelstat(gdx)
#'   }
#'

foodmodelstat <- function(gdx, file=NULL) {
  
  .read <- function(gdx,name,par,limit) {
    x <- readGDX(gdx,par, format="first_found", react="silent")
    y <- readGDX(gdx,limit, format="first_found", react="silent") 
    if(!is.null(x)) {
      getNames(x) <- paste0(name," (limit = ",y,")")
      if(!is.null(y)) if(any(x>y-5)) warning(name," limit violated in food model!", call. = FALSE)
    }
    return(x)
  }
  
  conv <- .read(gdx,"convergence","p15_convergence_measure","s15_convergence")
  iter <- .read(gdx,"iterations","p15_iteration_counter","s15_maxiter")

  x <- mbind(conv,iter)
  out(x,file)
}