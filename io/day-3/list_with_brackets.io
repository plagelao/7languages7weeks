curlyBrackets := method(
  l := List clone
  call message arguments foreach(arg,
    l append(doMessage(arg))
    )
  l
)
