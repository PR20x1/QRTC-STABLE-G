#pragma once

namespace CheatState
{
    // General Settings
    extern bool stream_mode;
    extern bool hide_top_label;
    extern bool hide_top_NumPlayer;
    extern int style_idx;

    // Aimbot Settings
    extern bool enable_aimbot;
    extern bool delay_Aim;
    extern bool enable_smooth_aim;
    extern int aim_target; // 0: Closest, 1: Inside FOV, 2: FOV Aim Lock
    extern int aim_location; // 0: Head, 1: Chest, 2: Legs
    extern int aim_trigger; // 0: Always, 1: Firing, 2: Aiming
    extern int aim_visual_style; // 0: Circle, 1: Line
    extern float aim_speed; // Aim speed (degrees per second)
    extern float smoothness_factor; // Smoothness factor for smooth aiming
    extern float max_distance; // Max distance for Aimbot
    extern bool enable_circleFov; // Enable FOV circle
    extern int circleSizeValue; // Size of the FOV circle

    // ESP Settings
    extern bool show_esp;
    extern bool show_esplines;
    extern bool show_espboxes;
    extern bool show_esp_health;
    extern bool show_esp_name;
    extern bool show_esp_distance;
    extern bool show_espinfo; // Additional ESP info
    extern int distanceValue; // Max distance for ESP
    extern float esp_font_size; // Font size for ESP text
    extern float colorEsp[3]; // Main ESP color (RGB)
    extern float colorLines[3]; // Lines color
    extern float colorBoxes[3]; // Boxes color
    extern float colorName[3]; // Name color
    extern float colorDistance[3]; // Distance color
    extern int line_position; // 0: Up, 1: Down
    extern int box_style; // 0: UI 1, 1: UI 2
    extern bool filled_box; // Whether to fill the ESP box with color
    extern float boxFillColor[4]; // Box fill color with alpha
    
    // Player Counters
    extern int player_count;
    extern int bot_count;

    // Recoil and Bullet Tracking
    extern bool enable_recoil;
    extern bool enable_bullet_tracking;
    extern float recoil_amount; // Amount of downward recoil compensation
    extern int weapon_type; // 0: AR, 1: SMG, 2: Sniper, 3: Shotgun, 4: LMG

    // Menu Navigation
    extern int currentPage; // 0: Aimbot, 1: ESP, 2: Config
    extern int selectedTab; // For menu tab selection
    extern float visibilityColor[3]; // RGB color for visibility indication
}
