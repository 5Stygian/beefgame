namespace beefgame.Utils;

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
        this.Window = window;
        this.UpdateMembers();
    }

    public void UpdateMembers() mut {
        if (!SDL_GetWindowSizeInPixels(this.Window, (int32*)&this.Width, (int32*)&this.Height))
            Debug.WriteLine("SDL_GetWindowSizeInPixels failed: {0}", SDL_GetError());

        this.Title = SDL_GetWindowTitle(this.Window);
        this.Flags = SDL_GetWindowFlags(this.Window);

        this.CenterX = this.Width / 2;
        this.CenterY = this.Height / 2;
    }

    public void DebugDisplay() mut
    {
        Debug.WriteLine(
            "<\nWindow {0}:\nDimensions: ({1}, {2})\nCenter: ({3}, {4})\nTitle: {5}\nFlags: {6}\nBackground Color: ({7}, {8}, {9})\n>",
            &this.Window,
            this.Width,
            this.Height,
            this.CenterX,
            this.CenterY,
            &this.Title,
            this.Flags,
            this.r, this.g, this.b
        );
    }

    public void Render()
    {
        SDL_FillSurfaceRect(
            this.GetSurface(),
            null,
            SDL_MapRGB(
                SDL_GetPixelFormatDetails(this.GetPixelFormat()),
                null,
                this.r, this.g, this.b
            )
        );
    }

    public void ChangeBackgroundColor(uint8 r, uint8 g, uint8 b) mut
    {
        this.r = r;
        this.g = g;
        this.b = b;
    }

    [Inline]
    public void Update() {
        SDL_UpdateWindowSurface(this.Window);
    }

    [Inline]
    public SDL_Surface* GetSurface()
    {
        return SDL_GetWindowSurface(this.Window);
    }

    [Inline]
    public SDL_PixelFormat GetPixelFormat()
    {
        return SDL_GetWindowSurface(this.Window).format;
    }
}