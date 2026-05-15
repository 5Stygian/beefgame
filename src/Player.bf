namespace beefgame;

using SDL3;

public class Player
{
    SDL_FRect Sprite;

    public this()
    {
        this.Sprite = SDL_FRect();
    }
}