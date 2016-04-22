import QtQuick 2.6
import QtQuick.Window 2.2
import QtLocation 5.3
import QtPositioning 5.2

Window {
    visible: true
        width: 480
        height: 720
//    width: Screen.width
//    height: Screen.height

        property double old : 19
        property double now

    Rectangle
    {
        anchors.fill: parent
        color: "#eee"

        Component.onCompleted:
        {
            circle.center = src.position.coordinate
            circle1.center = src.position.coordinate
            circle2.center = src.position.coordinate
            maps.center = src.position.coordinate
        }

        PositionSource
        {
            id: src
            active: true
            updateInterval: 1000
            onPositionChanged:
            {
                circle.center = position.coordinate
                circle1.center = position.coordinate
                circle2.center = position.coordinate
            }
        }

        Plugin
        {
            id: plugin
            name: "osm"
            PluginParameter { name: "osm.useragent"; value: "My great Qt OSM application" }
            PluginParameter { name: "osm.mapping.host"; value: "http://osm.tile.server.address/" }
            PluginParameter { name: "osm.mapping.copyright"; value: "All mine" }
            PluginParameter { name: "osm.routing.host"; value: "http://osrm.server.address/viaroute" }
            PluginParameter { name: "osm.geocoding.host"; value: "http://geocoding.server.address" }
            PluginParameter { name: "osm.places.host"; value: "http://geocoding.server.address" }
        }

        Map
        {
            id: maps
            anchors.fill: parent
            plugin: plugin
            gesture.enabled: true
            gesture.acceptedGestures: MapGestureArea.PinchGesture | MapGestureArea.PanGesture | MapGestureArea.FlickGesture
            gesture.flickDeceleration: 3000
            zoomLevel: 19

            onZoomLevelChanged:
            {

            }

            minimumZoomLevel: 1

            focus: true

            MapCircle {
                id: circle
                z: 2
                color: "#fff"
                radius: 8
                border.color: "#fff"
                center
                {
                    latitude: src.position.coordinate.latitude
                    longitude: src.position.coordinate.longitude
                }
            }

            MapCircle {
                id: circle2
                z: 3
                color: "#0084ff"
                radius: 4
                border.color: "#0084ff"
                center
                {
                    latitude: src.position.coordinate.latitude
                    longitude: src.position.coordinate.longitude
                }
            }

            MapCircle {
                id: circle1
                z: 1
                color: "#0084ff"
                border.color: "#0084ff"
                opacity: 0.25
                radius: 19
                center
                {
                    latitude: src.position.coordinate.latitude
                    longitude: src.position.coordinate.longitude
                }
            }
        }
    }
}
