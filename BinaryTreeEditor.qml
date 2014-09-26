import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.2

ApplicationWindow {
    title: qsTr("Binary Tree Editor")
    width: 1020
    height: 520

    Rectangle {
        anchors.fill: parent
        Editor {
            anchors {
                fill: parent
                margins: 10
            }
        }
    }
}
