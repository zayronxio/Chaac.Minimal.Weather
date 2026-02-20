import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami
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

    QtObject {
        id: fontColourModeValue
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
    property alias cfg_fontColourMode: fontColourModeValue.value
    property alias cfg_fontColour: fontColourInput.text

    Kirigami.FormLayout {
        width: parent.width

        ComboBox {
            textRole: "text"
            valueRole: "value"
            id: positionComboBox
            Kirigami.FormData.label: i18n("Temperature Unit:")
            model: [
                {text: i18n("Celsius (°C)"), value: 0},
                {text: i18n("Fahrenheit (°F)"), value: 1},
            ]
            onActivated: unidWeatherValue.value = currentValue
            Component.onCompleted: currentIndex = indexOfValue(unidWeatherValue.value)
        }
        CheckBox {
            id: textweather
            Kirigami.FormData.label: i18n('weather conditions text on panel:')
        }

        CheckBox {
            id: autamateCoorde
            Kirigami.FormData.label: i18n('Use IP location')
        }
        TextField {
            id: latitude
            visible: !autamateCoorde.checked
            Kirigami.FormData.label: i18n("Latitude:")
            width: 200
        }
        TextField {
            id: longitude
            visible: !autamateCoorde.checked
            Kirigami.FormData.label: i18n("Longitude:")
            width: 200
        }
        CheckBox {
            id: boldfont
            Kirigami.FormData.label: i18n('Bold font:')
        }
        ComboBox {
            textRole: "text"
            valueRole: "value"
            Kirigami.FormData.label: i18n('Font Size:')
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
        ComboBox {
            textRole: "text"
            valueRole: "value"
            id: fontColourModeBox
            Kirigami.FormData.label: i18n("Font Colour:")
            model: [
                {text: i18n("UI Theme"), value: 0},
                {text: i18n("Custom"), value: 1},
            ]
            onActivated: fontColourModeValue.value = currentValue
            Component.onCompleted: currentIndex = indexOfValue(fontColourModeValue.value)
        }
        TextField {
            id: fontColourInput
            visible: fontColourModeBox.currentValue === 1
            Kirigami.FormData.label: i18n("Colour (HTML):")
            placeholderText: "#ffffff"
            width: 200
        }
    }

}
