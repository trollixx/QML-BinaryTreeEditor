.pragma library

// Editor component instance
var instance = null

function createNode(parent, x, y) {
    var component = Qt.createComponent("Node.qml");
    x = x || 0;
    y = y || 0;
    var node = component.createObject(parent, {"x": x, "y": y, "level": parent.level + 1});
    if (node === null)
        console.log("Error creating object");
    return node;
}

function getData(rootNode) {
    var queue = [];
    var data = "";

    if (!rootNode)
        return data;

    queue.push(rootNode);

    var currentLevelCounter = 1;
    var nextLevelCounter = 0;

    while (queue.length) {
        var node = queue.shift();

        if (node !== "#" && node.isSet) {
            data += node.value;
            if (node.level < instance.maxLevel) {
                queue.push(node.leftNode);
                queue.push(node.rightNode);
            } else {
                queue.push("#");
                queue.push("#");
            }
            nextLevelCounter += 2;
        } else {
            data += "#";
        }

        --currentLevelCounter;
        if (currentLevelCounter) {
            data += " ";
        } else {
            data += "\n";
            currentLevelCounter = nextLevelCounter;
            nextLevelCounter = 0;
        }
    }

    return data;
}
