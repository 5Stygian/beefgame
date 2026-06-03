namespace beefgame.Utils.SDL3;

using beefgame.Utils;
using SDL3;

public static class DrawManager
{
    private static DynamicArray<Rect> Rects;

    public static void Render(SDL_Surface* surface)
    {
        for (var i = 0; i < DrawManager.Rects.GetSize(); i++)
        {
            DrawManager.Get(i).Render(surface);
        }
    }

    // this is allegedly where the EXCEPTION_ACCESS_VIOLATION comes from
    public static void Add(Rect rect)
    {
        Rects.PushBack(rect);
    }

    public static Rect Get(int index)
    {
        return Rects.GetAt(index);
    }
}