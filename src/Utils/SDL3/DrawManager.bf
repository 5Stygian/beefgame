namespace beefgame.Utils.SDL3;

using System;
using System.Collections;
using SDL3;

public static class DrawManager
{
    private static List<Rect> Rects;

    public static void Render(SDL_Surface* surface)
    {
    }

    [Inline]
    public static void Add(Rect rect)
    {
        Rects.Add(rect);
    }
}
