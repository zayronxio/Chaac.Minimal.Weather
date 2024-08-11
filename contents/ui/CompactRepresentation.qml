import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls 2.15
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.plasma5support as Plasma5Support
import "components" as Components

Item {
    id: iconAndTem

    Layout.minimumWidth: widthReal
    Layout.minimumHeight: heightReal

    readonly property bool isVertical: Plasmoid.formFactor === PlasmaCore.Types.Vertical
    property string undefanchors: activeweathershottext ? undefined : parent.verticalCenter
    property bool textweather: Plasmoid.configuration.textweather
    property bool activeweathershottext: heightH > 34
    property int fonssizes: Plasmoid.configuration.sizeFontConfig
    property int heightH: root.height
    property var widthWidget: activeweathershottext ? temOfCo.implicitWidth : temOfCo.implicitWidth + wrapper_weathertext.width
    property var widthReal: isVertical ? root.width : initial.implicitWidth
    property var hVerti: wrapper_vertical.implicitHeight
    property var heightReal: isVertical ? hVerti : root.height

    Components.WeatherData {
        id: weatherData
    }
    MouseArea {
        id: compactMouseArea
        anchors.fill: parent

        hoverEnabled: true

        onClicked: root.expanded = !root.expanded
    }
    RowLayout {
        id: initial
        width: icon.width + columntemandweathertext.width + icon.width * 0.3
        height: parent.height
        spacing: icon.width / 5
        visible: !isVertical
        Kirigami.Icon {
            id: icon
            width: root.height < 17 ? 16 : root.height < 24 ? 22 : 24
            height: width
            source: weatherData.iconWeatherCurrent
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            roundToIconSize: false
        }
        Column {
            id: columntemandweathertext
            width: widthWidget
            height: temOfCo.implicitHeight
            anchors.verticalCenter: parent.verticalCenter
            Row {
                id: temOfCo
                width: textGrados.implicitWidth + subtextGrados.implicitWidth
                height: textGrados.implicitHeight
                anchors.verticalCenter: undefanchors

                Label {
                    id: textGrados
                    height: parent.height
                    width: parent.width - subtextGrados.implicitWidth
                    text: weatherData.temperaturaActual
                    font.bold: boldfonts
                    font.pixelSize: fonssizes
                    color: PlasmaCore.Theme.textColor
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
                Label {
                    id: subtextGrados
                    height: parent.height
                    width: parent.width - textGrados.implicitWidth
                    text: (root.temperatureUnit === "0") ? " °C " : " °F "
                    horizontalAlignment: Text.AlignLeft
                    font.bold: boldfonts
                    font.pixelSize: fonssizes
                    color: PlasmaCore.Theme.textColor
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Item {
                id: wrapper_weathertext
                height: shortweathertext.implicitHeight
                width: shortweathertext.implicitWidth
                visible: activeweathershottext & textweather
                Label {
                    id: shortweathertext
                    text: weatherData.weatherShottext
                    font.pixelSize: fonssizes
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
    ColumnLayout {
        id: wrapper_vertical
        width: root.width
        height: icon_vertical.height +  textGrados_vertical.implicitHeight
        spacing: 2
        visible: isVertical
        Kirigami.Icon {
            id: icon_vertical
            width: root.width < 17 ? 16 : root.width < 24 ? 22 : 24
            height: root.width < 17 ? 16 : root.width < 24 ? 22 : 24
            source: weatherData.iconWeatherCurrent
            anchors.left: parent.left
            anchors.right: parent.right
            roundToIconSize: false
        }
        Row {
            id: temOfCo_vertical
            width: textGrados_vertical.implicitWidth + subtextGrados_vertical.implicitWidth
            height: textGrados_vertical.implicitHeight
            Layout.alignment: Qt.AlignHCenter

            Label {
                id: textGrados_vertical
                height: parent.height
                text: weatherData.temperaturaActual
                font.bold: boldfonts
                font.pixelSize: fonssizes
                color: PlasmaCore.Theme.textColor
                horizontalAlignment: Text.AlignHCenter
            }
            Label {
                id: subtextGrados_vertical
                height: parent.height
                text: (root.temperatureUnit === "0") ? " °C" : " °F"
                font.bold: boldfonts
                font.pixelSize: fonssizes
                color: PlasmaCore.Theme.textColor
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

}



