describe 'HTML Entities Package', ->
  [editor, workspaceElement] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)

    waitsForPromise ->
      atom.packages.activatePackage 'html-entities'

    waitsForPromise ->
        atom.workspace.open()

    runs ->
      editor = atom.workspace.getActiveTextEditor()

  describe 'html encode', ->
    beforeEach ->
      editor.setText '<html>'
      atom.commands.dispatch workspaceElement, 'html-entities:encode'

    it 'encodes html entities', ->
      expect(editor.getText()).toBe '&lt;html&gt;'

  describe 'html decode', ->
    beforeEach ->
      editor.setText '&amp;áéí&gt;'
      atom.commands.dispatch workspaceElement, 'html-entities:decode'

    it 'decodes html entities', ->
      expect(editor.getText()).toBe '&áéí>'
