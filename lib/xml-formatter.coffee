REGX_XML_ISPACE = />[\r\n\s]*</g
REGX_XML_NSPACE = /></g
REGX_XML_ELEMENT_START = /<\w[\w\d]*[^>]*[^\/]>/
REGX_XML_ELEMENT_END = /<\s*\/\s*\w[\w\d]*>/

module.exports =
    class XmlFormatter
        constructor: ->

        unformat: (xmlString) ->
            unformattedXml = xmlString.replace(REGX_XML_ISPACE, '><')
            return unformattedXml

        format: (xmlString) ->
            br = atom.config.get('xml-tools.br') ? '\r\n'
            tab = ' '.repeat((atom.config.get('editor.tabLength') ? 4))
            level = 0

            unformattedXml = @unformat xmlString
            tokenizedXml = unformattedXml.replace REGX_XML_NSPACE, ">#{ br }<"
            formattedXml = ''

            for element in tokenizedXml.split br
                if element.trim() == ''
                    continue

                start = REGX_XML_ELEMENT_START.exec element

                if start == null
                    start = ['']

                end = REGX_XML_ELEMENT_END.exec element

                if end == null
                    end = ['']

                if element == start[0]
                    formattedXml += tab.repeat(level) + element + br
                    level++

                else if element == end[0]
                    level--
                    formattedXml += tab.repeat(level) + element + br

                else
                    formattedXml += tab.repeat(level) + element + br

            return formattedXml
