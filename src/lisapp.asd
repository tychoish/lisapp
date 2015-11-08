;;;; lisapp.asd

(asdf:defsystem #:lisapp
  :description "A 'hello world' type app to demonstrate a generic makefile."
  :author "sam (tycho) kleinman <sam@tychoish.com>"
  :license "Apache 2.0"
  :serial t
  :components ((:file "package")
               (:file "lisapp")))
