#define ARMOR(FRONT,SIDES,BACK,TOP) armor[] = { FRONT, SIDES, BACK, TOP }
#define VEHICLE(cost,vehicleClass,armorFront,armorSides,armorBack,armorTop) class vehicleClass \
        { \
            pointCost = cost;\
            hitpoints = 10;\
            ARMOR(armorFront,armorSides,armorBack,armorTop);\
        }
#define VEHICLE_RECON(cost,vehicleClass,armorFront,armorSides,armorBack,armorTop) class vehicleClass \
        { \
            pointCost = cost;\
            hitpoints = 10;\
            ARMOR(armorFront,armorSides,armorBack,armorTop);\
            isRecon = 1;\
        }
#define VEHICLE_LIKE(otherVehicleClass,vehicleClass) class vehicleClass : otherVehicleClass {}
#define HAS_PENETRATOR(penetratorClass) NO_DAMAGE \
        { \
            child = penetratorClass;\
        }

// Icon macros
#define ARMA_NATO_MARKERS_DIR \A3\ui_f\data\map\markers\nato
#define ANTIAIR_SPAAG_ICON __EVAL(getMissionPath "gui\markers\b_antiair_spaag.paa")
#define ANTIAIR_SPAAG_RADAR_ICON __EVAL(getMissionPath "gui\markers\b_antiair_spaag_radar.paa")
#define ANTITANK_ICON __EVAL(getMissionPath "gui\markers\b_antitank.paa")
#define ANTITANK_ARMOR_ICON __EVAL(getMissionPath "gui\markers\b_antitank_armor.paa")
#define ART_ICON QUOTE(ARMA_NATO_MARKERS_DIR\b_art.paa)
#define ART_ROCKET_ICON __EVAL(getMissionPath "gui\markers\b_art_rocket.paa")
#define ARMOR_ICON QUOTE(ARMA_NATO_MARKERS_DIR\b_armor.paa)
#define CV_ARMOR_ICON __EVAL(getMissionPath "gui\markers\b_cv_armor.paa")
#define CV_ICON __EVAL(getMissionPath "gui\markers\b_cv.paa")
#define HELI_ICON QUOTE(ARMA_NATO_MARKERS_DIR\b_air.paa)
#define LOG_ARMOR_ICON QUOTE(ARMA_NATO_MARKERS_DIR\b_support.paa)
#define LOG_ICON QUOTE(ARMA_NATO_MARKERS_DIR\b_support.paa)
#define MECH_INF_ICON QUOTE(ARMA_NATO_MARKERS_DIR\b_mech_inf.paa)
#define MECH_INF_ARMED_ICON __EVAL(getMissionPath "gui\markers\b_mech_inf_armed.paa")
#define MOTOR_INF_ICON QUOTE(ARMA_NATO_MARKERS_DIR\b_motor_inf.paa)
#define RECON_AIR_ICON __EVAL(getMissionPath "gui\markers\b_recon_air.paa")
#define RECON_ANTITANK_ICON __EVAL(getMissionPath "gui\markers\b_recon_antitank.paa")
#define RECON_ARMOR_ICON __EVAL(getMissionPath "gui\markers\b_recon_armor.paa")
// TODO: Add missing icons

class CfgWargay
{
    westMarkerColor[] = {
        __EVAL(96/255),
        __EVAL(159/255),
        __EVAL(197/255),
        0.85
    };
    westAiMarkerColor[] = {
        __EVAL(29/255),
        __EVAL(197/255),
        __EVAL(46/255),
        0.85
    };
    eastMarkerColor[] = {
        __EVAL(192/255),
        __EVAL(29/255),
        __EVAL(46/255),
        0.85
    };
    filledHpColor[] = {
        __EVAL(117/255),
        1,
        1,
        1
    };
    missingHpColor[] = {
        __EVAL(117/255),
        __EVAL(117/255),
        __EVAL(117/255),
        1
    };

    class Ammo
    {
        class NO_DAMAGE
        {
            damage = 0;
            type = "NONE";
        };

        /* Base */
        class AA_HE
        {
            damage = 1;
            type = "HE";
        };
        class SMALL_ARMS
        {
            damage = 0.1;
            type = "AP";
        };
        class HMG_HE : AA_HE {};
        class HMG_AP
        {
            damage = 1;
            type = "AP";
        };
        class Small_HE
        {
            damage = 2;
            type = "HE";
        };
        class Tank_HE
        {
            damage = 3;
            type = "HE";
        };

