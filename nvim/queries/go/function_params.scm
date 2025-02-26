;; Move cursor to a capture ("@foo") to highlight matches in the source buffer.
;; Completion for grammar nodes is available (:help compl-omni)


(call_expression
  function: (identifier) @function_name
  arguments: (argument_list (_) @parameter.inner)
) @method.outer

(call_expression
  function: (selector_expression 
              field: (field_identifier) @method_name
              )
  arguments: (argument_list (_) @parameter.inner)
  ) @method.outer

(function_declaration
  name: (identifier) @function_name
  parameters: (parameter_list (_) @parameter.inner)
) @function.outer

(method_declaration
  name: (field_identifier) @function_name
  parameters: (parameter_list
    (_) @parameter.inner
  )
) @function.outer
