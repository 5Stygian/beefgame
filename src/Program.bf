namespace beefgame;

using beefgame.Utils;
using System;
using System.Diagnostics;
using SDL3;

public static class Program
{
    public static bool IsRunning = false;
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

        Player player = scope Player(
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
            }

            SDL_PumpEvents();

            if (Utils.TestScanCode(.SDL_SCANCODE_W))
                player.MoveUp();
            if (Utils.TestScanCode(.SDL_SCANCODE_A))
                player.MoveLeft();
            if (Utils.TestScanCode(.SDL_SCANCODE_S))
                player.MoveDown();
            if (Utils.TestScanCode(.SDL_SCANCODE_D))
                player.MoveRight();

            if (Utils.TestScanCode(.SDL_SCANCODE_LCTRL))
            {
                if (Utils.TestScanCode(.SDL_SCANCODE_C))
                    Program.StopRunning();
                if (Utils.TestScanCode(.SDL_SCANCODE_W))
                    Program.Window.DebugDisplay();
            }

            Program.Window.Render();
            testRect.Render(Program.Window.GetSurface());
            player.Render(Program.Window.GetSurface());

            if (player.CheckCollision(testRect))
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
}
