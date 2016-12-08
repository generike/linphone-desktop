import QtQuick 2.7

import Common 1.0
import Common.Styles 1.0

// ===================================================================
// A editable text that become the content of a box on focus.
// ===================================================================

Item {
  property alias color: textInput.color
  property alias font: textInput.font
  property alias readOnly: textInput.readOnly
  property alias text: textInput.text
  property int padding: TransparentTextInputStyle.padding

  signal editingFinished

  // -----------------------------------------------------------------

  onActiveFocusChanged: {
    if (activeFocus) {
      textInput.focus = true
    }
  }

  Rectangle {
    color: textInput.activeFocus && !textInput.readOnly
      ? TransparentTextInputStyle.backgroundColor
      : // No Style constant, see component name.
        // It's a `transparent` TextInput.
       'transparent'
    height: parent.height
    width: {
      var width = textInput.contentWidth + parent.padding * 2
      return width < parent.width ? width : parent.width
    }
  }

  TextInput {
    id: textInput

    anchors.centerIn: parent
    height: parent.height - parent.padding * 2
    width: parent.width - parent.padding * 2

    clip: true
    color: activeFocus && !readOnly
      ? TransparentTextInputStyle.textColor.focused
      : TransparentTextInputStyle.textColor.normal
    selectByMouse: true
    verticalAlignment: TextInput.AlignVCenter

    Keys.onEscapePressed: focus = false
    Keys.onReturnPressed: focus = false

    onEditingFinished: {
      cursorPosition = 0
      parent.editingFinished()
    }

    InvertedMouseArea {
      anchors.fill: parent
      enabled: textInput.activeFocus
      onPressed: textInput.focus = false
    }
  }
}
