;; I'm going to try to define a skelton
;; the second item in this list is the command name
;; the first string is the documentation string
(define-skeleton if-statement
  "inserts the if statement"
  "insert the if conditional "
  > "if ("str")" \n
  > "{" \n
  _ \n
  "}" >)

(define-skeleton elseif-statement
  "inserts an elseif-statement"
  "insert the elseif conditional "
  > "elseif (" str ")" \n
  > "{" \n
  _ \n
  "}" >)

(define-skeleton else-statement
  "inserts an else statement"
  "press enter"
  > "else" \n
  > "{" \n
  _ \n
  "}" > )

;; let's make a skeleton to ease in making printf statements
(define-skeleton ptr-statement
  "inserts a print statement for the user"
  "insert the print string"
  > "printf( " _ " ); ")

;; let's make it easy to make while statements
(define-skeleton while-statement
  "make while statements"
  "press enter"
  > "while ("str")" \n
  > "{" \n
  > " _ "
  "}" > )

(define-skeleton class-element
  "makes a class element"
  "class=\""
  "class=\"" str "\"" )

(define-skeleton div-element
  "make a div element"
  "press enter"
  > "<div>" \n
  _ \n
 "</div>" >)

(define-skeleton p-element
  "make a p element"
  "press enter"
  > "<p>" \n
  _ \n
  "</p>" > )

(define-skeleton a-element
  "makes an a element"
  "enter a url: "
  "<a href=\"" > str "\"></a>")

(define-skeleton h1-element
  "makes a h1 element"
  "press enter"
  "<h1>" > str "<h/>" )

(define-skeleton h1-element
  "makes a h1 element"
  "press enter"
  "<h1>" > str "</h1>" )

(define-skeleton h2-element
  "makes a h2 element"
  "press enter"
  "<h2>" > str "</h2>" )

(define-skeleton h3-element
  "makes a h3 element"
  "press enter"
  "<h3>" > str "</h3>" )

(define-skeleton h4-element
  "makes a h4 element"
  "press enter"
  "<h4>" > str "</h4>" )

(define-skeleton h5-element
  "makes a h5 element"
  "press enter"
  "<h5>" > str "</h5>" )

(define-skeleton h6-element
  "makes a h6 element"
  "press enter"
  "<h6>" > str "</h6>" )

(define-skeleton h7-element
  "makes a h7 element"
  "press enter"
  "<h7>" > str "</h7>" )

(define-skeleton h8-element
  "makes a h8 element"
  "press enter"
  "<h8>" > str "</h8>" )

(define-skeleton html
  "makes a html element"
  "press enter"
  "<!DOCTYPE html>" > \n
  _
  "</html>" > )

(define-skeleton meta-element
  "makes a meta element"
  "press enter"
  "<meta>" > \n
  _
  "</meta>" > )

(define-skeleton title-element
  "makes a title-element"
  "press enter"
  "<title>" > \n
  _
  "</title>" > )

(define-skeleton body-element
  "make a body element"
  "press enter"
  "<body>" > \n
  _
  "</body>" > )

(define-skeleton span-element
  "make a span element"
  "press enter"
  "<span>" > str "</span>" )

(define-skeleton br-element
  "make a br element"
  "press enter"
  "<br/>" > )

(define-skeleton script-element
  "make a script element"
  "press enter"
  "<script>" > \n
  _ \n
  "</script>" > \n )
