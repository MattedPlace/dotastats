#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

public PlVers:__version =
{
    version = 5,
    filevers = "1.6.3",
    date = "04/26/2015",
    time = "13:16:59"
};


new indicator;
new adt_log;
new global_stats[10];
new adt_clients;
new Handle:SQLcon;
new index_g;
new index_b;

public Plugin:myinfo =
{
    name = "Dota 2 - Stats",
    description = "Dota 2 - Stats",
    author = "Link & Kan & Sittingbull",
    version = "1.0",
    url = ""
};

GetItemIdByName(String:ItemName[])
{
    new id;
    if (!strcmp(ItemName, "item_blink", true))
    {
        id = 1;
    }
    if (!strcmp(ItemName, "item_blades_of_attack", true))
    {
        id = 2;
    }
    if (!strcmp(ItemName, "item_broadsword", true))
    {
        id = 3;
    }
    if (!strcmp(ItemName, "item_chainmail", true))
    {
        id = 4;
    }
    if (!strcmp(ItemName, "item_claymore", true))
    {
        id = 5;
    }
    if (!strcmp(ItemName, "item_helm_of_iron_will", true))
    {
        id = 6;
    }
    if (!strcmp(ItemName, "item_javelin", true))
    {
        id = 7;
    }
    if (!strcmp(ItemName, "item_mithril_hammer", true))
    {
        id = 8;
    }
    if (!strcmp(ItemName, "item_platemail", true))
    {
        id = 9;
    }
    if (!strcmp(ItemName, "item_quarterstaff", true))
    {
        id = 10;
    }
    if (!strcmp(ItemName, "item_quelling_blade", true))
    {
        id = 11;
    }
    if (!strcmp(ItemName, "item_ring_of_protection", true))
    {
        id = 12;
    }
    if (!strcmp(ItemName, "item_stout_shield", true))
    {
        id = 182;
    }
    if (!strcmp(ItemName, "item_gauntlets", true))
    {
        id = 13;
    }
    if (!strcmp(ItemName, "item_slippers", true))
    {
        id = 14;
    }
    if (!strcmp(ItemName, "item_mantle", true))
    {
        id = 15;
    }
    if (!strcmp(ItemName, "item_branches", true))
    {
        id = 16;
    }
    if (!strcmp(ItemName, "item_belt_of_strength", true))
    {
        id = 17;
    }
    if (!strcmp(ItemName, "item_boots_of_elves", true))
    {
        id = 18;
    }
    if (!strcmp(ItemName, "item_robe", true))
    {
        id = 19;
    }
    if (!strcmp(ItemName, "item_circlet", true))
    {
        id = 20;
    }
    if (!strcmp(ItemName, "item_ogre_axe", true))
    {
        id = 21;
    }
    if (!strcmp(ItemName, "item_blade_of_alacrity", true))
    {
        id = 22;
    }
    if (!strcmp(ItemName, "item_staff_of_wizardry", true))
    {
        id = 23;
    }
    if (!strcmp(ItemName, "item_ultimate_orb", true))
    {
        id = 24;
    }
    if (!strcmp(ItemName, "item_gloves", true))
    {
        id = 25;
    }
    if (!strcmp(ItemName, "item_lifesteal", true))
    {
        id = 26;
    }
    if (!strcmp(ItemName, "item_ring_of_regen", true))
    {
        id = 27;
    }
    if (!strcmp(ItemName, "item_sobi_mask", true))
    {
        id = 28;
    }
    if (!strcmp(ItemName, "item_boots", true))
    {
        id = 29;
    }
    if (!strcmp(ItemName, "item_gem", true))
    {
        id = 30;
    }
    if (!strcmp(ItemName, "item_cloak", true))
    {
        id = 31;
    }
    if (!strcmp(ItemName, "item_talisman_of_evasion", true))
    {
        id = 32;
    }
    if (!strcmp(ItemName, "item_cheese", true))
    {
        id = 33;
    }
    if (!strcmp(ItemName, "item_magic_stick", true))
    {
        id = 34;
    }
    if (!strcmp(ItemName, "item_recipe_magic_wand", true))
    {
        id = 35;
    }
    if (!strcmp(ItemName, "item_magic_wand", true))
    {
        id = 36;
    }
    if (!strcmp(ItemName, "item_ghost", true))
    {
        id = 37;
    }
    if (!strcmp(ItemName, "item_clarity", true))
    {
        id = 38;
    }
    if (!strcmp(ItemName, "item_flask", true))
    {
        id = 39;
    }
    if (!strcmp(ItemName, "item_dust", true))
    {
        id = 40;
    }
    if (!strcmp(ItemName, "item_bottle", true))
    {
        id = 41;
    }
    if (!strcmp(ItemName, "item_ward_observer", true))
    {
        id = 42;
    }
    if (!strcmp(ItemName, "item_ward_sentry", true))
    {
        id = 43;
    }
    if (!strcmp(ItemName, "item_tango", true))
    {
        id = 44;
    }
    if (!strcmp(ItemName, "item_tango_single", true))
    {
        id = 241;
    }
    if (!strcmp(ItemName, "item_courier", true))
    {
        id = 45;
    }
    if (!strcmp(ItemName, "item_tpscroll", true))
    {
        id = 46;
    }
    if (!strcmp(ItemName, "item_recipe_travel_boots", true))
    {
        id = 47;
    }
    if (!strcmp(ItemName, "item_travel_boots", true))
    {
        id = 48;
    }
    if (!strcmp(ItemName, "item_recipe_phase_boots", true))
    {
        id = 49;
    }
    if (!strcmp(ItemName, "item_phase_boots", true))
    {
        id = 50;
    }
    if (!strcmp(ItemName, "item_demon_edge", true))
    {
        id = 51;
    }
    if (!strcmp(ItemName, "item_eagle", true))
    {
        id = 52;
    }
    if (!strcmp(ItemName, "item_reaver", true))
    {
        id = 53;
    }
    if (!strcmp(ItemName, "item_relic", true))
    {
        id = 54;
    }
    if (!strcmp(ItemName, "item_hyperstone", true))
    {
        id = 55;
    }
    if (!strcmp(ItemName, "item_ring_of_health", true))
    {
        id = 56;
    }
    if (!strcmp(ItemName, "item_void_stone", true))
    {
        id = 57;
    }
    if (!strcmp(ItemName, "item_mystic_staff", true))
    {
        id = 58;
    }
    if (!strcmp(ItemName, "item_energy_booster", true))
    {
        id = 59;
    }
    if (!strcmp(ItemName, "item_point_booster", true))
    {
        id = 60;
    }
    if (!strcmp(ItemName, "item_vitality_booster", true))
    {
        id = 61;
    }
    if (!strcmp(ItemName, "item_recipe_power_treads", true))
    {
        id = 62;
    }
    if (!strcmp(ItemName, "item_power_treads", true))
    {
        id = 63;
    }
    if (!strcmp(ItemName, "item_recipe_hand_of_midas", true))
    {
        id = 64;
    }
    if (!strcmp(ItemName, "item_hand_of_midas", true))
    {
        id = 65;
    }
    if (!strcmp(ItemName, "item_recipe_oblivion_staff", true))
    {
        id = 66;
    }
    if (!strcmp(ItemName, "item_oblivion_staff", true))
    {
        id = 67;
    }
    if (!strcmp(ItemName, "item_recipe_pers", true))
    {
        id = 68;
    }
    if (!strcmp(ItemName, "item_pers", true))
    {
        id = 69;
    }
    if (!strcmp(ItemName, "item_recipe_poor_mans_shield", true))
    {
        id = 70;
    }
    if (!strcmp(ItemName, "item_poor_mans_shield", true))
    {
        id = 71;
    }
    if (!strcmp(ItemName, "item_recipe_bracer", true))
    {
        id = 72;
    }
    if (!strcmp(ItemName, "item_bracer", true))
    {
        id = 73;
    }
    if (!strcmp(ItemName, "item_recipe_wraith_band", true))
    {
        id = 74;
    }
    if (!strcmp(ItemName, "item_wraith_band", true))
    {
        id = 75;
    }
    if (!strcmp(ItemName, "item_recipe_null_talisman", true))
    {
        id = 76;
    }
    if (!strcmp(ItemName, "item_null_talisman", true))
    {
        id = 77;
    }
    if (!strcmp(ItemName, "item_recipe_mekansm", true))
    {
        id = 78;
    }
    if (!strcmp(ItemName, "item_mekansm", true))
    {
        id = 79;
    }
    if (!strcmp(ItemName, "item_recipe_vladmir", true))
    {
        id = 80;
    }
    if (!strcmp(ItemName, "item_vladmir", true))
    {
        id = 81;
    }
    if (!strcmp(ItemName, "item_flying_courier", true))
    {
        id = 84;
    }
    if (!strcmp(ItemName, "item_recipe_buckler", true))
    {
        id = 85;
    }
    if (!strcmp(ItemName, "item_buckler", true))
    {
        id = 86;
    }
    if (!strcmp(ItemName, "item_recipe_ring_of_basilius", true))
    {
        id = 87;
    }
    if (!strcmp(ItemName, "item_ring_of_basilius", true))
    {
        id = 88;
    }
    if (!strcmp(ItemName, "item_recipe_pipe", true))
    {
        id = 89;
    }
    if (!strcmp(ItemName, "item_pipe", true))
    {
        id = 90;
    }
    if (!strcmp(ItemName, "item_recipe_urn_of_shadows", true))
    {
        id = 91;
    }
    if (!strcmp(ItemName, "item_urn_of_shadows", true))
    {
        id = 92;
    }
    if (!strcmp(ItemName, "item_recipe_headdress", true))
    {
        id = 93;
    }
    if (!strcmp(ItemName, "item_headdress", true))
    {
        id = 94;
    }
    if (!strcmp(ItemName, "item_recipe_sheepstick", true))
    {
        id = 95;
    }
    if (!strcmp(ItemName, "item_sheepstick", true))
    {
        id = 96;
    }
    if (!strcmp(ItemName, "item_recipe_orchid", true))
    {
        id = 97;
    }
    if (!strcmp(ItemName, "item_orchid", true))
    {
        id = 98;
    }
    if (!strcmp(ItemName, "item_recipe_cyclone", true))
    {
        id = 99;
    }
    if (!strcmp(ItemName, "item_cyclone", true))
    {
        id = 100;
    }
    if (!strcmp(ItemName, "item_recipe_force_staff", true))
    {
        id = 101;
    }
    if (!strcmp(ItemName, "item_force_staff", true))
    {
        id = 102;
    }
    if (!strcmp(ItemName, "item_recipe_dagon", true))
    {
        id = 103;
    }
    if (!strcmp(ItemName, "item_recipe_dagon_2", true))
    {
        id = 197;
    }
    if (!strcmp(ItemName, "item_recipe_dagon_3", true))
    {
        id = 198;
    }
    if (!strcmp(ItemName, "item_recipe_dagon_4", true))
    {
        id = 199;
    }
    if (!strcmp(ItemName, "item_recipe_dagon_5", true))
    {
        id = 200;
    }
    if (!strcmp(ItemName, "item_dagon", true))
    {
        id = 104;
    }
    if (!strcmp(ItemName, "item_dagon_2", true))
    {
        id = 201;
    }
    if (!strcmp(ItemName, "item_dagon_3", true))
    {
        id = 202;
    }
    if (!strcmp(ItemName, "item_dagon_4", true))
    {
        id = 203;
    }
    if (!strcmp(ItemName, "item_dagon_5", true))
    {
        id = 204;
    }
    if (!strcmp(ItemName, "item_recipe_necronomicon", true))
    {
        id = 105;
    }
    if (!strcmp(ItemName, "item_recipe_necronomicon_2", true))
    {
        id = 191;
    }
    if (!strcmp(ItemName, "item_recipe_necronomicon_3", true))
    {
        id = 192;
    }
    if (!strcmp(ItemName, "item_necronomicon", true))
    {
        id = 106;
    }
    if (!strcmp(ItemName, "item_necronomicon_2", true))
    {
        id = 193;
    }
    if (!strcmp(ItemName, "item_necronomicon_3", true))
    {
        id = 194;
    }
    if (!strcmp(ItemName, "item_recipe_ultimate_scepter", true))
    {
        id = 107;
    }
    if (!strcmp(ItemName, "item_ultimate_scepter", true))
    {
        id = 108;
    }
    if (!strcmp(ItemName, "item_recipe_refresher", true))
    {
        id = 109;
    }
    if (!strcmp(ItemName, "item_refresher", true))
    {
        id = 110;
    }
    if (!strcmp(ItemName, "item_recipe_assault", true))
    {
        id = 111;
    }
    if (!strcmp(ItemName, "item_assault", true))
    {
        id = 112;
    }
    if (!strcmp(ItemName, "item_recipe_heart", true))
    {
        id = 113;
    }
    if (!strcmp(ItemName, "item_heart", true))
    {
        id = 114;
    }
    if (!strcmp(ItemName, "item_recipe_black_king_bar", true))
    {
        id = 115;
    }
    if (!strcmp(ItemName, "item_black_king_bar", true))
    {
        id = 116;
    }
    if (!strcmp(ItemName, "item_aegis", true))
    {
        id = 117;
    }
    if (!strcmp(ItemName, "item_recipe_shivas_guard", true))
    {
        id = 118;
    }
    if (!strcmp(ItemName, "item_shivas_guard", true))
    {
        id = 119;
    }
    if (!strcmp(ItemName, "item_recipe_bloodstone", true))
    {
        id = 120;
    }
    if (!strcmp(ItemName, "item_bloodstone", true))
    {
        id = 121;
    }
    if (!strcmp(ItemName, "item_recipe_sphere", true))
    {
        id = 122;
    }
    if (!strcmp(ItemName, "item_sphere", true))
    {
        id = 123;
    }
    if (!strcmp(ItemName, "item_recipe_vanguard", true))
    {
        id = 124;
    }
    if (!strcmp(ItemName, "item_vanguard", true))
    {
        id = 125;
    }
    if (!strcmp(ItemName, "item_recipe_crimson_guard", true))
    {
        id = 243;
    }
    if (!strcmp(ItemName, "item_crimson_guard", true))
    {
        id = 242;
    }
    if (!strcmp(ItemName, "item_recipe_blade_mail", true))
    {
        id = 126;
    }
    if (!strcmp(ItemName, "item_blade_mail", true))
    {
        id = 127;
    }
    if (!strcmp(ItemName, "item_recipe_soul_booster", true))
    {
        id = 128;
    }
    if (!strcmp(ItemName, "item_soul_booster", true))
    {
        id = 129;
    }
    if (!strcmp(ItemName, "item_recipe_hood_of_defiance", true))
    {
        id = 130;
    }
    if (!strcmp(ItemName, "item_hood_of_defiance", true))
    {
        id = 131;
    }
    if (!strcmp(ItemName, "item_recipe_rapier", true))
    {
        id = 132;
    }
    if (!strcmp(ItemName, "item_rapier", true))
    {
        id = 133;
    }
    if (!strcmp(ItemName, "item_recipe_monkey_king_bar", true))
    {
        id = 134;
    }
    if (!strcmp(ItemName, "item_monkey_king_bar", true))
    {
        id = 135;
    }
    if (!strcmp(ItemName, "item_recipe_radiance", true))
    {
        id = 136;
    }
    if (!strcmp(ItemName, "item_radiance", true))
    {
        id = 137;
    }
    if (!strcmp(ItemName, "item_recipe_butterfly", true))
    {
        id = 138;
    }
    if (!strcmp(ItemName, "item_butterfly", true))
    {
        id = 139;
    }
    if (!strcmp(ItemName, "item_recipe_greater_crit", true))
    {
        id = 140;
    }
    if (!strcmp(ItemName, "item_greater_crit", true))
    {
        id = 141;
    }
    if (!strcmp(ItemName, "item_recipe_basher", true))
    {
        id = 142;
    }
    if (!strcmp(ItemName, "item_basher", true))
    {
        id = 143;
    }
    if (!strcmp(ItemName, "item_recipe_bfury", true))
    {
        id = 144;
    }
    if (!strcmp(ItemName, "item_bfury", true))
    {
        id = 145;
    }
    if (!strcmp(ItemName, "item_recipe_manta", true))
    {
        id = 146;
    }
    if (!strcmp(ItemName, "item_manta", true))
    {
        id = 147;
    }
    if (!strcmp(ItemName, "item_recipe_lesser_crit", true))
    {
        id = 148;
    }
    if (!strcmp(ItemName, "item_lesser_crit", true))
    {
        id = 149;
    }
    if (!strcmp(ItemName, "item_recipe_armlet", true))
    {
        id = 150;
    }
    if (!strcmp(ItemName, "item_armlet", true))
    {
        id = 151;
    }
    if (!strcmp(ItemName, "item_recipe_invis_sword", true))
    {
        id = 183;
    }
    if (!strcmp(ItemName, "item_invis_sword", true))
    {
        id = 152;
    }
    if (!strcmp(ItemName, "item_recipe_sange_and_yasha", true))
    {
        id = 153;
    }
    if (!strcmp(ItemName, "item_sange_and_yasha", true))
    {
        id = 154;
    }
    if (!strcmp(ItemName, "item_recipe_satanic", true))
    {
        id = 155;
    }
    if (!strcmp(ItemName, "item_satanic", true))
    {
        id = 156;
    }
    if (!strcmp(ItemName, "item_recipe_mjollnir", true))
    {
        id = 157;
    }
    if (!strcmp(ItemName, "item_mjollnir", true))
    {
        id = 158;
    }
    if (!strcmp(ItemName, "item_recipe_skadi", true))
    {
        id = 159;
    }
    if (!strcmp(ItemName, "item_skadi", true))
    {
        id = 160;
    }
    if (!strcmp(ItemName, "item_recipe_sange", true))
    {
        id = 161;
    }
    if (!strcmp(ItemName, "item_sange", true))
    {
        id = 162;
    }
    if (!strcmp(ItemName, "item_recipe_helm_of_the_dominator", true))
    {
        id = 163;
    }
    if (!strcmp(ItemName, "item_helm_of_the_dominator", true))
    {
        id = 164;
    }
    if (!strcmp(ItemName, "item_recipe_maelstrom", true))
    {
        id = 165;
    }
    if (!strcmp(ItemName, "item_maelstrom", true))
    {
        id = 166;
    }
    if (!strcmp(ItemName, "item_recipe_desolator", true))
    {
        id = 167;
    }
    if (!strcmp(ItemName, "item_desolator", true))
    {
        id = 168;
    }
    if (!strcmp(ItemName, "item_recipe_yasha", true))
    {
        id = 169;
    }
    if (!strcmp(ItemName, "item_yasha", true))
    {
        id = 170;
    }
    if (!strcmp(ItemName, "item_recipe_mask_of_madness", true))
    {
        id = 171;
    }
    if (!strcmp(ItemName, "item_mask_of_madness", true))
    {
        id = 172;
    }
    if (!strcmp(ItemName, "item_recipe_diffusal_blade", true))
    {
        id = 173;
    }
    if (!strcmp(ItemName, "item_recipe_diffusal_blade_2", true))
    {
        id = 195;
    }
    if (!strcmp(ItemName, "item_diffusal_blade", true))
    {
        id = 174;
    }
    if (!strcmp(ItemName, "item_diffusal_blade_2", true))
    {
        id = 196;
    }
    if (!strcmp(ItemName, "item_recipe_ethereal_blade", true))
    {
        id = 175;
    }
    if (!strcmp(ItemName, "item_ethereal_blade", true))
    {
        id = 176;
    }
    if (!strcmp(ItemName, "item_recipe_soul_ring", true))
    {
        id = 177;
    }
    if (!strcmp(ItemName, "item_soul_ring", true))
    {
        id = 178;
    }
    if (!strcmp(ItemName, "item_recipe_arcane_boots", true))
    {
        id = 179;
    }
    if (!strcmp(ItemName, "item_arcane_boots", true))
    {
        id = 180;
    }
    if (!strcmp(ItemName, "item_orb_of_venom", true))
    {
        id = 181;
    }
    if (!strcmp(ItemName, "item_recipe_ancient_janggo", true))
    {
        id = 184;
    }
    if (!strcmp(ItemName, "item_ancient_janggo", true))
    {
        id = 185;
    }
    if (!strcmp(ItemName, "item_recipe_medallion_of_courage", true))
    {
        id = 186;
    }
    if (!strcmp(ItemName, "item_medallion_of_courage", true))
    {
        id = 187;
    }
    if (!strcmp(ItemName, "item_smoke_of_deceit", true))
    {
        id = 188;
    }
    if (!strcmp(ItemName, "item_recipe_veil_of_discord", true))
    {
        id = 189;
    }
    if (!strcmp(ItemName, "item_veil_of_discord", true))
    {
        id = 190;
    }
    if (!strcmp(ItemName, "item_recipe_rod_of_atos", true))
    {
        id = 205;
    }
    if (!strcmp(ItemName, "item_rod_of_atos", true))
    {
        id = 206;
    }
    if (!strcmp(ItemName, "item_recipe_abyssal_blade", true))
    {
        id = 207;
    }
    if (!strcmp(ItemName, "item_abyssal_blade", true))
    {
        id = 208;
    }
    if (!strcmp(ItemName, "item_recipe_heavens_halberd", true))
    {
        id = 209;
    }
    if (!strcmp(ItemName, "item_heavens_halberd", true))
    {
        id = 210;
    }
    if (!strcmp(ItemName, "item_recipe_ring_of_aquila", true))
    {
        id = 211;
    }
    if (!strcmp(ItemName, "item_ring_of_aquila", true))
    {
        id = 212;
    }
    if (!strcmp(ItemName, "item_recipe_tranquil_boots", true))
    {
        id = 213;
    }
    if (!strcmp(ItemName, "item_tranquil_boots", true))
    {
        id = 214;
    }
    if (!strcmp(ItemName, "item_shadow_amulet", true))
    {
        id = 215;
    }
    if (!strcmp(ItemName, "item_halloween_candy_corn", true))
    {
        id = 216;
    }
    if (!strcmp(ItemName, "item_mystery_hook", true))
    {
        id = 217;
    }
    if (!strcmp(ItemName, "item_mystery_arrow", true))
    {
        id = 218;
    }
    if (!strcmp(ItemName, "item_mystery_missile", true))
    {
        id = 219;
    }
    if (!strcmp(ItemName, "item_mystery_toss", true))
    {
        id = 220;
    }
    if (!strcmp(ItemName, "item_mystery_vacuum", true))
    {
        id = 221;
    }
    if (!strcmp(ItemName, "item_halloween_rapier", true))
    {
        id = 226;
    }
    if (!strcmp(ItemName, "item_greevil_whistle", true))
    {
        id = 228;
    }
    if (!strcmp(ItemName, "item_greevil_whistle_toggle", true))
    {
        id = 235;
    }
    if (!strcmp(ItemName, "item_present", true))
    {
        id = 227;
    }
    if (!strcmp(ItemName, "item_winter_stocking", true))
    {
        id = 229;
    }
    if (!strcmp(ItemName, "item_winter_skates", true))
    {
        id = 230;
    }
    if (!strcmp(ItemName, "item_winter_cake", true))
    {
        id = 231;
    }
    if (!strcmp(ItemName, "item_winter_cookie", true))
    {
        id = 232;
    }
    if (!strcmp(ItemName, "item_winter_coco", true))
    {
        id = 233;
    }
    if (!strcmp(ItemName, "item_winter_ham", true))
    {
        id = 234;
    }
    if (!strcmp(ItemName, "item_winter_kringle", true))
    {
        id = 236;
    }
    if (!strcmp(ItemName, "item_winter_mushroom", true))
    {
        id = 237;
    }
    if (!strcmp(ItemName, "item_winter_greevil_treat", true))
    {
        id = 238;
    }
    if (!strcmp(ItemName, "item_winter_greevil_garbage", true))
    {
        id = 239;
    }
    if (!strcmp(ItemName, "item_winter_greevil_chewy", true))
    {
        id = 240;
    }
    if (!strcmp(ItemName, "item_tango_single", true))
    {
        id = 241;
    }
    if (!strcmp(ItemName, "item_crimson_guard", true))
    {
        id = 242;
    }
    if (!strcmp(ItemName, "item_recipe_crimson_guard", true))
    {
        id = 243;
    }
    return id;
}