        /* ACE Fragmentation */
        class ace_frag_tiny
        {
            damage = 0.1;
            type = "HE";
        };
        class ace_frag_tiny_HD : ace_frag_tiny {};
        class ace_frag_small
        {
            damage = 0.2;
            type = "HE";
        };
        class ace_frag_small_HD : ace_frag_small {};
        class ace_frag_medium
        {
            damage = 0.5;
            type = "HE";
        };
        class ace_frag_medium_HD : ace_frag_medium {};
        class ace_frag_large
        {
            damage = 1;
            type = "HE";
        };
        class ace_frag_large_HD : ace_frag_large {};
        class ace_frag_huge
        {
            damage = 2;
            type = "HE";
        };
        class ace_frag_huge_HD : ace_frag_huge {};


        /*
            Western Germany
        */
        // LARS-2
        class gm_rocket_mlrs_110mm_he_dm21 : HAS_PENETRATOR(gm_warhead_mlrs_110mm_he_dm21);
        class gm_warhead_mlrs_110mm_he_dm21
        {
            damage = 7;
            type = "HE";
        };

        class gm_rocket_mlrs_110mm_icm_dm602 : HAS_PENETRATOR(gm_penetrator_m77);
        class gm_penetrator_m77
        {
            damage = 6;
            type = "HEAT";
        };

        // M-109G
        class gm_shell_155mm_he_dm21 : HAS_PENETRATOR(gm_warhead_155mm_he_dm21);
        class gm_warhead_155mm_he_dm21
        {
            damage = 7;
            type = "HE";
        };

        class gm_shell_155mm_icm_602 : HAS_PENETRATOR(gm_warhead_155mm_icm_602);
        class gm_warhead_155mm_icm_602
        {
            damage = 6;
            type = "HEAT";
        };

        // Flakpanzer Gepard 1A1
        class gm_bullet_35x228mm_hei_t_DM21 : AA_HE {};
        class gm_bullet_35x228mm_hvapds_t_DM23 : AA_HE {};

        // Luchs & Marder 1
        class gm_bullet_20x139mm_hei_t_dm81 : HMG_HE {};
        class gm_bullet_20x139mm_apds_t_dm63
        {
            damage = 2;
            type = "AP";
        };

        /* Leopard 1 family */
        class gm_shell_105x617mm_apds_t_dm13
        {
            damage = 11;
            type = "AP";
        };

        class gm_shell_105x617mm_heat_mp_t_dm12 : HAS_PENETRATOR(gm_penetrator_105x617mm_heat_dm12);
        class gm_penetrator_105x617mm_heat_dm12
        {
            damage = 11;
            type = "HEAT";
        };

        class gm_shell_105x617mm_apfsds_t_dm23 : gm_shell_105x617mm_apds_t_dm13 {};
        
        // Leopard 1A3/4
        class gm_shell_105x617mm_apfsds_t_dm33
        {
            damage = 12;
            type = "AP";
        };
        
        // Leopard 1A5
        class gm_shell_105x617mm_apfsds_t_dm63
        {
            damage = 16;
            type = "AP";
        };

        // Milan
        class gm_missile_milan_heat_dm92 : HAS_PENETRATOR(gm_penetrator_milan_HEAT_dm92);
        class gm_penetrator_milan_HEAT_dm82
        {
            damage = 17;
            type = "HEAT";
        };
        class gm_penetrator_milan_HEAT_dm92 : gm_penetrator_milan_HEAT_dm82 {};

        // Hot 1 & 2
        class gm_missile_hot_heat_dm72 : HAS_PENETRATOR(gm_penetrator_hot_HEAT_dm72);
        class gm_missile_hot_heat_dm102 : HAS_PENETRATOR(gm_penetrator_hot_HEAT_dm102);
        class gm_penetrator_hot_HEAT_dm72
        {
            damage = 22;
            type = "HEAT";
        };
        class gm_penetrator_hot_HEAT_dm102
        {
            damage = 25;
            type = "HEAT";
        };

        // PzF 44
        class gm_rocket_44x537mm_HEAT_dm32 : HAS_PENETRATOR(gm_penetrator_44x537mm_HEAT_dm32);
        class gm_penetrator_44x537mm_HEAT_dm32
        {
            damage = 16;
            type = "HEAT";
        };

