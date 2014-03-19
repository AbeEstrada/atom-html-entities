entities = null

module.exports =
  activate: (state) ->
    atom.workspaceView.command 'html-entities:encode', ->
      entitiesCoderDecoder('encode')

    atom.workspaceView.command 'html-entities:decode', ->
      entitiesCoderDecoder('decode')

entitiesCoderDecoder = (action) ->
  editor = atom.workspace.getActiveEditor()
  return unless editor?

  entities ?= require 'entities'

  selectedText = editor.getSelectedText()
  if selectedText and action is 'decode'
    editor.insertText(entities.decode(selectedText, 2))

  else if selectedText
    editor.insertText(entities.encode(selectedText, 2))

  else if action is 'decode'
    editor.setText(entities.decode(editor.getText(), 2))

  else
    editor.setText(entities.encode(editor.getText(), 2))
