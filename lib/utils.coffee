module.exports =
    class Utils

        constructor: ->
        @confirmFileType: (editor, expectedType) ->
            path = editor.getPath()
            buttonIndex = 0

            if path != undefined and path != null
                if !path.toLowerCase().endsWith(expectedType.toLowerCase())
                    buttonIndex = atom.confirm
                            message: 'Unexpected File Type'
                            detailedMessage: 'This document is not a "*.' + expectedType + '" file. Do you still want to proceed?'
                            buttons: ['Yes', 'No']

            return (buttonIndex == 0)