GetHeroIdByLogName(String:HeroName[])
{
    new id = -1;
    if (!strcmp(HeroName, "\nCOMBAT SUMMARY\n", true))
    {
        id = 0;
    }
    if (!strcmp(HeroName, "--- Anti-Mage ---\n", true))
    {
        id = 1;
    }
    if (!strcmp(HeroName, "--- Axe ---\n", true))
    {
        id = 2;
    }
    if (!strcmp(HeroName, "--- Bane ---\n", true))
    {
        id = 3;
    }
    if (!strcmp(HeroName, "--- Bloodseeker ---\n", true))
    {
        id = 4;
    }
    if (!strcmp(HeroName, "--- Crystal Maiden ---\n", true))
    {
        id = 5;
    }
    if (!strcmp(HeroName, "--- Drow Ranger ---\n", true))
    {
        id = 6;
    }
    if (!strcmp(HeroName, "--- Earthshaker ---\n", true))
    {
        id = 7;
    }
    if (!strcmp(HeroName, "--- Juggernaut ---\n", true))
    {
        id = 8;
    }
    if (!strcmp(HeroName, "--- Mirana ---\n", true))
    {
        id = 9;
    }
    if (!strcmp(HeroName, "--- Shadow Fiend ---\n", true))
    {
        id = 11;
    }
    if (!strcmp(HeroName, "--- Morphling ---\n", true))
    {
        id = 10;
    }
    if (!strcmp(HeroName, "--- Phantom Lancer ---\n", true))
    {
        id = 12;
    }
    if (!strcmp(HeroName, "--- Puck ---\n", true))
    {
        id = 13;
    }
    if (!strcmp(HeroName, "--- Pudge ---\n", true))
    {
        id = 14;
    }
    if (!strcmp(HeroName, "--- Razor ---\n", true))
    {
        id = 15;
    }
    if (!strcmp(HeroName, "--- Sand King ---\n", true))
    {
        id = 16;
    }
    if (!strcmp(HeroName, "--- Storm Spirit ---\n", true))
    {
        id = 17;
    }
    if (!strcmp(HeroName, "--- Sven ---\n", true))
    {
        id = 18;
    }
    if (!strcmp(HeroName, "--- Tiny ---\n", true))
    {
        id = 19;
    }
    if (!strcmp(HeroName, "--- Vengeful Spirit ---\n", true))
    {
        id = 20;
    }
    if (!strcmp(HeroName, "--- Windranger ---\n", true))
    {
        id = 21;
    }
    if (!strcmp(HeroName, "--- Zeus ---\n", true))
    {
        id = 22;
    }
    if (!strcmp(HeroName, "--- Kunkka ---\n", true))
    {
        id = 23;
    }
    if (!strcmp(HeroName, "--- Lina ---\n", true))
    {
        id = 25;
    }
    if (!strcmp(HeroName, "--- Lich ---\n", true))
    {
        id = 31;
    }
    if (!strcmp(HeroName, "--- Lion ---\n", true))
    {
        id = 26;
    }
    if (!strcmp(HeroName, "--- Shadow Shaman ---\n", true))
    {
        id = 27;
    }
    if (!strcmp(HeroName, "--- Slardar ---\n", true))
    {
        id = 28;
    }
    if (!strcmp(HeroName, "--- Tidehunter ---\n", true))
    {
        id = 29;
    }
    if (!strcmp(HeroName, "--- Witch Doctor ---\n", true))
    {
        id = 30;
    }
    if (!strcmp(HeroName, "--- Riki ---\n", true))
    {
        id = 32;
    }
    if (!strcmp(HeroName, "--- Enigma ---\n", true))
    {
        id = 33;
    }
    if (!strcmp(HeroName, "--- Tinker ---\n", true))
    {
        id = 34;
    }
    if (!strcmp(HeroName, "--- Sniper ---\n", true))
    {
        id = 35;
    }
    if (!strcmp(HeroName, "--- Necrophos ---\n", true))
    {
        id = 36;
    }
    if (!strcmp(HeroName, "--- Warlock ---\n", true))
    {
        id = 37;
    }
    if (!strcmp(HeroName, "--- Beastmaster ---\n", true))
    {
        id = 38;
    }
    if (!strcmp(HeroName, "--- Queen of Pain ---\n", true))
    {
        id = 39;
    }
    if (!strcmp(HeroName, "--- Venomancer ---\n", true))
    {
        id = 40;
    }
    if (!strcmp(HeroName, "--- Faceless Void ---\n", true))
    {
        id = 41;
    }
    if (!strcmp(HeroName, "--- Wraith King ---\n", true))
    {
        id = 42;
    }
    if (!strcmp(HeroName, "--- Death Prophet ---\n", true))
    {
        id = 43;
    }
    if (!strcmp(HeroName, "--- Phantom Assassin ---\n", true))
    {
        id = 44;
    }
    if (!strcmp(HeroName, "--- Pugna ---\n", true))
    {
        id = 45;
    }
    if (!strcmp(HeroName, "--- Templar Assassin ---\n", true))
    {
        id = 46;
    }
    if (!strcmp(HeroName, "--- Viper ---\n", true))
    {
        id = 47;
    }
    if (!strcmp(HeroName, "--- Luna ---\n", true))
    {
        id = 48;
    }
    if (!strcmp(HeroName, "--- Dragon Knight ---\n", true))
    {
        id = 49;
    }
    if (!strcmp(HeroName, "--- Dazzle ---\n", true))
    {
        id = 50;
    }
    if (!strcmp(HeroName, "--- Clockwerk ---\n", true))
    {
        id = 51;
    }
    if (!strcmp(HeroName, "--- Leshrac ---\n", true))
    {
        id = 52;
    }
    if (!strcmp(HeroName, "--- Nature's Prophet ---\n", true))
    {
        id = 53;
    }
    if (!strcmp(HeroName, "--- Lifestealer ---\n", true))
    {
        id = 54;
    }
    if (!strcmp(HeroName, "--- Dark Seer ---\n", true))
    {
        id = 55;
    }
    if (!strcmp(HeroName, "--- Clinkz ---\n", true))
    {
        id = 56;
    }
    if (!strcmp(HeroName, "--- Omniknight ---\n", true))
    {
        id = 57;
    }
    if (!strcmp(HeroName, "--- Enchantress ---\n", true))
    {
        id = 58;
    }
    if (!strcmp(HeroName, "--- Huskar ---\n", true))
    {
        id = 59;
    }
    if (!strcmp(HeroName, "--- Night Stalker ---\n", true))
    {
        id = 60;
    }
    if (!strcmp(HeroName, "--- Broodmother ---\n", true))
    {
        id = 61;
    }
    if (!strcmp(HeroName, "--- Bounty Hunter ---\n", true))
    {
        id = 62;
    }
    if (!strcmp(HeroName, "--- Weaver ---\n", true))
    {
        id = 63;
    }
    if (!strcmp(HeroName, "--- Jakiro ---\n", true))
    {
        id = 64;
    }
    if (!strcmp(HeroName, "--- Batrider ---\n", true))
    {
        id = 65;
    }
    if (!strcmp(HeroName, "--- Chen ---\n", true))
    {
        id = 66;
    }
    if (!strcmp(HeroName, "--- Spectre ---\n", true))
    {
        id = 67;
    }
    if (!strcmp(HeroName, "--- Doom ---\n", true))
    {
        id = 69;
    }
    if (!strcmp(HeroName, "--- Ancient Apparition ---\n", true))
    {
        id = 68;
    }
    if (!strcmp(HeroName, "--- Ursa ---\n", true))
    {
        id = 70;
    }
    if (!strcmp(HeroName, "--- Spirit Breaker ---\n", true))
    {
        id = 71;
    }
    if (!strcmp(HeroName, "--- Gyrocopter ---\n", true))
    {
        id = 72;
    }
    if (!strcmp(HeroName, "--- Alchemist ---\n", true))
    {
        id = 73;
    }
    if (!strcmp(HeroName, "--- Invoker ---\n", true))
    {
        id = 74;
    }
    if (!strcmp(HeroName, "--- Silencer ---\n", true))
    {
        id = 75;
    }
    if (!strcmp(HeroName, "--- Outworld Devourer ---\n", true))
    {
        id = 76;
    }
    if (!strcmp(HeroName, "--- Lycan ---\n", true))
    {
        id = 77;
    }
    if (!strcmp(HeroName, "--- Brewmaster ---\n", true))
    {
        id = 78;
    }
    if (!strcmp(HeroName, "--- Shadow Demon ---\n", true))
    {
        id = 79;
    }
    if (!strcmp(HeroName, "--- Lone Druid ---\n", true))
    {
        id = 80;
    }
    if (!strcmp(HeroName, "--- Chaos Knight ---\n", true))
    {
        id = 81;
    }
    if (!strcmp(HeroName, "--- Meepo ---\n", true))
    {
        id = 82;
    }
    if (!strcmp(HeroName, "--- Treant Protector ---\n", true))
    {
        id = 83;
    }
    if (!strcmp(HeroName, "--- Ogre Magi ---\n", true))
    {
        id = 84;
    }
    if (!strcmp(HeroName, "--- Undying ---\n", true))
    {
        id = 85;
    }
    if (!strcmp(HeroName, "--- Rubick ---\n", true))
    {
        id = 86;
    }
    if (!strcmp(HeroName, "--- Disruptor ---\n", true))
    {
        id = 87;
    }
    if (!strcmp(HeroName, "--- Nyx Assassin ---\n", true))
    {
        id = 88;
    }
    if (!strcmp(HeroName, "--- Naga Siren ---\n", true))
    {
        id = 89;
    }
    if (!strcmp(HeroName, "--- Keeper of the Light ---\n", true))
    {
        id = 90;
    }
    if (!strcmp(HeroName, "--- Io ---\n", true))
    {
        id = 91;
    }
    if (!strcmp(HeroName, "--- Visage ---\n", true))
    {
        id = 92;
    }
    if (!strcmp(HeroName, "--- Slark ---\n", true))
    {
        id = 93;
    }
    if (!strcmp(HeroName, "--- Medusa ---\n", true))
    {
        id = 94;
    }
    if (!strcmp(HeroName, "--- Troll Warlord ---\n", true))
    {
        id = 95;
    }
    if (!strcmp(HeroName, "--- Centaur Warrunner ---\n", true))
    {
        id = 96;
    }
    if (!strcmp(HeroName, "--- Magnus ---\n", true))
    {
        id = 97;
    }
    if (!strcmp(HeroName, "--- Timbersaw ---\n", true))
    {
        id = 98;
    }
    if (!strcmp(HeroName, "--- Bristleback ---\n", true))
    {
        id = 99;
    }
    if (!strcmp(HeroName, "--- Tusk ---\n", true))
    {
        id = 100;
    }
    if (!strcmp(HeroName, "--- Skywrath Mage ---\n", true))
    {
        id = 101;
    }
    if (!strcmp(HeroName, "--- Abaddon ---\n", true))
    {
        id = 102;
    }
    if (!strcmp(HeroName, "--- Elder Titan ---\n", true))
    {
        id = 103;
    }
    if (!strcmp(HeroName, "--- Legion Commander ---\n", true))
    {
        id = 104;
    }
    if (!strcmp(HeroName, "--- Ember Spirit ---\n", true))
    {
        id = 106;
    }
    if (!strcmp(HeroName, "--- Earth Spirit ---\n", true))
    {
        id = 107;
    }
    if (!strcmp(HeroName, "--- Terrorblade ---\n", true))
    {
        id = 109;
    }
    if (!strcmp(HeroName, "--- Phoenix ---\n", true))
    {
        id = 110;
    }
    if (!strcmp(HeroName, "--- Oracle ---\n", true))
    {
        id = 111;
    }
    if (!strcmp(HeroName, "--- Techies ---\n", true))
    {
        id = 105;
    }
    if (!strcmp(HeroName, "npc_dota_hero_winter_wyvern", true))
    {
        id = 112;
    }
    return id;
}

