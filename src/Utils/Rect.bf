namespace beefgame.Utils;

using SDL3;

public class Rect : IDrawable
{
    public static int32 MoveSpeed = 10;

    private SDL_Rect Rect;
    private SDL_Color Color;

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

    public void MoveRight()
    {
        this.Rect.x += Player.MoveSpeed;
    }
    public void MoveDown()
    {
        this.Rect.y += Player.MoveSpeed;
    }
    public void MoveLeft()
    {
        this.Rect.x -= Player.MoveSpeed;
    }
    public void MoveUp()
    {
        this.Rect.y -= Player.MoveSpeed;
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