        // PzF 3
        class gm_rocket_60mm_HEAT_dm12 : HAS_PENETRATOR(gm_penetrator_60mm_HEAT_dm12);
        class gm_rocket_60mm_HEAT_dm22 : HAS_PENETRATOR(gm_penetrator_60mm_HEAT_dm22);
        class gm_rocket_60mm_HEAT_dm32 : HAS_PENETRATOR(gm_penetrator_60mm_HEAT_dm32);
        class gm_penetrator_60mm_HEAT_dm12
        {
            damage = 24;
            type = "HEAT";
        };
        class gm_penetrator_60mm_HEAT_dm22 : gm_penetrator_60mm_HEAT_dm12
        {
            damage = 26;
        };
        class gm_penetrator_60mm_HEAT_dm32 : gm_penetrator_60mm_HEAT_dm12
        {
            damage = 28;
        };

        // PzF 84 (Carl Gustav M2)
        class gm_rocket_84x245mm_HEAT_T_DM12 : HAS_PENETRATOR(gm_penetrator_84x245mm_HEAT_DM12);
        class gm_rocket_84x245mm_HEAT_T_DM12A1 : HAS_PENETRATOR(gm_penetrator_84x245mm_HEAT_DM12A1);
        class gm_rocket_84x245mm_HEAT_T_DM22 : HAS_PENETRATOR(gm_penetrator_84x245mm_HEAT_DM22);
        class gm_rocket_84x245mm_HEAT_T_DM32 : HAS_PENETRATOR(gm_penetrator_84x245mm_HEAT_DM32);

        class gm_penetrator_84x245mm_HEAT_DM12
        {
            damage = 18;
            type = "HEAT";
        };
        class gm_penetrator_84x245mm_HEAT_DM12A1 : gm_penetrator_84x245mm_HEAT_DM12 {};
        class gm_penetrator_84x245mm_HEAT_DM22 : gm_penetrator_84x245mm_HEAT_DM12
        {
            damage = 20;
        };
        class gm_penetrator_84x245mm_HEAT_DM32 : gm_penetrator_84x245mm_HEAT_DM12
        {
            damage = 22;
        };

        // M72A3 LAW
        class gm_rocket_66mm_HEAT_m72a3 : HAS_PENETRATOR(gm_penetrator_66mm_HEAT_m72a3);
        
        class gm_penetrator_66mm_HEAT_m72a3
        {
            damage = 13;
            type = "HEAT";
        };

        // FIM-43 (Redeye)
        class gm_rocket_70mm_HE_m585
        {
            damage = 3;
            type = "HE";
        };

        /*
            Eastern Germany
        */

        /* PT-76B */
        class gm_shell_76x385mm_he_of350 : Small_HE {};
        class gm_shell_76x385mm_HVAP_T_br354p
        {
            damage = 10;
            type = "AP";
        };
        class gm_shell_76x385mm_HEAT_T_bk350m
        {
            damage = 10;
            type = "HEAT";
        };

        /* T-55 family */
        class gm_shell_100x695mm_apfsds_t_bm8
        {
            damage = 11;
            type = "AP";
        };

        class gm_shell_100x695mm_he_of412 : Tank_HE {};

        // T-55A
        class gm_shell_100x695mm_heat_t_bk5m : HAS_PENETRATOR(gm_penetrator_100x695mm_HEAT_T_bk5m);
        class gm_penetrator_100x695mm_HEAT_T_bk5m
        {
            damage = 11;
            type = "HEAT";
        };
        
        class gm_shell_100x695mm_apfsds_t_bm20
        {
            damage = 11;
            type = "AP";
        };

        // T-55AK/T-55AM2/T-55AM2B
        class gm_shell_100x695mm_apfsds_t_bm25
        {
            damage = 15;
            type = "AP";
        };

        // ZSU-23-4
        class gm_bullet_23x152mm_hei_t_ofzt : AA_HE {};
        class gm_bullet_23x152mm_api_t_bzt : gm_bullet_23x152mm_hei_t_ofzt {};

        // SFL 2S1
        class gm_shell_122x447mm_he_of462 : HAS_PENETRATOR(gm_warhead_122x447mm_he_of462);
        class gm_warhead_122x447mm_he_of462
        {
            damage = 6;
            type = "HE";
        };