Insert_Players(Handle:Connection, Handle:adt_array[], String:starttime[], String:endtime[])
{
    new String:error[1024];
    new String:query[1024];
    new String:MMRquery[200];
    Connection = SQL_DefConnect(error, 1024, true);
    if (Connection)
    {
        new String:steamid[32];
        new i;
        while (i < 10)
        {
        	GetArrayString(adt_array[i], 20, steamid, 32);
        	new result = GetArrayCell(adt_array[i], 23, 0, false);
        	new team = GetArrayCell(adt_array[i], 14, 0, false);
        	new hero = GetArrayCell(adt_array[i], 1, 0, false);
        	new kills = GetArrayCell(adt_array[i], 8, 0, false);
        	new deaths = GetArrayCell(adt_array[i], 9, 0, false);
        	new assists = GetArrayCell(adt_array[i], 10, 0, false);
        	new lhs = GetArrayCell(adt_array[i], 11, 0, false);
        	new denies = GetArrayCell(adt_array[i], 12, 0, false);
        	new networth = GetArrayCell(adt_array[i], 19, 0, false);
        	new level = GetArrayCell(adt_array[i], 13, 0, false);
        	new healing = GetArrayCell(adt_array[i], 25, 0, false);
        	new earned_gold = GetArrayCell(adt_array[i], 28, 0, false);
        	new earned_xp = GetArrayCell(adt_array[i], 29, 0, false);
        	new item1 = GetArrayCell(adt_array[i], 2, 0, false);
        	new item2 = GetArrayCell(adt_array[i], 3, 0, false);
        	new item3 = GetArrayCell(adt_array[i], 4, 0, false);
        	new item4 = GetArrayCell(adt_array[i], 5, 0, false);
        	new item5 = GetArrayCell(adt_array[i], 6, 0, false);
        	new item6 = GetArrayCell(adt_array[i], 7, 0, false);
        	new MMRchange = result * 25;
            Format(query, 1024, "INSERT INTO dotaplayers (steamid,result,team,hero,kills,deaths,assists,networth,level,lhs,denies,healing,earned_gold,earned_xp,item1,item2,item3,item4,item5,item6,time_finished,starttime,endtime) VALUES ('%s','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d',now(),'%s','%s')",steamid,result,team,hero,kills,deaths,assists,networth,level,lhs,denies,healing,earned_gold,earned_xp,item1,item2,item3,item4,item5,item6,starttime,endtime);
            if (!(SQL_Query(Connection, query, -1)))
            {
                    SQL_GetError(Connection, error, 1024);
                    PrintToServer("Failed to Insert in dotaplayers (error: %s)", error);
            }
            Format(MMRquery, 200, "UPDATE leaderboard SET mmr = 'mmr+%d' WHERE steamid = '%s'", MMRchange,steamid);
            if (!(SQL_Query(Connection, MMRquery, -1)))
            {
                    SQL_GetError(Connection, error, 1024);
                    PrintToServer("Failed to update leaderboard (error: %s)", error);
            }
		    i++;
        }
        CreateTimer(30.0, TimerCallBack);
      }
    else
    {
        PrintToServer("Could not connect: %s", error);
    }
    CloseHandle(Connection);
    return 0;
}

