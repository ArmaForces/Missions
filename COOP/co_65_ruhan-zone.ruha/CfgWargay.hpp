class CfgWargay
{
    class Ammo
    {
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

        // BMP-1
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

        // SPW-60PB
        class gm_bullet_145x114mm_AP_B32 : HMG_AP {};
        class gm_bullet_145x114mm_HEI_T_MDZ : HMG_HE {};

        // SPG-9
        class gm_shell_73mm_heat_pg15v
        {
            damage = 12;
            type = "HEAT";
        };
        class gm_shell_73mm_he_og15v : Small_HE {};

        // Fagot
        class gm_missile_fagot_heat_9m111
        {
            damage = 16;
            type = "HEAT";
        };
    };

    class Vehicles
    {
        class gm_ge_army_Leopard1a1
        {
            armor[] = { 6, 2, 2, 1 };

            // class Ammo
            // {
            //     ammo = "gm_shell_105x617mm_apds_t_dm13";
            // };
        };
        class gm_ge_army_Leopard1a1a2 : gm_ge_army_Leopard1a1 {};

        class gm_ge_army_Leopard1a3
        {
            armor[] = { 8, 3, 2, 2 };

        };
        class gm_ge_army_Leopard1a3a1 : gm_ge_army_Leopard1a3 {};
    };
};