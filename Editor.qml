import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

import "Editor.js" as Editor

Item {
    id: root

    readonly property int maxLevel: 5

    function getData() {
        dataTextArea.text = Editor.getData(rootNode);
        dataWindow.show();
    }

    Component.onCompleted: Editor.instance = root

    MouseArea {
        anchors.fill: parent
        onClicked: root.forceActiveFocus()
    }

    Node {
        id: rootNode
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button {
        enabled: rootNode.isSet
        text: "Get Tree Data"
        onClicked: root.getData()
    }

    Window {
        id: dataWindow
        flags: Qt.Dialog
        modality: Qt.WindowModal
        width: 200; height: 200

        onVisibleChanged: {
            if (visible)
                dataTextArea.selectAll();
        }

        ColumnLayout {
            anchors {
                fill:parent
                margins: 5
            }

            TextArea {
                id: dataTextArea

                Layout.fillHeight: true
                Layout.fillWidth: true

                readOnly: true
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                Button {
                    text: qsTr("Copy")
                    onClicked: dataTextArea.copy()
                }
                Button {

                    text: qsTr("Close")
                    onClicked: dataWindow.close()
                }
            }


        }
    }
}