public Action:TimerCallBack(Handle:timer)
{
	ServerCommand("quit");
}


public OnPluginStart()
{
    HookEvent("player_team", Joined, EventHookMode:1)
    HookUserMessage(UserMsg:24, MsgHook3, true, MsgPostHook:-1);
    HookEvent("dota_match_done", get_stats, EventHookMode:0);
    adt_log = CreateArray(32, 0);
    new i;
    while (i < 10)
    {
        global_stats[i] = CreateArray(32, 31);
        SetArrayCell(global_stats[i], 0, -1, 0, false);
        i++;
    }
    adt_clients = CreateArray(1, 0);
}

public OnClientConnected(client)
{
	 if(IsClientSourceTV(client))
    {
    	return;
   	}
    new i;
    while (i < 10)
    {
        if (client == GetArrayCell(global_stats[i], 0, 0, false))
        {
            SetArrayCell(global_stats[i], 17, 0, 0, false);
        }
        i++;
    }
}

public OnClientDisconnect(client)
{
    new float:start_time = GameRules_GetPropFloat("m_flGameStartTime", 0);
    new float:game_time = GameRules_GetPropFloat("m_fGameTime", 0);
    new float:time = game_time - start_time;
    new i;
    while (i < 10)
    {
        if (client == GetArrayCell(global_stats[i], 0, 0, false))
        {
            SetArrayCell(global_stats[i], 17, RoundToNearest(time), 0, false);
        }
        i++;
    }
}

