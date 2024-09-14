;; Move cursor to a capture ("@foo") to highlight matches in the source buffer.
;; Completion for grammar nodes is available (:help compl-omni)


(call_expression
  function: (identifier) @function_name
  arguments: (argument_list (_) @parameter.inner)
)

(function_declaration
  name: (identifier)
  parameters: (parameter_list (_) @parameter.inner)
)

(call_expression
  function: (selector_expression 
              field: (field_identifier) @method_name
              )
  arguments: (argument_list (_) @parameter.inner)
)
