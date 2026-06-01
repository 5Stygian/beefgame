namespace beefgame.Utils;

using System;
using System.Diagnostics;
using SDL3;

public static class Utils
{
    [Inline]
    public static bool IsKeyHeld(SDL_Scancode Scancode)
    {
        return Program.KeyStates[(int)Scancode];
    }

    [Inline]
    public static bool IsKeyClicked(SDL_Event Event, SDL_Scancode Scancode)
    {
        return Program.KeyStates[(int)Scancode] && !Event.key.repeat;
    }
    
    [Inline]
    public static bool TestEventType(SDL_Event Event, SDL_EventType EventType)
    {
        return (Event.type === (uint32)EventType);
    }
}
