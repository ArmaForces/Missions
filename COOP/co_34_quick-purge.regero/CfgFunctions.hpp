class CfgFunctions
{
    class ADDON
    {
        tag = QUOTE(ADDON);
        class crap
        {
            class incendiaryGrenadeInArea {};
            class initializeUAV {};
            class removeVegetationInArea {};
            class removeVegetationInAreaLoop {};
        };

        class equipment
        {
            class initResupplyEquipment {};
            class initVehicleEquipment {};
        };

        class gui
        {
            // For ViewDistance and GroupRename GUIs
            class groupRenameGUI {};
            class groupRenameList {};
            class setViewDistance {};
            class viewDistanceGUI {};
            class playerActions {};
        };

        class intro
        {
            class infoText {};
            class initInfoText {};
        };

        class tasks
        {
            // Tasks
            class taskConditionsAdd {};
            class taskConditionsInit { postInit = 1; };
            class taskConditionsLoop {};
        };
    };
};
