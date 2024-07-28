import QtQuick 2.4
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components 3.0 as PlasmaComponents3
import "components" as Components
import org.kde.kirigami as Kirigami
import Qt5Compat.GraphicalEffects

ColumnLayout {
    id: fullweather
    width: 350
    height: 290

    Components.WeatherData {
        id: weatherData
    }

    property int temperatureUnit: Plasmoid.configuration.temperatureUnit
    function sumarDia(a) {
        var fechaActual = new Date();
        fechaActual.setDate(fechaActual.getDate() + a);
        var fechaFormateada = Qt.formatDateTime(fechaActual, "dddd");
        console.log("Fecha con un día añadido:", fechaFormateada);
        return fechaFormateada
    }

    property string tomorrow: sumarDia(1)
    property string dayAftertomorrow: sumarDia(2)
    property string twoDaysAfterTomorrow: sumarDia(3)

    Item {
        id: currentWeather
        width: parent.width
        height: parent.height / 2
        Column {
            width: longweathertext.implicitWidth < temperatura.implicitWidth ? temperatura.implicitWidth : longweathertext.implicitWidth
            height: temperatura.implicitHeight + longweathertext.implicitHeight
            anchors.centerIn: currentWeather
            spacing: 0
            PlasmaComponents3.Label {
                id: temperatura
                text: temperatureUnit === 0 ? Math.round(weatherData.temperaturaActual) + "°C" : Math.round(weatherData.temperaturaActual) + "°F"
                width: parent.width
                font.pixelSize: currentWeather.height * 0.4
                horizontalAlignment: Text.AlignHCenter
            }
            PlasmaComponents3.Label {
                id: longweathertext
                text: weatherData.weatherLongtext
                width: parent.width
                font.pixelSize: currentWeather.height * .18
                horizontalAlignment: Text.AlignHCenter
            }
            PlasmaComponents3.Label {
                text: weatherData.textProbability + ": " + weatherData.probabilidadDeLLuvia + "%"
                width: parent.width
                font.pixelSize: currentWeather.height * .09
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Row {
        id: forecastSection
        width: fullweather.width
        height: fullweather.height / 2
        spacing: 0

        Column {
            id: zero
            width: (fullweather.width / 5)
            height: forecastSection.height
        }

        Column {
            id: one
            width: zero.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: fullweather.height / 18
            PlasmaComponents3.Label {
                width: parent.width
                text: tomorrow.substring(0, 3)
                horizontalAlignment: Text.AlignHCenter
            }
            Kirigami.Icon {
                source: weatherData.asingicon(weatherData.codeweatherTomorrow)
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row {
                width: oneMax.width + oneMin.width
                anchors.horizontalCenter: parent.horizontalCenter
                PlasmaComponents3.Label {
                    id: oneMax
                    text: Math.round(weatherData.maxweatherTomorrow) + "°  "
                    horizontalAlignment: Text.AlignHCenter
                }
                PlasmaComponents3.Label {
                    id: oneMin
                    text: Math.round(weatherData.minweatherTomorrow) + "°"
                    opacity: .5
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Column {
            id: two
            width: zero.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: fullweather.height / 18
            PlasmaComponents3.Label {
                width: parent.width
                text: dayAftertomorrow.substring(0, 3)
                horizontalAlignment: Text.AlignHCenter
            }
            Kirigami.Icon {
                source: weatherData.asingicon(weatherData.codeweatherDayAftertomorrow)
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row {
                width: twoMax.width + twoMin.width
                anchors.horizontalCenter: parent.horizontalCenter
                PlasmaComponents3.Label {
                    id: twoMax
                    text: Math.round(weatherData.maxweatherDayAftertomorrow) + "° "
                    horizontalAlignment: Text.AlignHCenter
                }
                PlasmaComponents3.Label {
                    id: twoMin
                    text: Math.round(weatherData.minweatherDayAftertomorrow) + "°"
                    opacity: .5
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Column {
            id: three
            width: zero.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: fullweather.height / 18
            PlasmaComponents3.Label {
                width: parent.width
                text: twoDaysAfterTomorrow.substring(0, 3)
                horizontalAlignment: Text.AlignHCenter
            }
            Kirigami.Icon {
                source: weatherData.asingicon(weatherData.codeweatherTwoDaysAfterTomorrow)
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row {
                width: threeMax.width + threeMin.width
                anchors.horizontalCenter: parent.horizontalCenter
                PlasmaComponents3.Label {
                    id: threeMax
                    text: Math.round(weatherData.maxweatherTwoDaysAfterTomorrow) + "°  "
                    horizontalAlignment: Text.AlignHCenter
                }
                PlasmaComponents3.Label {
                    id: threeMin
                    text: Math.round(weatherData.minweatherTwoDaysAfterTomorrow) + "°"
                    opacity: .5
                    horizontalAlignment: Text.AlignHCenter
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
