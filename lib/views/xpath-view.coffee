{SelectListView, $, $$} = require 'atom-space-pen-views'
XPathEngine = require '../xpath-engine'

module.exports =
    class XPathView extends SelectListView

        constructor: (editor) ->
            @engine = new XPathEngine(editor)
            super

        initialize: ->
            super
            @addClass('xml-tools')

        getFilterKey: ->
            return 'query'

        getEmptyMessage: ->
            return 'No Results'

        getLoading: ->
            return 'Enter an XPath query.'

        cancelled: ->
            @hide()

        toggle: ->
            if @panel?.isVisible()
                @cancel()
            else
                @show()

        show: ->
            console.log(this)
            @panel ?= atom.workspace.addModalPanel(item: this)
            console.log('hit')
            @panel.show()

            @setItems([])
            @focusFilterEditor()

        hide: ->
            @panel?.hide()

        populateList: ->
            query = @getFilterQuery()
            values = @engine.selectNodes(query)

            while @items.length > 0
                @items.pop()

            for value in values
                @items.push(value)

            super

        viewForItem: (item) ->
            html = '<li class="event">'

            if !item.isTerminalNode
                html += '<strong>[Concatenated]</strong> '

            html += '<span>' + item.value + '</span></li>'
            return html

        confirmed: (item) ->
            @cancel()
