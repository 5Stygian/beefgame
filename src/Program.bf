namespace beefgame;

using beefgame.Utils;
using beefgame.Utils.SDL3;
using System;
using System.Diagnostics;
using SDL3;

public static class Program
{
    public static bool IsRunning = false;

    public static Player Player;

    public static WindowWrapper* Window;
    public static bool* KeyStates = SDL_GetKeyboardState(null);

    public static void Main()
    {
        if (!SDL_Init(.SDL_INIT_VIDEO))
        {
            Debug.WriteLine("SDL_Init failed: {0}", SDL_GetError());
            return;
        }
        defer SDL_Quit();

        SDL_Window* window = SDL_CreateWindow("beefgame", 1280, 720, .SDL_WINDOW_RESIZABLE);
        if (window === null)
        {
            Debug.WriteLine("SDL_CreateWindow failed: {0}", SDL_GetError());
            return;
        }
        defer SDL_DestroyWindow(window);

        Program.Window = scope WindowWrapper(window);

        Program.Player = scope Player(
            (int32)Program.Window.CenterX, (int32)Program.Window.CenterY, 20, 20,
            255, 255, 255, 255
        );

        Rect testRect = scope Rect(
            0, 0, 200, (int32)Program.Window.Height,
            255, 0, 0, 255
        );

        Program.StartRunning();
        while (Program.IsRunning)
        {
            SDL_Event Event = SDL_Event();
            while (SDL_PollEvent(&Event))
            {
                if (Utils.TestEventType(Event, .SDL_EVENT_QUIT))
                    Program.StopRunning();

                if (Utils.TestEventType(Event, .SDL_EVENT_WINDOW_RESIZED))
                    Program.Window.UpdateMembers();

                if (Utils.TestEventType(Event, .SDL_EVENT_KEY_DOWN))
                {
                    if (Utils.IsKeyClicked(Event, .SDL_SCANCODE_SPACE) && !Program.Player.IsDodging)
                        Program.Player.Dodge();
                }
                if (Utils.TestEventType(Event, .SDL_EVENT_KEY_UP))
                {
                    if (Program.Player.IsDodging === true)
                        Program.Player.IsDodging = false;
                }
            }

            SDL_PumpEvents();

            Program.Player.Move();

            Program.CheckKeybinds();

            Program.Window.Render();
            testRect.Render(Program.Window.GetSurface());
            Program.Player.Render(Program.Window.GetSurface());

            if (Program.Player.CheckCollision(testRect))
                Program.Window.ChangeBackgroundColor(128, 128, 128);
            else
                Program.Window.ChangeBackgroundColor(0, 0, 0);

            Program.Window.Update();

            SDL_Delay(16);
        }
    }

    [Inline]
    public static void StartRunning()
    {
        Program.IsRunning = true;
    }

    [Inline]
    public static void StopRunning()
    {
        Program.IsRunning = false;
    }

    [Inline]
    public static void CheckKeybinds()
    {
        if (Utils.IsKeyHeld(.SDL_SCANCODE_LCTRL))
        {
            if (Utils.IsKeyHeld(.SDL_SCANCODE_C))
                Program.StopRunning();
            if (Utils.IsKeyHeld(.SDL_SCANCODE_W))
                Program.Window.DebugDisplay();
        }

        if (Utils.IsKeyHeld(.SDL_SCANCODE_LALT))
        {
            if (Utils.IsKeyHeld(.SDL_SCANCODE_V))
                Debug.WriteLine("{}", Program.Player.Direction);
        }
    }
}
