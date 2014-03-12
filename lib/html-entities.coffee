entities = require 'entities'

module.exports =
  activate: (state) ->
    atom.workspaceView.command 'html-entities:encode', ->
      entitiesCoderDecoder('encode')

    atom.workspaceView.command 'html-entities:decode', ->
      entitiesCoderDecoder('decode')

entitiesCoderDecoder = (action) ->
  editor = atom.workspace.getActiveEditor()
  return unless editor?

  selectedText = editor.getSelectedText()
  if selectedText
    if action is 'decode'
      editor.insertText(entities.decode(selectedText, 2))

    else
      editor.insertText(entities.encode(selectedText, 2))
  else
    text = editor.getText()
    if action is 'decode'
      editor.setText(entities.decode(text, 2))

    else
      editor.setText(entities.encode(text, 2))
