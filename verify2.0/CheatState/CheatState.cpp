namespace CheatState
{
    // General Settings
    bool stream_mode = false;
    bool hide_top_label = true;
    bool hide_top_NumPlayer = false;
    int style_idx = 0;

    // Aimbot Settings
    bool enable_aimbot = false;
    bool delay_Aim = false;
    bool enable_smooth_aim = false;
    int aim_target = 0; // 0: Closest, 1: Inside FOV, 2: FOV Aim Lock
    int aim_location = 0; // 0: Head, 1: Chest, 2: Legs
    int aim_trigger = 0; // 0: Always, 1: Firing, 2: Aiming
    int aim_visual_style = 0; // 0: Circle, 1: Line
    float aim_speed = 7.5f; // Aim speed (degrees per second)
    float smoothness_factor = 0.5f; // Smoothness factor for smooth aiming
    float max_distance = 500.0f; // Max distance for Aimbot
    bool enable_circleFov = false; // Enable FOV circle
    int circleSizeValue = 40; // Size of the FOV circle

    // ESP Settings
    bool show_esp = false;
    bool show_esplines = false;
    bool show_espboxes = false;
    bool show_esp_health = false;
    bool show_esp_name = false;
    bool show_esp_distance = false;
    bool show_espinfo = false; // Additional ESP info
    int distanceValue = 120; // Max distance for ESP
    float esp_font_size = 16.0f; // Default ESP font size
    float colorEsp[3] = {1.0f, 1.0f, 1.0f}; // White ESP color
    float colorLines[3] = {1.0f, 0.0f, 0.0f}; // Red lines
    float colorBoxes[3] = {0.0f, 1.0f, 0.0f}; // Green boxes
    float colorName[3] = {1.0f, 1.0f, 0.0f}; // Yellow names
    float colorDistance[3] = {1.0f, 0.65f, 0.0f}; // Orange distance
    int line_position = 0; // 0: Up, 1: Down
    int box_style = 0; // 0: UI 1, 1: UI 2
    bool filled_box = false; // Whether to fill ESP box with color
    float boxFillColor[4] = {0.0f, 0.0f, 0.0f, 0.3f}; // Black fill with 30% alpha
    
    // Player Counters
    int player_count = 0;
    int bot_count = 0;

    // Recoil and Bullet Tracking
    bool enable_recoil = false;
    bool enable_bullet_tracking = false;
    float recoil_amount = 1.0f; // Default recoil compensation
    int weapon_type = 0; // Default to AR

    // Menu Navigation
    int currentPage = 0; // 0: Aimbot, 1: ESP, 2: Config
    int selectedTab = 0; // Default to first tab
    float visibilityColor[3] = {0.0f, 1.0f, 0.0f}; // Default to green (visible)
}
