Entities = null

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', 'html-entities:encode', ->
      entitiesCoderDecoder('encode')

    atom.commands.add 'atom-workspace', 'html-entities:decode', ->
      entitiesCoderDecoder('decode')

entitiesCoderDecoder = (action) ->
  editor = atom.workspace.getActiveTextEditor()
  return unless editor?

  Entities ?= require('html-entities').AllHtmlEntities
  entities = new Entities()

  selectedText = editor.getSelectedText()
  if selectedText and action is 'decode'
    editor.insertText(entities.decode(selectedText))

  else if selectedText
    editor.insertText(entities.encode(selectedText))

  else if action is 'decode'
    editor.setText(entities.decode(editor.getText()))

  else
    editor.setText(entities.encode(editor.getText()))
