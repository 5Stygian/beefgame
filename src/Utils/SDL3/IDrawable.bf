namespace beefgame.Utils.SDL3;

using SDL3;

public interface IDrawable
{
    public void Render(SDL_Surface* surface);
}
