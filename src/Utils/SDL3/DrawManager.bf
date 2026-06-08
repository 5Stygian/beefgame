namespace beefgame.Utils.SDL3;

using System;
using System.Collections;
using System.Diagnostics;
using SDL3;

public class DrawManager<T> where T : IDrawable, delete
{
    // Turns out the problem was the fact that
    // I didn't initialize it :/ 
    private static List<T> Drawables = new List<T>() ~ delete _;

    public static void Render(SDL_Surface* surface)
    {
        for (let Drawable in Drawables)
            Drawable.Render(surface);
    }

    [Inline]
    public static void Add(T rect)
    {
        Drawables.AddFront(rect);
    }

    [Inline]
    public static List<T> GetDrawables()
    {
        return Drawables;
    }
}
