module.exports =
    class XPathEngineResult

        constructor: (originalQuery) ->
            @query = originalQuery
            @value = ''
            @isTerminalNode = false