        class gm_shell_122x447mm_heat_t_bk13 : HAS_PENETRATOR(gm_penetrator_122x447mm_heat_t_bk13);
        class gm_penetrator_122x447mm_heat_bk6m
        {
            damage = 9;
            type = "HEAT";
        };
        class gm_penetrator_122x447mm_heat_t_bk13 : gm_penetrator_122x447mm_heat_bk6m {};

        // BM-21
        class gm_rocket_mlrs_122mm_he_9m22u : HAS_PENETRATOR(gm_warhead_122mm_he_9m22u);
        class gm_warhead_122mm_he_9m22u
        {
            damage = 7;
            type = "HE";
        };

        class gm_rocket_mlrs_122mm_icm_9m218 : HAS_PENETRATOR(gm_penetrator_3b30);
        class gm_penetrator_3b30
        {
            damage = 5;
            type = "HEAT";
        };

        // 2P16
        class gm_rocket_luna_he_3r9
        {
            damage = 15;
            type = "HE";
        };

        // BMP-1 & SPG-9
        class gm_shell_73mm_heat_pg15v
        {
            damage = 12;
            type = "HEAT";
        };
        class gm_shell_73mm_he_og15v : Small_HE {};

        class gm_missile_maljutka_heat_9m14m : HAS_PENETRATOR(gm_penetrator_maljutka_HEAT_9m14m);
        class gm_penetrator_maljutka_HEAT_9m14
        {
            damage = 15;
            type = "HEAT";
        };
        class gm_penetrator_maljutka_HEAT_9m14m : gm_penetrator_maljutka_HEAT_9m14 {};

        // SPW-60PB
        class gm_bullet_145x114mm_AP_B32 : HMG_AP {};
        class gm_bullet_145x114mm_HEI_T_MDZ : HMG_HE {};

        // Fagot
        class gm_missile_fagot_heat_9m111 : HAS_PENETRATOR(gm_penetrator_fagot_HEAT_9m111);
        class gm_penetrator_fagot_HEAT_9m111
        {
            damage = 16;
            type = "HEAT";
        };

        
        class gm_rocket_40mm_HEAT_pg7v : HAS_PENETRATOR(gm_penetrator_40mm_HEAT_pg7v);
        class gm_penetrator_40mm_HEAT_pg7v
        {
            damage = 14;
            type = "HEAT";
        };

        class gm_rocket_40mm_HEAT_pg7v1 : HAS_PENETRATOR(gm_penetrator_40mm_HEAT_pg7v1);
        class gm_penetrator_40mm_HEAT_pg7v1
        {
            damage = 17;
            type = "HEAT";
        };

        class gm_rocket_55mm_HE_s5
        {
            damage = 1;
            type = "HE";
        };

        class gm_rocket_55mm_heat_s5k : HAS_PENETRATOR(gm_penetrator_55mm_heat_s5k);
        class gm_penetrator_55mm_heat_s5k
        {
            damage = 2;
            type = "HEAT";
        };

        class gm_rocket_64mm_HEAT_pg18 : HAS_PENETRATOR(gm_penetrator_64mm_HEAT_pg18);
        class gm_penetrator_64mm_HEAT_pg18
        {
            damage = 15;
            type = "HEAT";
        };

        // Strela-2
        class gm_rocket_72mm_HE_9m32m : gm_rocket_70mm_HE_m585 {};

        // DShKM
        class gm_bullet_127x108mm_API_T_BZT : SMALL_ARMS {};
    };

    class Vehicles
    {
        /*
            West Germany
        */

        // LOG
        class gm_ge_army_m113a1g_command
        {
            pointCost = 105;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = CV_ARMOR_ICON;
            markerType = "b_hq";
            isCommandVehicle = 1;
        };
        class gm_iltis_cargo_base
        {
            pointCost = 110;
            hitpoints = 5;
            ARMOR(0,0,0,0);
            iconPath = CV_ICON;
            markerType = "b_hq";
            isCommandVehicle = 1;
        };
        class gm_fuchsa0_command_base
        {
            pointCost = 120;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = CV_ARMOR_ICON;
            markerType = "b_hq";
            isCommandVehicle = 1;
        };

