/*
 * Copyright 2021  Kevin Donnelly
 * Copyright 2022  Rafal (Raf) Liwoch
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http: //www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kirigami 2.4 as Kirigami
import "../../code/pws-api.js" as API
import "../lib"

Item {
    id: stationConfig

    //vars only for settings 
    property string currentLocale: "en-US";
    property int unitsChoice: 0;

    property alias cfg_stationID: stationID.text
    property alias cfg_refreshPeriod: refreshPeriod.value

    function printDebug(msg) {
        if (plasmoid.configuration.logConsole) {console.log("[debug] [ConfigStation.qml] " + msg)}
    }

    Kirigami.FormLayout {
        anchors.fill: parent

        Kirigami.Heading {
            text: i18n("Enter Station")
            level: 2
        }

        ClearableField {
            id: stationID
            placeholderText: "IFRAUN2"

            Kirigami.FormData.label: i18n("Weatherstation ID:")
        }

        Kirigami.Separator {}

        Kirigami.Heading {
            text: i18n("Get Nearest Station")
            level: 2
        }

        Kirigami.Heading {
            text: i18n("Uses WGS84 geocode coordinates")
            level: 5
        }

        NoApplyField {
            configKey: "longitude"
            placeholderText: "-83.905502"

            Kirigami.FormData.label: i18n("Longitude:")
        }

        NoApplyField {
            configKey: "latitude"
            placeholderText: "34.0602"

            Kirigami.FormData.label: i18n("Latitude:")
        }

        SpinBox {
            id: refreshPeriod

            from: 1
            editable: true

            validator: IntValidator {
                bottom: refreshPeriod.from
            }

            Kirigami.FormData.label: i18n("Refresh period (s):")
        }

        Button {
            text: i18n("Find Station")
            //todo
            onClicked: API.getNearestStation(plasmoid.configuration.latitude, plasmoid.configuration.longitude)
        }

        PlasmaComponents.Label {
            text: "Version 0.6.0"
        }
    }

}
