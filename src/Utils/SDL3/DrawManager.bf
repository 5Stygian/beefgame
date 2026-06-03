namespace beefgame.Utils.SDL3;

using SDL3;

public static class DrawManager
{
    private static int MaxRectIndex = 0;
    private static int Size = 8;
    private static Rect[] Rects = new Rect[Size] ~ delete _;

    public static void Render(SDL_Surface* surface)
    {
        for (var i = 0; i < DrawManager.MaxRectIndex; i++)
        {
            DrawManager.Get(i).Render(surface);
        }
    }

    public static void Add(Rect rect)
    {
        Rects[MaxRectIndex] = rect;
        MaxRectIndex++;
    }

    public static Rect Get(int index)
    {
        return Rects[index];
    }
}