        class gm_kat1_451_reammo_base
        {
            pointCost = 30;
            hitpoints = 10;
            ARMOR(0,0,0,0);
            iconPath = LOG_ICON;
            markerType = "b_support";
            isLogistics = 1;
        };
        VEHICLE_LIKE(gm_kat1_451_reammo_base,gm_kat1_451_refuel_base);
        VEHICLE_LIKE(gm_kat1_451_reammo_base,gm_kat1_451_container_base);
        class gm_kat1_452_container_base : gm_kat1_451_reammo_base
        {
            pointCost = 35;
        };
        class gm_kat1_454_cargo_base : gm_kat1_451_reammo_base
        {
            pointCost = 40;
        };
        class gm_u1300l_repair_base : gm_kat1_451_reammo_base
        {
            pointCost = 10;
            hitpoints = 5;
        };
        VEHICLE_LIKE(gm_u1300l_repair_base,gm_u1300l_container_base);
        VEHICLE_LIKE(gm_u1300l_repair_base,gm_u1300l_medic_base);

        // TNK
        class gm_Leopard1_base
        {
            pointCost = 30;
            hitpoints = 10;
            ARMOR(6,2,2,1);
            iconPath = ARMOR_ICON;
            markerType = "b_armor";
        };
        VEHICLE_LIKE(gm_Leopard1_base,gm_Leopard1a1_base); // 1A1 should be recon with 5/2/2/1
        
        class gm_BPz2_base : gm_Leopard1_base
        {
            pointCost = 40;
            iconPath = LOG_ARMOR_ICON;
            markerType = "b_support";
            isLogistics = 1;
        };
        class gm_Leopard1a3_base
        {
            pointCost = 40;
            hitpoints = 10;
            ARMOR(8,3,2,2);
            iconPath = ARMOR_ICON;
            markerType = "b_armor";
        };
        class gm_leopard1a5_base
        {
            pointCost = 65;
            hitpoints = 10;
            ARMOR(10,3,2,2);
            iconPath = ARMOR_ICON;
            markerType = "b_armor";
        };

        // SUP
        class gm_Gepard1a1_base
        {
            pointCost = 55;
            hitpoints = 10;
            ARMOR(3,2,2,1);
            iconPath = ANTIAIR_SPAAG_RADAR_ICON;
            markerType = "b_antiair";
        };
        class gm_m109g_base
        {
            pointCost = 50;
            hitpoints = 10;
            ARMOR(2,1,1,1);
            iconPath = ART_ICON;
            markerType = "b_art";
        };
        class gm_kat1_463_mlrs_base
        {
            pointCost = 70;
            hitpoints = 10;
            ARMOR(0,0,0,0);
            iconPath = ART_ROCKET_ICON;
            markerType = "b_art";
        };

        // VEH
        class gm_iltis_base
        {
            pointCost = 5;
            hitpoints = 5;
            ARMOR(0,0,0,0);
            iconPath = MOTOR_INF_ICON;
            markerType = "b_motor_inf";
        };
        class gm_iltis_milan_base : gm_iltis_base
        {
            pointCost = 20;
            iconPath = ANTITANK_ICON;
            markerType = "b_motor_inf";
        };
        class gm_kat1_base
        {
            pointCost = 5;
            hitpoints = 10;
            ARMOR(0,0,0,0);
            iconPath = MOTOR_INF_ICON;
            markerType = "b_motor_inf";
        };
        class gm_u1300l_base : gm_kat1_base
        {
            hitpoints = 5;
        };

        class gm_marder1_base
        {
            pointCost = 15;
            hitpoints = 10;
            ARMOR(4,2,1,1);
            iconPath = MECH_INF_ARMED_ICON;
            markerType = "b_mech_inf";
        };
        class gm_marder1a1plus_base : gm_marder1_base
        {
            pointCost = 15;
            ARMOR(4,2,2,1);
        };
        class gm_marder1a2_base : gm_marder1_base
        {
            pointCost = 20;
            ARMOR(5,3,2,2);
        };
        class gm_m113_base
        {
            pointCost = 5;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = MECH_INF_ICON;
            markerType = "b_mech_inf";
        };
        class gm_m113a1g_apc_milan_base : gm_m113_base
        {
            pointCost = 20;
            iconPath = ANTITANK_ARMOR_ICON;
            markerType = "b_mech_inf";
        };
        class gm_m113a1g_medic_base : gm_m113_base
        {
            pointCost = 15;
            iconPath = LOG_ARMOR_ICON;
            markerType = "b_med";
            isLogistics = 1;
        };
        class gm_fuchs_base : gm_m113_base
        {
            iconPath = MOTOR_INF_ICON;
            markerType = "b_motor_inf";
        };
        class gm_fuchsa0_engineer_base : gm_fuchs_base
        {
            pointCost = 20;
            iconPath = LOG_ARMOR_ICON;
            markerType = "b_support";
            isLogistics = 1;
        };

