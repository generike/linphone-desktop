import QtQuick 2.7
import QtQuick.Window 2.2

import Common 1.0

import App.Styles 1.0

// =============================================================================

Window {
  color: SplashScreenStyle.color
  flags: Qt.SplashScreen
  modality: Qt.ApplicationModal
  visible: image.status === Image.Ready

  x: (Screen.width - image.width) / 2
  y: (Screen.height - image.height) / 2

  height: image.paintedHeight
  width: image.paintedWidth

  Image {
    id: image

    anchors.centerIn: parent

    height: SplashScreenStyle.height
    width: SplashScreenStyle.width

    fillMode: Image.PreserveAspectFit
    mipmap: true

    source: SplashScreenStyle.image

    BusyIndicator {
      height: SplashScreenStyle.busyIndicator.height
      width: SplashScreenStyle.busyIndicator.width

      anchors {
        bottom: parent.bottom
        bottomMargin: SplashScreenStyle.busyIndicator.bottomMargin

        horizontalCenter: parent.horizontalCenter
      }
    }
  }
}