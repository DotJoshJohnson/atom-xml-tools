XPathEngineResult = require './xpath-engine-result'

module.exports =
    class XPathEngine
        constructor: (@editor) ->
            @parser = new DOMParser

        selectNodes: (query) ->
            results = []
            if @editor and @editor.getText()
                text = @editor.getText()
                xdoc = @parser.parseFromString(text, 'text/xml')

                try
                    xpathResult = xdoc.evaluate(query, xdoc, null, 4, null)
                    while node = xpathResult.iterateNext()
                        result = new XPathEngineResult(query)
                        result.value = node.textContent
                        result.isTerminalNode = node.childNodes.length < 2

                        results.push(result)

                catch
                    # just...do nothing

            return results