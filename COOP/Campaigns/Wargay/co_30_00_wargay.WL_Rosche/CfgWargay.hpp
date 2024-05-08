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

class CfgWargay
{
    westMarkerColor[] = {
        __EVAL(96/255),
        __EVAL(159/255),
        __EVAL(197/255),
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

    // TODO: Consider adding vehicle cost for veterancy
    class Vehicles
    {
        // West Germany
        VEHICLE(30,gm_Leopard1_base,6,2,2,1);
        VEHICLE_LIKE(gm_Leopard1_base,gm_Leopard1a1_base); // 1A1 should be recon with 5/2/2/1
        VEHICLE_LIKE(gm_Leopard1_base,gm_BPz2_base)
        VEHICLE(30,gm_Leopard1a3_base,8,3,2,2);
        VEHICLE(65,gm_leopard1a5_base,10,3,2,2);
        VEHICLE(55,gm_Gepard1a1_base,3,2,2,1);
        VEHICLE(50,gm_m109g_base,2,1,1,1);
        VEHICLE(15,gm_marder1_base,4,2,1,1);
        VEHICLE(20,gm_marder1a1plus_base,4,2,2,1);
        VEHICLE(20,gm_marder1a2_base,5,3,2,2);
        VEHICLE_RECON(25,gm_luchs_base,2,1,1,1);
        VEHICLE(5,gm_m113_base,1,1,1,1);
        VEHICLE_LIKE(gm_m113_base,gm_fuchs_base);
        VEHICLE_RECON(10,gm_fuchsa0_reconnaissance_base,1,1,1,1);
        VEHICLE_RECON(45,gm_bo105m_base,0,0,0,0);
        VEHICLE(50,gm_bo105p_base,0,0,0,0);

        // East Germany
        VEHICLE_RECON(15,gm_pt76_base,2,1,1,1);
        VEHICLE(25,gm_t55_base,7,3,2,1);
        VEHICLE_LIKE(gm_t55_base,gm_t55a_base);
        VEHICLE_LIKE(gm_t55_base,gm_t55ak_base);
        VEHICLE(50,gm_t55am2_base,10,4,2,2);
        VEHICLE(55,gm_t55am2b_base,10,5,2,2);
        VEHICLE(35,gm_zsu234_base,1,1,1,1);
        VEHICLE(55,gm_2s1_base,1,1,1,1);
        VEHICLE(130,gm_2p16_base,1,1,1,1);
        VEHICLE(10,gm_bmp1_base,1,1,1,1);
        VEHICLE_RECON(15,gm_brdm2_base,1,1,1,1);
        VEHICLE(10,gm_btr60_base,1,1,1,1);
        VEHICLE_RECON(40,gm_mi2p_base,0,0,0,0);
        VEHICLE(30,gm_mi2urn_base,0,0,0,0);
        VEHICLE_LIKE(gm_mi2urn_base,gm_mi2us_base);
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