        // REC
        class gm_iltis_mg3_base : gm_iltis_base
        {
            pointCost = 25;
            iconPath = RECON_ICON;
            markerType = "b_recon";
            isRecon = 1;
        };
        class gm_luchs_base
        {
            pointCost = 25;
            hitpoints = 10;
            ARMOR(2,1,1,1);
            iconPath = RECON_ARMOR_ICON;
            markerType = "b_recon";
            isRecon = 1;
        };
        class gm_fuchsa0_reconnaissance_base : gm_luchs_base
        {
            pointCost = 10;
            ARMOR(1,1,1,1);
            iconPath = RECON_ANTITANK_ICON;
            markerType = "b_recon";
        };
        class gm_bo105m_base
        {
            pointCost = 45;
            hitpoints = 10; // Should be 4 according to Wargay
            ARMOR(0,0,0,0);
            iconPath = RECON_AIR_ICON;
            markerType = "b_air";
            isRecon = 1;
        };

        // HEL
        class gm_bo105p_base
        {
            pointCost = 50;
            hitpoints = 10; // Should be 4 according to Wargay
            ARMOR(0,0,0,0);
            iconPath = HELI_ICON;
            markerType = "b_air";
        };
        class gm_bo105p_pah1a1_base : gm_bo105p_base
        {
            pointCost = 60;
        };
        class gm_ch53_base
        {
            pointCost = 20;
            hitpoints = 10;
            ARMOR(0,0,0,0);
            iconPath = HELI_ICON; // TODO: Consider Heli cargo vs heli attack icon
            markerType = "b_air";
        };

        /*
            East Germany
        */

        // LOG
        class gm_uaz469_cargo_base
        {
            pointCost = 100;
            hitpoints = 5;
            ARMOR(0,0,0,0);
            iconPath = CV_ICON;
            markerType = "b_hq";
            isCommandVehicle = 1;
        };
        class gm_btr60pu12_base
        {
            pointCost = 110;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = CV_ARMOR_ICON;
            markerType = "b_hq";
            isCommandVehicle = 1;
        };
        class gm_brdm2um_base
        {
            pointCost = 120;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = CV_ARMOR_ICON;
            markerType = "b_hq";
            isCommandVehicle = 1;
        };
        class gm_t55ak_base
        {
            pointCost = 120;
            hitpoints = 10;
            ARMOR(7,3,2,1);
            iconPath = CV_ARMOR_ICON;
            markerType = "b_hq";
            isCommandVehicle = 1;
        };
        class gm_ural4320_repair_base
        {
            pointCost = 20;
            hitpoints = 5;
            ARMOR(0,0,0,0);
            iconPath = LOG_ICON;
            markerType = "b_support";
            isLogistics = 1;
        };
        VEHICLE_LIKE(gm_ural4320_repair_base,gm_ural4320_reammo_base);
        class gm_ural375d_refuel_base : gm_ural4320_repair_base
        {
            pointCost = 15;
        };
        VEHICLE_LIKE(gm_ural375d_refuel_base,gm_ural375d_medic_base);

        // SUP
        class gm_zsu234_base
        {
            pointCost = 35;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = ANTIAIR_SPAAG_RADAR_ICON;
            markerType = "b_antiair";
        };
        class gm_2s1_base
        {
            pointCost = 55;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = ART_ICON;
            markerType = "b_art";
        };
        class gm_2p16_base
        {
            pointCost = 130;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = ART_ROCKET_ICON;
            markerType = "b_art";
        };
        class gm_ural375d_mlrs_base
        {
            pointCost = 65;
            hitpoints = 5;
            ARMOR(0,0,0,0);
            iconPath = ART_ROCKET_ICON;
            markerType = "b_art";
        };

