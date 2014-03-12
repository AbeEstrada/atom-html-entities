{WorkspaceView} = require 'atom'

describe 'HTML Entities Package', ->
  [editor, editorView] = []

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.workspace = atom.workspaceView.model
    atom.workspaceView.openSync()

    editorView = atom.workspaceView.getActiveView()
    {editor} = editorView

    waitsForPromise ->
      atom.packages.activatePackage 'html-entities'

  describe 'html encode', ->
    it 'encodes html entities', ->
      editor.setText '<html>'
      editorView.trigger 'html-entities:encode'
      expect(editor.getText()).toBe '&lt;html&gt;'

  describe 'html decode', ->
    it 'decodes html entities', ->
      editor.setText '&amp;&aacute;&eacute;&iacute;&gt;'
      editorView.trigger 'html-entities:decode'
      expect(editor.getText()).toBe '&áéí>'
