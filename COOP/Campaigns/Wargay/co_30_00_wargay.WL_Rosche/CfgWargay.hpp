#define ARMOR(FRONT,SIDES,BACK,TOP) armor[] = { FRONT, SIDES, BACK, TOP }
#define VEHICLE(vehicleClass,armorFront,armorSides,armorBack,armorTop) class vehicleClass \
        { \
            hitpoints = 10;\
            ARMOR(armorFront,armorSides,armorBack,armorTop);\
        }
#define VEHICLE_RECON(vehicleClass,armorFront,armorSides,armorBack,armorTop) class vehicleClass \
        { \
            hitpoints = 10;\
            ARMOR(armorFront,armorSides,armorBack,armorTop);\
            isRecon = 1;\
        }
#define VEHICLE_LIKE(otherVehicleClass,vehicleClass) class vehicleClass : otherVehicleClass {}

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
        class gm_rocket_mlrs_110mm_he_dm21 : NO_DAMAGE {};
        class gm_warhead_mlrs_110mm_he_dm21
        {
            damage = 7;
            type = "HE";
        };
        class gm_rocket_mlrs_110mm_icm_dm602 : NO_DAMAGE {};
        class gm_penetrator_m77
        {
            damage = 6;
            type = "HEAT";
        };
        // M-109G
        class gm_shell_155mm_he_dm21 : NO_DAMAGE {};
        class gm_warhead_155mm_he_dm21
        {
            damage = 7;
            type = "HE";
        };
        class gm_shell_155mm_icm_602 : NO_DAMAGE {};
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
        class gm_shell_105x617mm_heat_mp_t_dm12
        {
            damage = 11;
            type = "HEAT";
        };
        class gm_penetrator_105x617mm_heat_dm12 : NO_DAMAGE {};

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
        class gm_missile_milan_heat_dm92
        {
            damage = 17;
            type = "HEAT";
        };
        class gm_penetrator_milan_HEAT_dm82 : NO_DAMAGE {};
        class gm_penetrator_milan_HEAT_dm92 : NO_DAMAGE {};

        // Hot 1 & 2
        class gm_missile_hot_heat_dm72
        {
            damage = 22;
            type = "HEAT";
        };
        class gm_missile_hot_heat_dm102
        {
            damage = 25;
            type = "HEAT";
        };
        class gm_penetrator_hot_HEAT_dm102 : NO_DAMAGE {};
        class gm_penetrator_hot_HEAT_dm72 : NO_DAMAGE {};

        // PzF 44
        class gm_rocket_44x537mm_HEAT_dm32
        {
            damage = 16;
            type = "HEAT";
        };
        class gm_penetrator_44x537mm_HEAT_dm32 : NO_DAMAGE {};
        // PzF 3
        class gm_rocket_60mm_HEAT_dm12
        {
            damage = 24;
            type = "HEAT";
        };
        class gm_rocket_60mm_HEAT_dm22 : gm_rocket_60mm_HEAT_dm12
        {
            damage = 26;
        };
        class gm_rocket_60mm_HEAT_dm32 : gm_rocket_60mm_HEAT_dm12
        {
            damage = 28;
        };
        class gm_penetrator_60mm_HEAT_dm12 : NO_DAMAGE {};
        class gm_penetrator_60mm_HEAT_dm22 : NO_DAMAGE {};
        class gm_penetrator_60mm_HEAT_dm32 : NO_DAMAGE {};
        // PzF 84 (Carl Gustav M2)
        class gm_rocket_84x245mm_HEAT_T_DM12
        {
            damage = 18;
            type = "HEAT";
        };
        class gm_rocket_84x245mm_HEAT_T_DM12A1 : gm_rocket_84x245mm_HEAT_T_DM12 {};
        class gm_rocket_84x245mm_HEAT_T_DM22 : gm_rocket_84x245mm_HEAT_T_DM12
        {
            damage = 20;
        };
        class gm_rocket_84x245mm_HEAT_T_DM32 : gm_rocket_84x245mm_HEAT_T_DM12
        {
            damage = 22;
        };
        class gm_penetrator_84x245mm_HEAT_DM12 : NO_DAMAGE {};
        class gm_penetrator_84x245mm_HEAT_DM12A1 : NO_DAMAGE {};
        class gm_penetrator_84x245mm_HEAT_DM22 : NO_DAMAGE {};
        class gm_penetrator_84x245mm_HEAT_DM32 : NO_DAMAGE {};
        // M72A3 LAW
        class gm_rocket_66mm_HEAT_m72a3
        {
            damage = 13;
            type = "HEAT";
        };
        class gm_penetrator_66mm_HEAT_m72a3 : NO_DAMAGE {};

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
        class gm_shell_100x695mm_heat_t_bk5m
        {
            damage = 11;
            type = "HEAT";
        };
        class gm_penetrator_100x695mm_HEAT_T_bk5m : NO_DAMAGE {};
        
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
        class gm_shell_122x447mm_he_of462
        {
            damage = 6;
            type = "HE";
        };
        class gm_shell_122x447mm_heat_t_bk13
        {
            damage = 9;
            type = "HEAT";
        };
        class gm_penetrator_122x447mm_heat_bk6m : NO_DAMAGE {};
        class gm_penetrator_122x447mm_heat_t_bk13 : NO_DAMAGE {};

        // BM-21
        class gm_rocket_mlrs_122mm_he_9m22u : NO_DAMAGE {};
        class gm_warhead_122mm_he_9m22u
        {
            damage = 7;
            type = "HE";
        };
        class gm_rocket_mlrs_122mm_icm_9m218 : NO_DAMAGE {};
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
        class gm_missile_maljutka_heat_9m14m
        {
            damage = 15;
            type = "HEAT";
        };
        class gm_penetrator_maljutka_HEAT_9m14 : NO_DAMAGE {};
        class gm_penetrator_maljutka_HEAT_9m14m : NO_DAMAGE {};

        // SPW-60PB
        class gm_bullet_145x114mm_AP_B32 : HMG_AP {};
        class gm_bullet_145x114mm_HEI_T_MDZ : HMG_HE {};

        // Fagot
        class gm_missile_fagot_heat_9m111
        {
            damage = 16;
            type = "HEAT";
        };
        class gm_penetrator_fagot_HEAT_9m111 : NO_DAMAGE {};

        
        class gm_rocket_40mm_HEAT_pg7v
        {
            damage = 14;
            type = "HEAT";
        };
        class gm_penetrator_40mm_HEAT_pg7v : NO_DAMAGE {};
        class gm_rocket_40mm_HEAT_pg7v1
        {
            damage = 17;
            type = "HEAT";
        };
        class gm_penetrator_40mm_HEAT_pg7v1 : NO_DAMAGE {};
        class gm_rocket_55mm_HE_s5
        {
            damage = 1;
            type = "HE";
        };
        class gm_rocket_55mm_heat_s5k
        {
            damage = 2;
            type = "HEAT";
        };
        class gm_penetrator_55mm_heat_s5k : NO_DAMAGE {};
        class gm_rocket_64mm_HEAT_pg18
        {
            damage = 15;
            type = "HEAT";
        };
        class gm_penetrator_64mm_HEAT_pg18 : NO_DAMAGE {};

        // Strela-2
        class gm_rocket_72mm_HE_9m32m : gm_rocket_70mm_HE_m585 {};
    };

    // TODO: Consider adding vehicle cost for veterancy
    class Vehicles
    {
        // West Germany
        VEHICLE(gm_ge_army_Leopard1a1,6,2,2,1); // 1A1 should be recon with 5/2/2/1
        VEHICLE_LIKE(gm_ge_army_Leopard1a1,gm_ge_army_Leopard1a1a1);
        VEHICLE_LIKE(gm_ge_army_Leopard1a1,gm_ge_army_Leopard1a1a2);
        VEHICLE_LIKE(gm_ge_army_Leopard1a1,gm_ge_army_Leopard1a1a3);
        VEHICLE_LIKE(gm_ge_army_Leopard1a1,gm_ge_army_Leopard1a1a4);
        VEHICLE_LIKE(gm_ge_army_Leopard1a1,gm_ge_army_bpz2a0)
        VEHICLE(gm_ge_army_Leopard1a3,8,3,2,2);
        VEHICLE_LIKE(gm_ge_army_Leopard1a3,gm_ge_army_Leopard1a3a1);
        VEHICLE_LIKE(gm_ge_army_Leopard1a3,gm_ge_army_Leopard1a3a2);
        VEHICLE_LIKE(gm_ge_army_Leopard1a3,gm_ge_army_Leopard1a3a3);
        VEHICLE(gm_ge_army_Leopard1a5,10,3,2,2);
        VEHICLE_LIKE(gm_ge_army_Leopard1a5,gm_ge_army_Leopard1a5a1);
        VEHICLE(gm_ge_army_gepard1a1,3,2,2,1);
        VEHICLE(gm_ge_army_m109g,2,1,1,1);
        VEHICLE(gm_ge_army_marder1a1,4,2,1,1);
        VEHICLE_LIKE(gm_ge_army_marder1a1,gm_ge_army_marder1a1plus);
        VEHICLE_LIKE(gm_ge_army_marder1a1,gm_ge_army_marder1a2);
        VEHICLE_RECON(gm_ge_army_luchsa1,2,1,1,1);
        VEHICLE_RECON(gm_ge_army_luchsa2,2,2,1,1);
        VEHICLE(gm_ge_army_m113a1g_apc,1,1,1,1);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_m113a1g_apc_milan);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_m113a1g_command);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_m113a1g_medic);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_fuchsa0_command);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_fuchsa0_engineer);
        VEHICLE_RECON(gm_ge_army_fuchsa0_reconnaissance,1,1,1,1);
        VEHICLE_RECON(gm_ge_army_bo105m_vbh,0,0,0,0);
        VEHICLE_LIKE(gm_ge_army_bo105m_vbh,gm_ge_army_bo105p1m_vbh);
        VEHICLE_LIKE(gm_ge_army_bo105m_vbh,gm_ge_army_bo105p1m_vbh_swooper);

        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_bibera0);

        // East Germany
        VEHICLE(gm_gc_army_pt76b,2,1,1,1);
        VEHICLE(gm_gc_army_t55,7,3,2,1);
        VEHICLE_LIKE(gm_gc_army_t55,gm_gc_army_t55a);
        VEHICLE_LIKE(gm_gc_army_t55,gm_gc_army_t55ak);
        VEHICLE(gm_gc_army_t55am2,10,5,2,2);
        VEHICLE_LIKE(gm_gc_army_t55am2,gm_gc_army_t55am2b);
        VEHICLE(gm_gc_army_zsu234v1,1,1,1,1);
        VEHICLE(gm_gc_army_2s1,1,1,1,1);
        VEHICLE(gm_gc_army_2p16,1,1,1,1);
        VEHICLE(gm_gc_army_bmp1sp2,1,1,1,1);
        VEHICLE_RECON(gm_gc_army_brdm2,1,1,1,1);
        VEHICLE_LIKE(gm_gc_army_brdm2,gm_gc_army_brdm2rkh);
        VEHICLE_LIKE(gm_gc_army_brdm2,gm_gc_army_brdm2um);
        VEHICLE(gm_gc_army_btr60pa,1,1,1,1);
        VEHICLE_LIKE(gm_gc_army_btr60pa,gm_gc_army_btr60pa_dshkm);
        VEHICLE_LIKE(gm_gc_army_btr60pa,gm_gc_army_btr60pb);
        VEHICLE_LIKE(gm_gc_army_btr60pa,gm_gc_army_btr60pu12);
        VEHICLE_LIKE(gm_ge_army_bo105m_vbh,gm_gc_airforce_mi2p);
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
