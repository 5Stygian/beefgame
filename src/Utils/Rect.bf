namespace beefgame.Utils;

using SDL3;

public class Rect
{
    private SDL_Rect Rect;
    private SDL_Color Color;

    public this(int x, int y, int w, int h, int r, int g, int b, int a)
    {
        this.Rect = *scope SDL_Rect();
        this.Rect.x = (int32)x;
        this.Rect.y = (int32)y;
        this.Rect.w = (int32)w;
        this.Rect.h = (int32)h;

        this.Color = *scope SDL_Color();
        this.Color.r = (uint8)r;
        this.Color.g = (uint8)g;
        this.Color.b = (uint8)b;
        this.Color.a = (uint8)a;
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

    public SDL_Color GetColor()
    {
        return this.Color;
    }

    public void SetColor(SDL_Color color)
    {
        this.Color = color;
    }
    public void SetColor(uint8 r, uint8 g, uint8 b, uint8 a)
    {
        this.Color.r = r;
        this.Color.g = g;
        this.Color.b = b;
        this.Color.a = a;
    }
}