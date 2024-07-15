class ADDON {
    tag = QUOTE(ADDON);
    class functions {
        file = "functions";

        // For ViewDistance and GroupRename GUIs
        class groupRenameGUI {};
        class groupRenameList {};
        class setViewDistance {};
        class viewDistanceGUI {};
        class playerActions {};

        class addAndForcePointer {};
        class holsterWeapon {};

        // Info Text
        class infoText {};
        class initInfoText {};

        // Tasks
        class taskConditionsAdd {};
        class taskConditionsInit { postInit = 1; };
        class taskConditionsLoop {};
    };
};
