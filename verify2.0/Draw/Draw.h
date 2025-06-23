#include "imgui/Recto.hpp"

void RenderLine(const ImVec2& from, const ImVec2& to, ImColor Color, float thickness)
{
    ImDrawList* draw_list = ImGui::GetForegroundDrawList();
    draw_list->AddLine(from, to, Color, thickness);
}

void DrawBox(float X, float Y, float W, float H, ImColor Color, float curve, float thickness)
{
    Recto rect = { X, Y, W, H };
    RenderLine(ImVec2(rect.x, rect.y), ImVec2(rect.x + (rect.w / 3), rect.y), Color, thickness);
    RenderLine(ImVec2(rect.x + rect.w, rect.y), ImVec2((rect.x + rect.w) - (rect.w / 3), rect.y), Color, thickness);
    RenderLine(ImVec2(rect.x, rect.y + rect.h), ImVec2((rect.x + (rect.w / 3)), rect.y + rect.h), Color, thickness);
    RenderLine(ImVec2(rect.x + rect.w, rect.y + rect.h), ImVec2((rect.x + rect.w) - (rect.w / 3), rect.y + rect.h), Color, thickness);
    RenderLine(ImVec2(rect.x, rect.y), ImVec2(rect.x, rect.y + (rect.h / 6)), Color, thickness);
    RenderLine(ImVec2(rect.x, rect.y + rect.h), ImVec2(rect.x, (rect.y + rect.h) - (rect.h / 6)), Color, thickness);
    RenderLine(ImVec2(rect.x + rect.w, rect.y), ImVec2(rect.x + rect.w, rect.y + (rect.h / 6)), Color, thickness);
    RenderLine(ImVec2(rect.x + rect.w, rect.y + rect.h), ImVec2(rect.x + rect.w, (rect.y + rect.h) - (rect.h / 6)), Color, thickness);
}

void DrawText2(ImFont* _espFont, float fontSize, ImVec2 position, ImColor Color, const char* text, ImColor colorFilled)
{
    ImGui::GetBackgroundDrawList()->AddRectFilled(ImVec2(position.x - 3, position.y - 3), ImVec2(position.x + _espFont->CalcTextSizeA(fontSize, MAXFLOAT, 0.0f, text).x + 3, position.y + 12), colorFilled, 0, 0);
    ImDrawList* draw_list = ImGui::GetForegroundDrawList();
    draw_list->AddText(NULL, fontSize, position, Color, text);
}

void drawRectFilledWithPos(ImVec2 pos, ImVec2 size, ImColor color)
{
    ImGui::GetBackgroundDrawList()->AddRectFilled(pos, ImVec2(pos.x + size.x, pos.y + size.y), color, 0, 0);
}

void hpasddsfhjdjhsbsd(float hp, float maxHp, float xh, float yh, float boxWidth, float boxHeight)
{
    float rate = 1.0f * hp / maxHp;
    float width = boxWidth;
    float height = boxHeight;
    float x = xh - width * 0.5;
    float y = yh - height - 0;
    ImColor color = ImColor(0, 255, 0);
    if (rate < 0.35) color = ImColor(255, 0, 0);
    else if (rate < 0.75) color = ImColor(255, 165, 0);
    drawRectFilledWithPos(ImVec2(x, y), ImVec2(width * rate, height), color);
}

void drawHealth(Recto rect, int curHP, int maxHP)
{
    float r, g, b, a = 1.0f;
    float darkR = 0.0f, darkG = 0.0f, darkB = 0.0f, darkA = 0.6f;

    if (maxHP <= 0) return;

    if (curHP >= 70)
    {
        r = 0.0f; g = 1.0f; b = 0.0f;
    }
    else if (curHP >= 40)
    {
        r = 1.0f; g = 0.843f; b = 0.0f;
    }
    else
    {
        r = 1.0f; g = 0.0f; b = 0.0f;
    }

    float healthRatio = static_cast<float>(curHP) / maxHP;
    float barWidth = 2.8f;
    float barX = rect.x - barWidth - 3;
    float barYBottom = rect.y + rect.h;
    float barYTop = rect.y;

    ImGui::GetBackgroundDrawList()->AddRectFilled(
        ImVec2(barX, barYBottom), 
        ImVec2(barX + barWidth, barYTop), 
        ImColor(darkR, darkG, darkB, darkA)
    );

    float healthBarHeight = rect.h * healthRatio;
    ImGui::GetBackgroundDrawList()->AddRectFilled(
        ImVec2(barX, barYBottom), 
        ImVec2(barX + barWidth, barYBottom - healthBarHeight), 
        ImColor(r, g, b, a)
    );
}

void DrawBoxWithNameAndDistance(const char* name, float distance, float X, float Y, float W, float H, ImColor Color, float curve, float thickness)
{
    DrawBox(X, Y, W, H, Color, curve, thickness);

    ImVec2 namePos(X + W / 2, Y - 15);
    DrawText2(nullptr, 12.0f, namePos, ImColor(255, 255, 255), name, ImColor(0, 0, 0, 128));

    ImVec2 distancePos(X + W / 2, Y + H + 5);
    char distanceBuffer[64];
    snprintf(distanceBuffer, sizeof(distanceBuffer), "%.2f m", distance);
    DrawText2(nullptr, 12.0f, distancePos, ImColor(255, 255, 255), distanceBuffer, ImColor(0, 0, 0, 128));
}
