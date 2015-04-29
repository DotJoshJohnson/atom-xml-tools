REGX_XML_TAG_OPEN = new RegExp('<(?!!)[^/>]+/?>')
REGX_XML_TAG_CLOSE = new RegExp('<\s*/\s*[^>]+>')
REGX_XML_TAG_COMPLETE = new RegExp('<\s*\s*[^>]+>.*<\s*/\s*[^>]+>|<[^>]+/>')
REGX_XML_ISPACE = new RegExp('(?:>)[\r\n\t ]*(?:<)', 'g')

module.exports =
    class XmlFormatter
        constructor: ->

        unformat: (xmlString) ->
            xmlString = xmlString.replace(REGX_XML_ISPACE, '><')
            return xmlString

        format: (xmlString) ->
            tablength = atom.config.get('editor.tabLength')

            xmlString = @unformat(xmlString)
            xmlString = xmlString.replace(/></g, '>\r\n<')

            level = 0
            formattedXml = ''

            for element in xmlString.split('\r\n')
                if element.match(REGX_XML_TAG_COMPLETE)
                    formattedXml += ' '.repeat(tablength).repeat(level) + element + '\r\n'

                else if element.match(REGX_XML_TAG_OPEN)
                    formattedXml += ' '.repeat(tablength).repeat(level) + element + '\r\n'
                    level++

                else if element.match(REGX_XML_TAG_CLOSE)
                    level--
                    formattedXml += ' '.repeat(tablength).repeat(level) + element + '\r\n'

                else
                    formattedXml += ' '.repeat(tablength).repeat(level) + element + '\r\n'

            return formattedXml
