namespace beefgame;

using System.Diagnostics;
using SDL3;

public class Player
{
    public static float PLAYER_SIZE = 20f;

    public SDL_FRect Sprite = SDL_FRect();

    public this()
    {
        this.Sprite.w = Player.PLAYER_SIZE;
        this.Sprite.h = Player.PLAYER_SIZE;
        this.Sprite.x = Program.WindowStats.CenterX;
        this.Sprite.y = Program.WindowStats.CenterY;
    }

    public void Render()
    {

    }
}