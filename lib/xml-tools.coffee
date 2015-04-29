REGX_XML_TAG_OPEN = new RegExp('<(?!!)[^/>]+/?>')
REGX_XML_TAG_CLOSE = new RegExp('<\s*/\s*[^>]+>')
REGX_XML_TAG_COMPLETE = new RegExp('<\s*\s*[^>]+>.*<\s*/\s*[^>]+>|<[^>]+/>')
REGX_XML_ISPACE = new RegExp('(?:>)[\r\n\t ]*(?:<)', 'g')

{CompositeDisposable} = require 'atom'
XmlFormatter = require './xml-formatter'
Utils = require './utils'

module.exports = XmlTools =
    subscriptions: null
    xmlFormatter: null

    activate: (state) ->
        # set up required services and utilities
        @xmlFormatter = new XmlFormatter

        # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
        @subscriptions = new CompositeDisposable

        # Register command that toggles this view
        @subscriptions.add atom.commands.add 'atom-workspace', 'xml-tools:unformat': => @unformat()
        @subscriptions.add atom.commands.add 'atom-workspace', 'xml-tools:format': => @format()

    deactivate: ->
        @subscriptions.dispose()

    serialize: ->
        ''

    unformat: ->
        if editor = atom.workspace.getActiveTextEditor()
            if Utils.confirmFileType(editor, 'xml')
                text = editor.getText()
                text = @xmlFormatter.unformat(text)
                editor.setText(text)


    format: ->
        if editor = atom.workspace.getActiveTextEditor()
            if Utils.confirmFileType(editor, 'xml')
                text = editor.getText()
                text = @xmlFormatter.format(text)
                editor.setText(text)
