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
    public static SDL_Renderer* Renderer;
    public static bool* KeyStates = SDL_GetKeyboardState(null);

    private static SDL_Window* _Window;

    public static void Main()
    {
        if (!SDL_Init(.SDL_INIT_VIDEO))
        {
            Debug.WriteLine("SDL_Init failed: {0}", SDL_GetError());
            return;
        }
        defer SDL_Quit();

        /*SDL_Window* window = SDL_CreateWindow("beefgame", 1280, 720, .SDL_WINDOW_RESIZABLE);
        if (window === null)
        {
            Debug.WriteLine("SDL_CreateWindow failed: {0}", SDL_GetError());
            return;
        }
        defer SDL_DestroyWindow(window);*/

        if (!SDL_CreateWindowAndRenderer("beefgame", 1280, 720, .SDL_WINDOW_RESIZABLE, &_Window, &Renderer))
        {
            Debug.WriteLine("SDL_CreateWindowAndRenderer failed: {0}", SDL_GetError());
            return;
        }
        defer SDL_DestroyWindow(_Window)

        Window = scope WindowWrapper(_Window);

        Killbox testKillbox = scope Killbox(
            0, 0, 200, (int32)Window.Height
        );

        Player = scope Player(
            (int32)Window.CenterX, (int32)Window.CenterY, 20, 20,
            255, 255, 255, 255
        );

        StartRunning();
        while (IsRunning)
        {
            SDL_Event Event = SDL_Event();
            while (SDL_PollEvent(&Event))
            {
                if (Utils.TestEventType(Event, .SDL_EVENT_QUIT))
                    StopRunning();

                if (Utils.TestEventType(Event, .SDL_EVENT_WINDOW_RESIZED))
                    Window.UpdateMembers();

                if (Utils.TestEventType(Event, .SDL_EVENT_KEY_DOWN))
                {
                    if (Utils.IsKeyClicked(Event, .SDL_SCANCODE_SPACE) && !Player.IsDodging)
                        Player.Dodge();
                }
                if (Utils.TestEventType(Event, .SDL_EVENT_KEY_UP))
                {
                    if (!Utils.IsKeyHeld(.SDL_SCANCODE_SPACE))
                        Player.IsDodging = false;
                }
            }

            SDL_PumpEvents();

            Player.Move();

            CheckKeybinds();

            Window.Render();

            DrawManager<Rect>.Render(Window.GetSurface());

            if (Player.CheckCollision(testKillbox))
                Window.ChangeBackgroundColor(128, 128, 128);
            else
                Window.ChangeBackgroundColor(0, 0, 0);

            Window.Update();

            SDL_Delay(16);
        }
    }

    [Inline]
    public static void StartRunning()
    {
        IsRunning = true;
    }

    [Inline]
    public static void StopRunning()
    {
        IsRunning = false;
    }

    [Inline]
    public static void CheckKeybinds()
    {
        if (Utils.IsKeyHeld(.SDL_SCANCODE_LCTRL))
        {
            if (Utils.IsKeyHeld(.SDL_SCANCODE_C))
                StopRunning();
            if (Utils.IsKeyHeld(.SDL_SCANCODE_W))
                Window.DebugDisplay();
        }

        if (Utils.IsKeyHeld(.SDL_SCANCODE_LALT))
        {
            if (Utils.IsKeyHeld(.SDL_SCANCODE_V))
                Debug.WriteLine("{}", Player.Direction);
        }
    }
}
