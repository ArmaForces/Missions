// #define NO_ARMOR armor[] = { 0, 0, 0, 0 }
// #define ONE_ARMOR armor[] = { 1, 1, 1, 1 };
#define ARMOR(FRONT,SIDES,BACK,TOP) armor[] = { FRONT, SIDES, BACK, TOP }
#define VEHICLE(vehicleClass,armorFront,armorSides,armorBack,armorTop) class vehicleClass \
        { \
            ARMOR(armorFront,armorSides,armorBack,armorTop);\
        }
#define VEHICLE_LIKE(otherVehicleClass,vehicleClass) class vehicleClass : otherVehicleClass {}

class CfgWargay
{
    class Ammo
    {
        // TODO: Get values for infantry launchers

        /* Base */
        class AA_HE
        {
            damage = 1;
            type = "HE";
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

        /*
            Western Germany
        */
        // LARS-2
        class gm_rocket_mlrs_110mm_he_dm21
        {
            damage = 7;
            type = "HE";
        };
        // M-109G
        class gm_shell_155mm_he_dm21
        {
            damage = 7;
            type = "HE";
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
        // TODO: Possibly other rounds will be broken/named differently too
        class gm_penetrator_105x617mm_heat_dm12 : gm_shell_105x617mm_heat_mp_t_dm12 {};

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
        class gm_penetrator_milan_HEAT_dm82 : gm_missile_milan_heat_dm92 {};
        class gm_penetrator_milan_HEAT_dm92 : gm_missile_milan_heat_dm92 {};

        // Hot
        class gm_penetrator_hot_HEAT_dm102
        {
            damage = 22;
            type = "HEAT";
        };
        class gm_penetrator_hot_HEAT_dm72 : gm_penetrator_hot_HEAT_dm102 {};

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
        class gm_penetrator_100x695mm_HEAT_T_bk5m : gm_shell_100x695mm_heat_t_bk5m {};
        
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
        class gm_penetrator_122x447mm_heat_bk6m : gm_shell_122x447mm_heat_t_bk13 {};
        class gm_penetrator_122x447mm_heat_t_bk13 : gm_shell_122x447mm_heat_t_bk13 {};

        // BM-21
        class gm_rocket_mlrs_122mm_he_9m22u
        {
            damage = 7;
            type = "HE";
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
        class gm_penetrator_maljutka_HEAT_9m14 : gm_missile_maljutka_heat_9m14m {};
        class gm_penetrator_maljutka_HEAT_9m14m : gm_missile_maljutka_heat_9m14m {};

        // SPW-60PB
        class gm_bullet_145x114mm_AP_B32 : HMG_AP {};
        class gm_bullet_145x114mm_HEI_T_MDZ : HMG_HE {};

        // Fagot
        class gm_missile_fagot_heat_9m111
        {
            damage = 16;
            type = "HEAT";
        };
        class gm_penetrator_fagot_HEAT_9m111 : gm_missile_fagot_heat_9m111 {};
    };

    class Vehicles
    {
        // West Germany
        VEHICLE(gm_ge_army_Leopard1a1,6,2,2,1);
        VEHICLE_LIKE(gm_ge_army_Leopard1a1,gm_ge_army_Leopard1a1a2);
        VEHICLE_LIKE(gm_ge_army_Leopard1a1,gm_ge_army_bpz2a0)
        VEHICLE(gm_ge_army_Leopard1a3,8,3,2,2);
        VEHICLE_LIKE(gm_ge_army_Leopard1a3,gm_ge_army_Leopard1a3a1);
        VEHICLE(gm_ge_army_Leopard1a5,10,3,2,2);
        VEHICLE(gm_ge_army_gepard1a1,3,2,2,1);
        VEHICLE(gm_ge_army_m109g,2,1,1,1);
        VEHICLE(gm_ge_army_marder1a1,4,2,1,1);
        VEHICLE_LIKE(gm_ge_army_marder1a1,gm_ge_army_marder1a1plus);
        VEHICLE_LIKE(gm_ge_army_marder1a1,gm_ge_army_marder1a2);
        VEHICLE(gm_ge_army_luchsa1,2,1,1,1);
        VEHICLE(gm_ge_army_luchsa2,2,2,1,1);
        VEHICLE(gm_ge_army_m113a1g_apc,1,1,1,1);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_m113a1g_apc_milan);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_m113a1g_command);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_m113a1g_medic);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_fuchsa0_command);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_fuchsa0_engineer);
        VEHICLE_LIKE(gm_ge_army_m113a1g_apc,gm_ge_army_fuchsa0_reconnaissance);
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
        VEHICLE(gm_gc_army_brdm2,1,1,1,1);
        VEHICLE_LIKE(gm_gc_army_brdm2,gm_gc_army_brdm2rkh);
        VEHICLE_LIKE(gm_gc_army_brdm2,gm_gc_army_brdm2um);
        VEHICLE_LIKE(gm_gc_army_brdm2,gm_gc_army_btr60pa);
        VEHICLE_LIKE(gm_gc_army_brdm2,gm_gc_army_btr60pa_dshkm);
        VEHICLE_LIKE(gm_gc_army_brdm2,gm_gc_army_btr60pb);
        VEHICLE_LIKE(gm_gc_army_brdm2,gm_gc_army_btr60pu12);
    };
};