public Action:Joined(Handle:event, String:name[], bool:dontBroadcast)
{
    new team = GetEventInt(event, "team");
    new user = GetEventInt(event, "userid");
    new client_index = GetClientOfUserId(user);
    new String:steamid[32];
    new String:ip[32];
    if (team == 2 && FindValueInArray(adt_clients, client_index) == -1 && index_g < 5)
    {
        GetClientAuthId(client_index, AuthIdType:2, steamid, 32, true);
        GetClientIP(client_index, ip, 32, true);
        SetArrayString(global_stats[index_g], 20, steamid);
        SetArrayString(global_stats[index_g], 24, ip);
        SetArrayCell(global_stats[index_g], 0, client_index, 0, false);
        SetArrayCell(global_stats[index_g], 17, 0, 0, false);
        SetArrayCell(global_stats[index_g], 27, GetSteamAccountID(client_index, true), 0, false);
        index_g = index_g + 1;
        PushArrayCell(adt_clients, client_index);
    }

    if (team == 3 && FindValueInArray(adt_clients, client_index) == -1 && index_b < 5)
    {
        GetClientAuthId(client_index, AuthIdType:2, steamid, 32, true);
        GetClientIP(client_index, ip, 32, true);
        SetArrayString(global_stats[index_b + 5], 20, steamid);
        SetArrayString(global_stats[index_b + 5], 24, ip);
        SetArrayCell(global_stats[index_b + 5], 0, client_index, 0, false);
        SetArrayCell(global_stats[index_b + 5], 17, 0, 0, false);
        SetArrayCell(global_stats[index_b + 5], 27, GetSteamAccountID(client_index, true), 0, false);
        index_b = index_b + 1;
        PushArrayCell(adt_clients, client_index);
    }
    return Action:0;
}

