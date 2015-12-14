function open_in_newt
  set e (echo (commandline) "&")
  eval $e
  exec echo
end