        // TNK
        class gm_t55_base
        {
            pointCost = 25;
            hitpoints = 10;
            ARMOR(7,3,2,1);
            iconPath = ARMOR_ICON;
            markerType = "b_armor";
        };
        VEHICLE_LIKE(gm_t55_base,gm_t55a_base);
        class gm_t55am2_base : gm_t55_base
        {
            pointCost = 50;
            ARMOR(10,4,2,2);
        };
        class gm_t55am2b_base
        {
            pointCost = 55;
            ARMOR(10,5,2,2);
        };
        
        // VEH
        class gm_ural4320_base
        {
            pointCost = 5;
            hitpoints = 5;
            ARMOR(0,0,0,0);
            iconPath = MOTOR_INF_ICON;
            markerType = "b_motor_inf";
        };
        class gm_uaz469_base
        {
            pointCost = 5;
            hitpoints = 5;
            ARMOR(0,0,0,0);
            iconPath = MOTOR_INF_ICON;
            markerType = "b_motor_inf";
        };
        class gm_uaz469_spg9_base : gm_uaz469_base
        {
            pointCost = 10;
            iconPath = ANTITANK_ICON;
            markerType = "b_motor_inf";
        };
        class gm_bmp1_base
        {
            pointCost = 10;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = MECH_INF_ARMED_ICON;
            markerType = "b_mech_inf";
        };
        class gm_btr60_base
        {
            pointCost = 10;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = MOTOR_INF_ICON;
            markerType = "b_motor_inf";
        };
        class gm_btr60pb_base : gm_btr60_base
        {
            pointCost = 15;
            iconPath = MECH_INF_ARMED_ICON;// TODO: Consider MOTOR_INF_ARMED_ICON;
            markerType = "b_mech_inf";
        };
        
        // REC
        class gm_pt76_base
        {
            pointCost = 15;
            hitpoints = 10;
            ARMOR(2,1,1,1);
            iconPath = RECON_ARMOR_ICON;
            markerType = "b_recon";
            isRecon = 1;
        };
        class gm_brdm2_base
        {
            pointCost = 15;
            hitpoints = 10;
            ARMOR(1,1,1,1);
            iconPath = RECON_ARMOR_ICON;
            markerType = "b_recon";
            isRecon = 1;
        };
        class gm_mi2p_base
        {
            pointCost = 40;
            hitpoints = 10; // Should be 4 according to Wargay
            ARMOR(0,0,0,0);
            iconPath = RECON_AIR_ICON;
            markerType = "b_air";
            isRecon = 1;
        };

        // HEL
        class gm_mi2_base
        {
            pointCost = 10;
            hitpoints = 10; // Should be 4 according to Wargay
            ARMOR(0,0,0,0);
            iconPath = HELI_ICON;
            markerType = "b_air";
        };
        class gm_mi2t_base : gm_mi2_base
        {
            pointCost = 15;
        };
        class gm_mi2us_base : gm_mi2_base
        {
            pointCost = 20;
        };
        class gm_mi2urn_base : gm_mi2_base
        {
            pointCost = 30;
        };
    };
};

// For future CSLA usage:
// ["CSLA_T72", [11, 6, 3, 2]];
// ["CSLA_T72M", [12, 7, 3, 2]];
// ["CSLA_T72M1", [14, 7, 3, 2]];
// ["CSLA_BVP1", [3, 1, 1, 1]];
// ["CSLA_BPzV", [3, 1, 1, 1]];
// ["CSLA_DTP90", [3, 1, 1, 1]];
// ["CSLA_MU90", [3, 1, 1, 1]];
// ["CSLA_OZV90", [3, 1, 1, 1]];
// ["CSLA_OT62", [2, 1, 1, 1]];
// ["CSLA_OT64C", [1, 1, 1, 1]];
// ["CSLA_OT64C_VB", [1, 1, 1, 1]];
// ["CSLA_OT65A", [1, 1, 1, 1]];
// ["AFMC_M1IP", [17, 7, 3, 3]];
// ["AFMC_M1A1", [17, 7, 4, 3]];
// ["AFMC_LAV25", [1, 1, 1, 1]];
// ["AFMC_M113_AMB", [1, 1, 1, 1]];
// ["AFMC_M113_DTP", [1, 1, 1, 1]];
// ["AFMC_M113", [1, 1, 1, 1]];
// ["AFMC_M163", [1, 1, 1, 1]];
// ["AFMC_M270", [1, 0, 0, 0]];
