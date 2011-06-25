Builder := Object clone

Builder currentIndentation := 0

Builder xmlNode := method(nodeName, children,
  openXmlNode := method(
    currentIndentation repeat(write(" "))
    writeln("<", nodeName, ">")
    currentIndentation = currentIndentation + 1
  )
  closeXmlNode := method(
    currentIndentation = currentIndentation - 1
    currentIndentation repeat(write(" "))
    writeln("</", nodeName, ">")
  )
  writeXmlText := method(
    (currentIndentation + 1) repeat(write(" "))
    writeln(content)
  )

  openXmlNode
  children foreach(
    arg,
    content := self doMessage(arg);
    if(content type == "Sequence", writeXmlText)
    )
  closeXmlNode
  )

Builder forward := method(
  xmlNode(call message name, call message arguments)
  )
