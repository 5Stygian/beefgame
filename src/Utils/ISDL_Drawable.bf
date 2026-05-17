namespace beefgame.Utils;

using SDL3;

public interface ISDL_Drawable
{
    public void Render(SDL_Surface* surface);
}