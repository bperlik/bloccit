module ApplicationHelper
   # define the method, pass array of errors, code block as a proc
   def form_group_tag(errors, &block)
     css_class = 'form-group'
     css_class << ' has-error' if errors.any?
     # call the content _tag helper method, pass symbol, code block as a proc, and options hash
     # to create a symbol-specified HTML tag with block contents
     content_tag :div, capture(&block), class: css_class
   end
 end
