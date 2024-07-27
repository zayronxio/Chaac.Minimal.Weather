
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: configRoot

    QtObject {
        id: unidWeatherValue
        property var value
    }

    QtObject {
        id: fontsizeValue
        property var value
    }

    signal configurationChanged

    property alias cfg_temperatureUnit: unidWeatherValue.value
    property alias cfg_sizeFontConfig: fontsizeValue.value
    property alias cfg_latitudeC: latitude.text
    property alias cfg_longitudeC: longitude.text
    property alias cfg_useCoordinatesIp: autamateCoorde.checked
    property alias cfg_boldfonts: boldfont.checked
    property alias cfg_textweather: textweather.checked

    ColumnLayout {
        spacing: units.smallSpacing * 2


        RowLayout {
            CheckBox {
                id: boldfont
                text: i18n('bold font')
                Layout.columnSpan: 2
            }
        }
        RowLayout {
            CheckBox {
                id: textweather
                text: "Display weather conditions text on panel (only visible on horizontal panels wider than 44px"
                Layout.columnSpan: 2
            }
        }
        RowLayout{
            CheckBox {
                id: autamateCoorde
                text: i18n('use geographic coordinates established by IP address')
                Layout.columnSpan: 2
            }
        }
        ColumnLayout {
            Item{
                width: configRoot.width
                height: instructions.height*2.5
                Label {
                    id: instructions
                    visible: (autamateCoorde.checked === true) ? false : true
                    wrapMode: Text.WordWrap
                    width: parent.width
                    text:  i18n("To know your geographic coordinates, I recommend using the following website https://open-meteo.com/en/docs")
                }
            }
            RowLayout{
                visible: (autamateCoorde.checked === true) ? false : true
                Label {
                    text: i18n("latitude")
                }
                TextField {
                    id: latitude
                    width: 200
                }

            }
            RowLayout{
                visible: (autamateCoorde.checked === true) ? false : true
                Label {
                    text: i18n("longitude")
                }
                TextField {
                    id: longitude
                    width: 200
                }

            }
        }
        ColumnLayout {
            spacing: units.smallSpacing * 2

            Label {
                text: i18n("temperature unit:")
            }
            ComboBox {
                textRole: "text"
                valueRole: "value"
                id: positionComboBox
                model: [
                    {text: i18n("Celsius (°C)"), value: 0},
                    {text: i18n("Fahrenheit (°F)"), value: 1},
                ]
                onActivated: unidWeatherValue.value = currentValue
                Component.onCompleted: currentIndex = indexOfValue(unidWeatherValue.value)
            }

        }

        ColumnLayout {
            spacing: units.smallSpacing * 2

            Label {
                text: i18n("Font Size")
            }
            ComboBox {
                textRole: "text"
                valueRole: "value"
                id: valueForSizeFont
                model: [
                    {text: i18n("8"), value: 8},
                    {text: i18n("9"), value: 9},
                    {text: i18n("10"), value: 10},
                    {text: i18n("11"), value: 11},
                    {text: i18n("12"), value: 12},
                    {text: i18n("13"), value: 13},
                    {text: i18n("14"), value: 14},
                    {text: i18n("15"), value: 15},
                    {text: i18n("16"), value: 16},
                    {text: i18n("17"), value: 17},
                    {text: i18n("18"), value: 18},

                ]
                onActivated: fontsizeValue.value = currentValue
                Component.onCompleted: currentIndex = indexOfValue(fontsizeValue.value)
            }

        }
    }

}
