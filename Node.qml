import QtQuick 2.3
import QtQuick.Controls 1.2

import "Editor.js" as Editor

Rectangle {
    id: root

    property int diameter: 30
    property int level: 0
    property bool isSet: false

    property alias value: valueTextInput.text
    property var leftNode: null
    property var rightNode: null

    color: isSet ? "orange" : "lightgrey"
    radius: diameter / 2
    width: diameter; height: diameter

    TextInput {
        id: valueTextInput
        anchors.fill: parent
        text: root.value
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        validator: IntValidator { bottom: -100; top: 100 }

        Keys.onReturnPressed: focus = false
        Keys.onEnterPressed: focus = false

        onFocusChanged: {
            if (focus)
                return;

            var isSet = !!valueTextInput.text;

            if (isSet === root.isSet)
                return;

            root.isSet = isSet;

            if (d.lastLevel)
                return;

            if (isSet) {
                var dx = Editor.instance.width / Math.pow(2, root.level + 2);
                var dy = diameter * 1.2;
                root.leftNode = Editor.createNode(root, -dx, dy);
                root.rightNode = Editor.createNode(root, dx, dy);
            } else {
                root.leftNode.destroy();
                root.rightNode.destroy();
                root.leftNode = null;
                root.rightNode = null;
            }
        }
    }

    QtObject {
        id: d
        property bool lastLevel: Editor.instance ? Editor.instance.maxLevel === root.level : false
    }
}
