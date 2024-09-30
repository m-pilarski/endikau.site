#' rlist_c
#'
#' @param .x NULL
#' @param .fn_leaf_names NULL
#' @param .fn_leaf_wrap NULL
#' @param .fn_node_wrap NULL
#'
#' @return string
#' @export
#'
#' @examples
#' NULL
rlist_c <- function(
    .x, .fn_leaf_names=NULL, .fn_leaf_wrap=NULL, .fn_node_wrap=NULL
){
  
  if(is.null(.fn_leaf_names)){
    .fn_leaf_names=\(.x, .n){.x}
  }
  if(is.null(.fn_leaf_wrap)){
    .fn_leaf_wrap=\(.x){stringi::stri_c("<li>", .x, "</li>")}
  }
  if(is.null(.fn_node_wrap)){
    .fn_node_wrap=\(.x){stringi::stri_c("<ul>", .x, "</ul>")}
  }
  
  .x |>
    purrr::modify_tree(post=\(..x){
      ..x |>
        purrr::imap(\(...v, ...n){
          if(!vctrs::obj_is_list(...v)){...v <- .fn_leaf_names(...v, ...n)}
          return(...v)
        }) |>
        unname()
    }) |>
    purrr::modify_tree(
      leaf=.fn_leaf_wrap,
      post=\(..x){
        ..x |>
          purrr::list_c(ptype=character()) |>
          stringi::stri_c(collapse="") |>
          .fn_node_wrap()
      },
      is_node=vctrs::obj_is_list
    )
  
}

#' format_fa_list
#'
#' @param .x a named list
#'
#' @return a HTML string
#' @export
#'
#' @examples
#' FALSE
format_fa_list <- function(.x, .pad_left="1.75em"){
  htmltools::HTML(rlist_c(
    .x,
    .fn_leaf_names=\(.x, .n){
      stringi::stri_c("<span class='fa-li'><i class='", .n, "'></i></span>", .x)
    },
    .fn_node_wrap=\(.x){
      stringi::stri_c(
        "<ul class='fa-ul' style='margin-left: var(--fa-li-margin, ", 
        .pad_left, ");'>", .x, "</ul>"
      )
    }
  ))
}

#' format_nd_toc
#'
#' @param .x a named list
#' 
#' @return a HTML string
#' @export
#'
#' @examples
#' FALSE
format_nd_toc <- function(.x){
  list(
    tags$div(
      id="page-toc-container", 
      class="nd-toc z-3",
      tags$nav(
        id="page-toc",
        tags$strong(
          class="h6 my-2", 
          htmltools::HTML("In&shy;halts&shy;ver&shy;zeich&shy;nis")
        ),
        tags$hr(class="d-block my-2"),
        htmltools::HTML(rlist_c(
          .x=.x,
          .fn_leaf_names=\(.x, .n){
            stringi::stri_c("<a href='#", .n, "'>", .x, "</a>")
          }
        ))
      )
    ),
    tags$div(id="page-toc-spacer", class="d-none d-xl-block")
  )
}
