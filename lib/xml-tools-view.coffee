module.exports =
class XmlToolsView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('xml-tools')

    # Create message element
    label = document.createElement('span')
    label.textContent = 'XPath Query: '
    label.classList.add('label')
    @element.appendChild(label)

    query = document.createElement('input')
    query.name = 'query'
    @element.appendChild(query)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
