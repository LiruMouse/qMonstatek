import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
    id: view

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 16

        Item { Layout.fillHeight: true }

        // App title
        Label {
            text: "qMonstatek"
            font.pixelSize: 36
            font.bold: true
            color: Material.accent
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: "Desktop Companion for Monstatek M1"
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
            color: Material.hintTextColor
        }

        Label {
            text: "Version " + Qt.application.version
            font.pixelSize: 14
            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle {
            Layout.preferredWidth: 300
            Layout.preferredHeight: 1
            Layout.alignment: Qt.AlignHCenter
            color: Material.dividerColor
            Layout.topMargin: 16
            Layout.bottomMargin: 16
        }

        // Features list
        Label {
            text: "Features"
            font.bold: true
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        GridLayout {
            Layout.alignment: Qt.AlignHCenter
            columns: 2
            columnSpacing: 24
            rowSpacing: 8

            Label { text: "🖥  Screen Mirror"; font.pixelSize: 13 }
            Label { text: "Live display streaming + remote control"; font.pixelSize: 11; color: Material.hintTextColor }

            Label { text: "⬆  Firmware Update"; font.pixelSize: 13 }
            Label { text: "Update from GitHub or local file"; font.pixelSize: 11; color: Material.hintTextColor }

            Label { text: "📁  File Manager"; font.pixelSize: 13 }
            Label { text: "Browse, upload, download SD card files"; font.pixelSize: 11; color: Material.hintTextColor }

            Label { text: "🔄  Dual Boot"; font.pixelSize: 13 }
            Label { text: "Manage flash banks, swap, rollback"; font.pixelSize: 11; color: Material.hintTextColor }

            Label { text: "📡  ESP32 Update"; font.pixelSize: 13 }
            Label { text: "Flash ESP32-C6 coprocessor firmware"; font.pixelSize: 11; color: Material.hintTextColor }
        }

        Rectangle {
            Layout.preferredWidth: 300
            Layout.preferredHeight: 1
            Layout.alignment: Qt.AlignHCenter
            color: Material.dividerColor
            Layout.topMargin: 16
            Layout.bottomMargin: 16
        }

        // Check for Updates
        Label {
            text: "Updates"
            font.bold: true
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 8

            property string updateStatus: ""
            property string updateUrl: ""
            property string latestVersion: ""

            Button {
                id: checkBtn
                text: appUpdateChecker.checking ? "Checking..." : "Check for Updates"
                enabled: !appUpdateChecker.checking
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    parent.updateStatus = ""
                    parent.updateUrl = ""
                    parent.latestVersion = ""
                    var parts = Qt.application.version.split(".")
                    appUpdateChecker.checkForUpdates(
                        parseInt(parts[0]) || 0,
                        parseInt(parts[1]) || 0,
                        parseInt(parts[2]) || 0,
                        0, 0)
                }
            }

            Label {
                id: statusLabel
                visible: parent.updateStatus.length > 0
                text: parent.updateStatus
                font.pixelSize: 12
                color: parent.updateUrl.length > 0 ? "#4CAF50" : Material.hintTextColor
                Layout.alignment: Qt.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.maximumWidth: 400
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                visible: parent.updateUrl.length > 0
                text: "<a href=\"" + parent.updateUrl + "\" style=\"color:#2196F3;\">Download " + parent.latestVersion + "</a>"
                font.pixelSize: 12
                Layout.alignment: Qt.AlignHCenter
                onLinkActivated: function(link) { Qt.openUrlExternally(link) }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.NoButton
                }
            }

            Connections {
                target: appUpdateChecker
                function onReleaseFound(info) {
                    parent.updateStatus = "New version available: " + info.version
                    parent.updateUrl = info.htmlUrl
                    parent.latestVersion = info.version
                }
                function onNoUpdateAvailable(message) {
                    parent.updateStatus = "You're up to date (v" + Qt.application.version + ")"
                }
                function onCheckError(message) {
                    parent.updateStatus = "Error: " + message
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: 300
            Layout.preferredHeight: 1
            Layout.alignment: Qt.AlignHCenter
            color: Material.dividerColor
            Layout.topMargin: 16
            Layout.bottomMargin: 16
        }

        Label {
            text: "Open Source — github.com/bedge117/qMonstatek"
            font.pixelSize: 12
            color: Material.hintTextColor
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }
    }
}
