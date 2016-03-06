/********************************************************************
Copyright (C) 2015 Demitrius Belai <demitriusbelai@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************/
import QtQuick 2.0
import org.kde.kwin.decoration 0.1
import org.kde.kwin.decorations.plastik 1.0

Decoration {
    function readBorderSize() {
        switch (borderSize) {
        case DecorationOptions.BorderTiny:
            borders.setBorders(3);
            extendedBorders.setAllBorders(0);
            break;
        case DecorationOptions.BorderLarge:
            borders.setBorders(8);
            extendedBorders.setAllBorders(0);
            break;
        case DecorationOptions.BorderVeryLarge:
            borders.setBorders(12);
            extendedBorders.setAllBorders(0);
            break;
        case DecorationOptions.BorderHuge:
            borders.setBorders(18);
            extendedBorders.setAllBorders(0);
            break;
        case DecorationOptions.BorderVeryHuge:
            borders.setBorders(27);
            extendedBorders.setAllBorders(0);
            break;
        case DecorationOptions.BorderOversized:
            borders.setBorders(40);
            extendedBorders.setAllBorders(0);
            break;
        case DecorationOptions.BorderNoSides:
            borders.setBorders(4);
            borders.setSideBorders(1);
            extendedBorders.setSideBorders(1);
            break;
        case DecorationOptions.BorderNone:
            borders.setBorders(1);
            extendedBorders.setBorders(1);
            break;
        case DecorationOptions.BorderNormal: // fall through to default
        default:
            borders.setBorders(4);
            extendedBorders.setAllBorders(0);
            break;
        }
    }
    function readConfig() {
        var titleAlignLeft = decoration.readConfig("titleAlignLeft", true);
        var titleAlignCenter = decoration.readConfig("titleAlignCenter", false);
        var titleAlignRight = decoration.readConfig("titleAlignRight", false);
        if (titleAlignRight) {
            root.titleAlignment = Text.AlignRight;
        } else if (titleAlignCenter) {
            root.titleAlignment = Text.AlignHCenter;
        } else {
            if (!titleAlignLeft) {
                console.log("Error reading title alignment: all alignment options are false");
            }
            root.titleAlignment = Text.AlignLeft;
        }
        root.animateButtons = decoration.readConfig("animateButtons", true);
        root.titleShadow = decoration.readConfig("titleShadow", true);
        if (decoration.animationsSupported) {
            root.animationDuration = 150;
            root.animateButtons = false;
        }
    }
    ColorHelper {
        id: colorHelper
    }
    DecorationOptions {
        id: options
        deco: decoration
    }
    id: root
    alpha: false
    property int borderSize: decorationSettings.borderSize
    property real buttonSize: (borders.top  - 0) / 3.0 * 2.0
    property real topHeight: decoration.client.maximized ? maximizedBorders.top : borders.top
    property alias titleAlignment: caption.horizontalAlignment
    Rectangle {
        color: "black"
        opacity: 0
        visible: !decoration.client.maximized
        anchors {
            fill: parent
        }
        border {
            width: decoration.client.maximized ? 0 : 0
            color: "black"
        }
    }
    Rectangle {
        color: "black"
        opacity: 0
        visible: !decoration.client.maximized
        anchors {
            fill: parent
            bottomMargin: 1
            topMargin: 1
            leftMargin: 1
            rightMargin: 1
        }
        border {
            width: decoration.client.maximized ? 0 : 1
            color: "black"
        }
    }
    Rectangle {
        color: options.titleBarColor
        anchors {
            fill: parent
            bottomMargin: decoration.client.maximized ? 0 : 0
            topMargin: decoration.client.maximized ? 0 : 0
            leftMargin: decoration.client.maximized ? 0 : 0
            rightMargin: decoration.client.maximized ? 0 : 0
        }
        border {
            id: outerBorder
            width: decoration.client.maximized ? 0 : 0
            color: colorHelper.shade(options.titleBarColor, ColorHelper.MidShade)
        }
        Item {
            id: top
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: 0
                leftMargin: decoration.client.maximized ? 0 : root.borders.right - 0
                rightMargin: decoration.client.maximized ? 0 : root.borders.left - 0
            }
            height: decoration.client.maximized ? root.maximizedBorders.top : root.borders.top

            Item {
                id: titleRow
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    topMargin: 4
                }
                ButtonGroup {
                    id: leftButtonGroup
                    spacing: 1
                    explicitSpacer: root.buttonSize
                    menuButton: menuButtonComponent
                    //appMenuButton: appMenuButtonComponent
                    minimizeButton: minimizeButtonComponent
                    maximizeButton: maximizeButtonComponent
                    //keepBelowButton: keepBelowButtonComponent
                    //keepAboveButton: keepAboveButtonComponent
                    //helpButton: helpButtonComponent
                    //shadeButton: shadeButtonComponent
                    //allDesktopsButton: stickyButtonComponent
                    closeButton: closeButtonComponent
                    buttons: options.titleButtonsLeft
                    anchors {
                        top: parent.top
                        left: parent.left
                    }
                }
                Text {
                    id: caption
                    textFormat: Text.PlainText
                    anchors {
                        top: parent.top
                        left: leftButtonGroup.right
                        right: rightButtonGroup.left
                        rightMargin: 4
                        leftMargin: 4
                        topMargin: 2
                        bottomMargin: 1
                    }
                    color: options.fontColor
                    Behavior on color {
                        ColorAnimation { duration: root.animationDuration }
                    }
                    text: decoration.client.caption
                    font: options.titleFont
                    style: root.titleShadow ? Text.Raised : Text.Normal
                    styleColor: colorHelper.shade(color, ColorHelper.ShadowShade)
                    elide: Text.ElideMiddle
                    renderType: Text.NativeRendering
                }
                ButtonGroup {
                    id: rightButtonGroup
                    spacing: 1
                    explicitSpacer: root.buttonSize
                    menuButton: menuButtonComponent
                    //appMenuButton: appMenuButtonComponent
                    minimizeButton: minimizeButtonComponent
                    maximizeButton: maximizeButtonComponent
                    //keepBelowButton: keepBelowButtonComponent
                    //keepAboveButton: keepAboveButtonComponent
                    //helpButton: helpButtonComponent
                    //shadeButton: shadeButtonComponent
                    //allDesktopsButton: stickyButtonComponent
                    closeButton: closeButtonComponent
                    buttons: options.titleButtonsRight
                    anchors {
                        top: parent.top
                        right: parent.right
                    }
                }
                Component.onCompleted: {
                    decoration.installTitleItem(titleRow);
                }
            }
        }
        Item {
            id: innerBorder
            anchors.fill: parent

            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: 0
                y: top.height - 0
                visible: decoration.client.maximized
                color: colorHelper.shade(options.titleBarColor, ColorHelper.MidShade)
            }

            Rectangle {
                anchors {
                    fill: parent
                    leftMargin: root.borders.left - 0
                    rightMargin: root.borders.right - 0
                    topMargin: root.borders.top - 0
                    bottomMargin: root.borders.bottom - 0
                }
                border {
                    width: 0
                    color: colorHelper.shade(options.titleBarColor, ColorHelper.MidShade)
                }
                visible: !decoration.client.maximized
                color: options.titleBarColor
            }
        }
    }
    Component {
        id: minimizeButtonComponent
        Button {
            width: root.buttonSize / 4.0 * 4.5
            height: root.buttonSize
            image: "imgs/minimize.svg"
            imageHover: "imgs/minimize_hover.svg"
            imageDisable: "imgs/minimize_disable.svg"
            buttonType: DecorationOptions.DecorationButtonMinimize
        }
    }
    Component {
        id: maximizeButtonComponent
        Button {
            width: root.buttonSize / 4.0 * 4.5
            height: root.buttonSize
            image: !decoration.client.maximized ? "imgs/maximize.svg" : "imgs/restore.svg"
            imageHover: !decoration.client.maximized ? "imgs/maximize_hover.svg" : "imgs/restore_hover.svg"
            imageDisable: !decoration.client.maximized ? "imgs/maximize_disable.svg" : "imgs/restore_disable.svg"
            buttonType: DecorationOptions.DecorationButtonMaximizeRestore
        }
    }
    Component {
        id: closeButtonComponent
        Button {
            width: root.buttonSize / 4.0 * 4.5
            height: root.buttonSize
            image: "imgs/close.svg"
            imageHover: "imgs/close_hover.svg"
            imageDisable: "imgs/close_disable.svg"
            buttonType: DecorationOptions.DecorationButtonClose
        }
    }
    Component {
        id: menuButtonComponent
        Item {
            height: root.topHeight
            width: root.buttonSize
            MenuButton {
                width: root.buttonSize / 5.0 * 4.5
                height: root.buttonSize / 5.0 * 4.5
                anchors {
                    bottom: parent.bottom
                    bottomMargin: (parent.height - (root.buttonSize / 5.0 * 4.5)) / 1
                    left: parent.left
                }
            }
        }
    }
    Component.onCompleted: {
        borders.setBorders(4);
        borders.setTitle(32);
        maximizedBorders.setTitle(32);
        root.titleAlignment = Text.AlignHCenter;
        console.log(root.buttonSize);
    }
    Connections {
        target: decoration
        onConfigChanged: root.readConfig()
    }
    Connections {
        target: decorationSettings
        onBorderSizeChanged: root.readBorderSize();
    }
}
