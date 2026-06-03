namespace beefgame.Utils.SDL3;

using beefgame.Utils.SDL3;
using SDL3;
using System;

public class Rect : IDrawable
{
    public SDL_Rect Rect;

    protected SDL_Color Color;

    private SDL_Rect CollisionResult;

    public this(int32 x, int32 y, int32 w, int32 h, uint8 r, uint8 g, uint8 b, uint8 a)
    {
        Rect = *scope SDL_Rect();
        Rect.x = x;
        Rect.y = y;
        Rect.w = w;
        Rect.h = h;

        Color = *scope SDL_Color();
        Color.r = r;
        Color.g = g;
        Color.b = b;
        Color.a = a;

        CollisionResult = *scope SDL_Rect();

        DrawManager<Rect>.Add(this);
    }

    [Inline]
    public void Render(SDL_Surface* surface)
    {
        SDL_FillSurfaceRect(
            surface,
            &Rect,
            SDL_MapRGB(
                SDL_GetPixelFormatDetails(surface.format),
                null,
                Color.r, Color.g, Color.b
            )
        );
    }

    [Inline]
    public bool CheckCollision(Rect other)
    {
        return SDL_GetRectIntersection(&Rect, &other.Rect, &CollisionResult);
    }

    [Inline]
    public void ModX(int32 x)
    {
        Rect.x += x;
    }
    [Inline]
    public void ModY(int32 y)
    {
        Rect.y += y;
    }

    [Inline]
    public SDL_Color GetColor()
    {
        return Color;
    }
    [Inline]
    public void SetColor(SDL_Color color)
    {
        Color = color;
    }
    [Inline]
    public void SetColor(uint8 r, uint8 g, uint8 b, uint8 a)
    {
        Color.r = r;
        Color.g = g;
        Color.b = b;
        Color.a = a;
    }
}
