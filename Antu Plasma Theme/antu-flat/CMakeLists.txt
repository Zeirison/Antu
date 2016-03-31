install(FILES colors metadata.desktop DESTINATION ${PLASMA_DATA_INSTALL_DIR}/desktoptheme/antu-flat/)

FILE(GLOB widgets widgets/*.svgz)
install( FILES ${widgets} DESTINATION ${PLASMA_DATA_INSTALL_DIR}/desktoptheme/antu-flat/widgets/ )

FILE(GLOB dialogs dialogs/*.svgz)
install( FILES ${dialogs} DESTINATION ${PLASMA_DATA_INSTALL_DIR}/desktoptheme/antu-flat/dialogs/ )

FILE(GLOB icons icons/*.svgz)
install( FILES ${icons} DESTINATION ${PLASMA_DATA_INSTALL_DIR}/desktoptheme/antu-flat/icons/ )
