namespace beefgame.Utils;

using System;
using System.Diagnostics;
using SDL3;

public static class Utils
{
    [Inline]
    public static bool TestScanCode(SDL_Scancode ScanCode)
    {
        return Program.KeyStates[(int)ScanCode];
    }
    
    [Inline]
    public static bool TestEventType(SDL_Event Event, SDL_EventType EventType)
    {
        return (Event.type === (uint32)EventType);
    }
}
