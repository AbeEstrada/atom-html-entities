{WorkspaceView} = require 'atom'

describe 'HTML Entities Package', ->
  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.workspace = atom.workspaceView.model

    waitsForPromise ->
      atom.packages.activatePackage 'html-entities'

  describe 'html encode', ->
    it 'encodes html entities', ->
      atom.workspaceView.openSync()
      editorView = atom.workspaceView.getActiveView()
      {editor} = editorView

      editor.setText '<html>'
      editorView.trigger 'html-entities:encode'
      expect(editor.getText()).toBe '&lt;html&gt;'

  describe 'html decode', ->
    it 'decodes html entities', ->
      atom.workspaceView.openSync()
      editorView = atom.workspaceView.getActiveView()
      {editor} = editorView

      editor.setText '&amp;&aacute;&eacute;&iacute;&gt;'
      editorView.trigger 'html-entities:decode'
      expect(editor.getText()).toBe '&áéí>'
