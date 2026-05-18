namespace beefgame.Utils;

using SDL3;

public interface IDrawable
{
    public void Render(SDL_Surface* surface);
}