public Action:Command_Say(client, String:command[], args)
{
    return Action:0;
}

public Action:get_stats(Handle:event, String:name[], bool:dontBroadcast)
{
    new pr = GetPlayerResourceEntity();
    new spec = FindEntityByClassname(-1, "dota_data_spectator");
    new radiant = FindEntityByClassname(-1, "dota_data_radiant");
    new dire = FindEntityByClassname(-1, "dota_data_dire");
    new id_offset = FindSendPropInfo("CDOTA_PlayerResource", "m_iPlayerSteamIDs");
    new winner = GameRules_GetProp("m_nGameWinner", 4, 0);
    new i;
    new count_g;
    new count_b = 5;
    while (i < 10)
    {
    	new hero_id = GetEntProp(pr, PropType:0, "m_nSelectedHeroID", 4, i);
        new hero_ent = GetEntPropEnt(pr, PropType:0, "m_hSelectedHero", i);
        new team = GetEntProp(pr, PropType:0, "m_iPlayerTeams", 4, i);
        new result = -1;
        new level = GetEntProp(pr, PropType:0, "m_iLevel", 4, i);
        new earned_xp = GetEntProp(pr, PropType:0, "m_iTotalEarnedXP", 4, i);
        new earned_gold = GetEntProp(pr, PropType:0, "m_iTotalEarnedGold", 4, i);
        new kills = GetEntProp(pr, PropType:0, "m_iKills", 4, i);
        new assists = GetEntProp(pr, PropType:0, "m_iAssists", 4, i);
        new deaths = GetEntProp(pr, PropType:0, "m_iDeaths", 4, i);
        new last_hits = GetEntProp(pr, PropType:0, "m_iLastHitCount", 4, i);
        new denies = GetEntProp(pr, PropType:0, "m_iDenyCount", 4, i);
        new towerk = GetEntProp(pr, PropType:0, "m_iTowerKills", 4, i);
        new roshank = GetEntProp(pr, PropType:0, "m_iRoshanKills", 4, i);
        new networth = GetEntProp(spec, PropType:0, "m_iNetWorth", 4, i);
        new hhealing = GetEntPropFloat(pr, PropType:0, "m_fHealing", i);
        new accounts = GetEntData(pr, i * 8 + id_offset, 4);
        new radiant_gold = GetEntProp(radiant, PropType:0, "m_iUnreliableGold", 4, i) + GetEntProp(radiant, PropType:0, "m_iReliableGold", 4, i);
        new dire_gold = GetEntProp(dire, PropType:0, "m_iUnreliableGold", 4, i) + GetEntProp(dire, PropType:0, "m_iReliableGold", 4, i);
        if (team == winner)
        {
        	result = 1;
        }
        new team_gold;
        new gs_index;
        if (team == 2)
        {
        	team_gold = radiant_gold;
        	gs_index = count_g;
       	}
       	else
       	{
       		team_gold = dire_gold;
       		gs_index = count_b;
        }
        SetArrayCell(global_stats[gs_index], 1, hero_id, 0, false);
        SetArrayCell(global_stats[gs_index], 8, kills, 0, false);
        SetArrayCell(global_stats[gs_index], 9, deaths, 0, false);
        SetArrayCell(global_stats[gs_index], 10, assists, 0, false);
        SetArrayCell(global_stats[gs_index], 11, last_hits, 0, false);
        SetArrayCell(global_stats[gs_index], 12, denies, 0, false);
        SetArrayCell(global_stats[gs_index], 13, level, 0, false);
        SetArrayCell(global_stats[gs_index], 14, team, 0, false);
        SetArrayCell(global_stats[gs_index], 15, towerk, 0, false);
        SetArrayCell(global_stats[gs_index], 16, roshank, 0, false);
        SetArrayCell(global_stats[gs_index], 18, team_gold, 0, false);
        SetArrayCell(global_stats[gs_index], 19, networth, 0, false);
        SetArrayCell(global_stats[gs_index], 21, hero_ent, 0, false);
        SetArrayCell(global_stats[gs_index], 23, result, 0, false);
		SetArrayCell(global_stats[gs_index], 25, RoundFloat(hhealing), 0, false);
        SetArrayCell(global_stats[gs_index], 26, accounts, 0, false);
        SetArrayCell(global_stats[gs_index], 29, earned_xp, 0, false);
        SetArrayCell(global_stats[gs_index], 28, earned_gold, 0, false);
        new z;
        while (z < 6)
        {
        	new item = GetEntPropEnt(hero_ent, PropType:0, "m_hItems", z);
            if (!IsValidEntity(item))
            {
                  SetArrayCell(global_stats[gs_index], z + 2, 0, 0, false);
            }
            else
            {
            new String:itemname[64];
            GetEdictClassname(item, itemname, 64);
            SetArrayCell(global_stats[gs_index], z + 2, GetItemIdByName(itemname), 0, false);
            }
            z++;
            
        }
        if (team == 2)
        {
        	count_g++;
       	}
       	else
       	{
       		count_b++;
        }
        i++;
    }
    new end_time = GameRules_GetPropFloat("m_flGameEndTime", 0);
    new start_time = GameRules_GetPropFloat("m_flGameStartTime", 0);
    new String:starttime[32];
    new String:endtime[32]
    FloatToString(start_time, starttime,32);
    FloatToString(end_time, endtime,32);
    Insert_Players(SQLcon, global_stats,starttime,endtime);
    return Action:0;
}

public Action:MsgHook3(UserMsg:msg_id, Handle:bf, players[], playersNum, bool:reliable, bool:init)
{
    if (GameRules_GetProp("m_nGameState", 4, 0) > 5)
    {
        if (indicator && indicator == 1)
        {
            new String:buffer[32];
            PbReadString(bf, "param", buffer, 32, 0);
            PushArrayString(adt_log, buffer);
            if (GetHeroIdByLogName(buffer))
            {
            }
            else
            {
                indicator = indicator + 1;
            }
        }
    }
    return Action:0;
}


