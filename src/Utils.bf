namespace beefgame;

using System;
using System.Diagnostics;
using SDL3;

public static class Utils
{
    public static bool TestScanCode(SDL_Scancode ScanCode)
    {
        return Program.KeyStates[(int)ScanCode];
    }

    public static bool TestEventType(SDL_Event Event, SDL_EventType EventType)
    {
        return (Event.type === (uint32)EventType);
    }
}

public struct WindowStatsStruct
{
    public char8* Title = "";
    public int Width = 0;
    public int Height = 0;
    public SDL_WindowFlags Flags = (SDL_WindowFlags)0; // Surely this is best practice.

    public int CenterX = 0;
    public int CenterY = 0;

    public SDL_Window* Window;

    public this(SDL_Window* window)
    {
        this.Window = window;
        this.RefreshStats();
    }

    public void RefreshStats() mut {
        if (!SDL_GetWindowSizeInPixels(this.Window, (int32*)&this.Width, (int32*)&this.Height))
            Debug.WriteLine("SDL_GetWindowSizeInPixels failed: {0}", SDL_GetError());

        this.Title = SDL_GetWindowTitle(this.Window);
        this.Flags = SDL_GetWindowFlags(this.Window);

        this.CenterX = this.Width / 2;
        this.CenterY = this.Height / 2;
    }

    public void Display() mut
    {
        Debug.WriteLine(
            "<\nWindow {0}:\nDimensions: ({1}, {2})\nCenter: ({3}, {4})\nTitle: {5}\nFlags: {6}\n>",
            &this.Window,
            this.Width,
            this.Height,
            this.CenterX,
            this.CenterY,
            &this.Title,
            this.Flags
        );
    }
}
