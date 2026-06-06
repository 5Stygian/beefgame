namespace beefgame.Utils.SDL3;

using System;
using System.Diagnostics;
using SDL3;

public struct WindowWrapper
{
    public char8* Title = "";
    public int Width = 0;
    public int Height = 0;
    public SDL_WindowFlags Flags = (SDL_WindowFlags)0; // Surely this is best practice.

    public int CenterX = 0;
    public int CenterY = 0;

    public uint8 r = 0;
    public uint8 g = 0;
    public uint8 b = 0;

    public SDL_Window* Window;

    public this(SDL_Window* window)
    {
        Window = window;
        UpdateMembers();
    }

    [Inline]
    public void UpdateMembers() mut {
        if (!SDL_GetWindowSizeInPixels(Window, (int32*)&Width, (int32*)&Height))
            Debug.WriteLine("SDL_GetWindowSizeInPixels failed: {0}", SDL_GetError());

        Title = SDL_GetWindowTitle(Window);
        Flags = SDL_GetWindowFlags(Window);

        CenterX = Width / 2;
        CenterY = Height / 2;
    }

    [Inline]
    public void DebugDisplay() mut
    {
        Debug.WriteLine(
            "<\nWindow {0}:\nDimensions: ({1}, {2})\nCenter: ({3}, {4})\nTitle: {5}\nFlags: {6}\nBackground Color: ({7}, {8}, {9})\n>",
            &Window,
            Width,
            Height,
            CenterX,
            CenterY,
            &Title,
            Flags,
            r, g, b
        );
    }

    [Inline]
    public void Render()
    {
        SDL_FillSurfaceRect(
            GetSurface(),
            null,
            SDL_MapRGB(
                SDL_GetPixelFormatDetails(GetPixelFormat()),
                null,
                r, g, b
            )
        );
    }

    [Inline]
    public void ChangeBackgroundColor(uint8 r, uint8 g, uint8 b) mut
    {
        this.r = r;
        this.g = g;
        this.b = b;
    }

    [Inline]
    public void Update() {
        SDL_UpdateWindowSurface(Window);
    }

    [Inline]
    public SDL_Surface* GetSurface()
    {
        return SDL_GetWindowSurface(Window);
    }

    [Inline]
    public SDL_PixelFormat GetPixelFormat()
    {
        return SDL_GetWindowSurface(Window).format;
    }
}
