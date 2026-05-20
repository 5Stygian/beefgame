namespace beefgame.Utils.SDL3;

using SDL3;

public class Rect : IDrawable
{
    protected SDL_Rect Rect;
    protected SDL_Color Color;

    protected SDL_Rect CollisionResult;

    public this(int32 x, int32 y, int32 w, int32 h, uint8 r, uint8 g, uint8 b, uint8 a)
    {
        this.Rect = *scope SDL_Rect();
        this.Rect.x = x;
        this.Rect.y = y;
        this.Rect.w = w;
        this.Rect.h = h;

        this.Color = *scope SDL_Color();
        this.Color.r = r;
        this.Color.g = g;
        this.Color.b = b;
        this.Color.a = a;

        this.CollisionResult = *scope SDL_Rect();
    }

    public void Render(SDL_Surface* surface)
    {
        SDL_FillSurfaceRect(
            surface,
            &this.Rect,
            SDL_MapRGB(
                SDL_GetPixelFormatDetails(surface.format),
                null,
                this.Color.r, this.Color.g, this.Color.b
            )
        );
    }

    [Inline]
    public bool CheckCollision(Rect other)
    {
        return SDL_GetRectIntersection(&this.Rect, &other.Rect, &this.CollisionResult);
    }

    [Inline]
    public void ModX(int32 x)
    {
        this.Rect.x += x;
    }
    [Inline]
    public void ModY(int32 y)
    {
        this.Rect.y += y;
    }

    [Inline]
    public SDL_Color GetColor()
    {
        return this.Color;
    }
    [Inline]
    public void SetColor(SDL_Color color)
    {
        this.Color = color;
    }
    [Inline]
    public void SetColor(uint8 r, uint8 g, uint8 b, uint8 a)
    {
        this.Color.r = r;
        this.Color.g = g;
        this.Color.b = b;
        this.Color.a = a;
    }
}
