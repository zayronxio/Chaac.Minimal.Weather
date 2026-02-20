import QtQuick
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.core as PlasmaCore
import "components" as Components
import org.kde.kirigami as Kirigami

ColumnLayout {
    id: fullweather
    width: 350
    height: 290

    Components.WeatherData {
        id: weatherData
    }

    property int temperatureUnit: Plasmoid.configuration.temperatureUnit
    property int fontColourMode: Plasmoid.configuration.fontColourMode
    property string fontColour: Plasmoid.configuration.fontColour
    readonly property color effectiveFontColour: (fontColourMode === 1 && fontColour !== "") ? fontColour : PlasmaCore.Theme.textColor

    function sumarDia(a) {
        var currentDay = (new Date()).getDay()
        var day = ((currentDay + a) % 7 ) === 7 ? 0 : (currentDay + a) % 7
        return day
    }


    property string tomorrow: sumarDia(1)
    property string dayAftertomorrow: sumarDia(2)
    property string twoDaysAfterTomorrow: sumarDia(3)




    Item {
        id: currentWeather
        width: parent.width
        height: parent.height / 2
        Column {
            id: currentSection
            width: longweathertext.implicitWidth < temperatura.implicitWidth ? temperatura.implicitWidth : longweathertext.implicitWidth
            height: temperatura.implicitHeight + longweathertext.implicitHeight
            anchors.centerIn: currentWeather
            spacing: 0
            PlasmaComponents3.Label {
                id: temperatura
                text: temperatureUnit === 0 ? weatherData.temperaturaActual + "°C" : weatherData.temperaturaActual + "°F"
                width: parent.width
                font.pixelSize: currentWeather.height * 0.4
                color: effectiveFontColour
                horizontalAlignment: Text.AlignHCenter
            }
            PlasmaComponents3.Label {
                id: longweathertext
                text: weatherData.weatherLongtext
                width: parent.width
                font.pixelSize: currentWeather.height * .18
                color: effectiveFontColour
                horizontalAlignment: Text.AlignHCenter
            }
            PlasmaComponents3.Label {
                text: weatherData.textProbability + ": " + weatherData.probabilidadDeLLuvia + "%"
                width: parent.width
                font.pixelSize: currentWeather.height * .09
                color: effectiveFontColour
                horizontalAlignment: Text.AlignHCenter
            }
        }
        Component.onCompleted: {
            fullweather.height = currentSection.implicitHeight * 2
        }
    }

    Row {
        id: forecastSection
        width: fullweather.width
        height: fullweather.height / 2
        spacing: 0
        Repeater {
            model: 3
            delegate: Column {
                height: parent.height
                width: parent.width/3
                spacing: parent.height / 18

                PlasmaComponents3.Label {
                    width: parent.width
                    text: days[sumarDia((modelData + 1))]
                    color: effectiveFontColour
                    horizontalAlignment: Text.AlignHCenter
                }

                Kirigami.Icon {
                    source: weatherData.asingicon(weatherData.codeweatherTomorrow)
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Row {
                    width: max.width + min.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    PlasmaComponents3.Label {
                        id: max
                        text: modelData === 0 ? Math.round(weatherData.maxweatherTomorrow) + "°  " :  modelData === 1  ? Math.round(weatherData.maxweatherDayAftertomorrow) + "° " : modelData === 2 ? Math.round(weatherData.maxweatherTwoDaysAfterTomorrow) + "°  " : ""
                        color: effectiveFontColour
                        horizontalAlignment: Text.AlignHCenter
                    }
                    PlasmaComponents3.Label {
                        id: min
                        text:  modelData === 0 ? Math.round(weatherData.minweatherTomorrow) + "°" :  modelData === 1  ? Math.round(weatherData.minweatherDayAftertomorrow) + "°" : modelData === 2 ? Math.round(weatherData.minweatherTwoDaysAfterTomorrow) + "°" : ""
                        color: effectiveFontColour
                        opacity: .5
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }

        }
    }

    Timer {
        interval: 900000
        running: true
        repeat: true
        onTriggered: {
            tomorrow = sumarDia(1)
            dayAftertomorrow = sumarDia(2)
            twoDaysAfterTomorrow = sumarDia(3)
        }
    }
}
