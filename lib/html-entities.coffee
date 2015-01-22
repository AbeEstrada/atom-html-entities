entities = null

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', 'html-entities:encode', ->
      entitiesCoderDecoder('encode')

    atom.commands.add 'atom-workspace', 'html-entities:decode', ->
      entitiesCoderDecoder('decode')

entitiesCoderDecoder = (action) ->
  editor = atom.workspace.getActiveTextEditor()
  return unless editor?

  entities ?= require 'entities'

  selectedText = editor.getSelectedText()
  if selectedText and action is 'decode'
    editor.insertText(entities.decodeXML(selectedText))

  else if selectedText
    editor.insertText(entities.encodeXML(selectedText))

  else if action is 'decode'
    editor.setText(entities.decodeXML(editor.getText()))

  else
    editor.setText(entities.encodeXML(editor.getText()))
