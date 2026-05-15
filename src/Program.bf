namespace beefgame;

using System.Diagnostics;
using SDL3;

public static class Program
{
    public static bool IsRunning = false;
    public static bool* KeyStates = SDL_GetKeyboardState(null);

    public static WindowStatsStruct* WindowStats;

    public static void Main()
    {
        if (!SDL_Init(.SDL_INIT_VIDEO))
        {
            Debug.WriteLine("SDL_Init failed: {0}", SDL_GetError());
            return;
        }
        defer SDL_Quit();

        SDL_Window* window = SDL_CreateWindow("beefgame", 1280, 720, .SDL_WINDOW_RESIZABLE);
        if (window == null)
        {
            Debug.WriteLine("SDL_CreateWindow failed: {0}", SDL_GetError());
            return;
        }
        defer SDL_DestroyWindow(window);
        Program.WindowStats = scope WindowStatsStruct(window);

        Program.StartRunning();
        while (Program.IsRunning)
        {
            SDL_Event Event = SDL_Event();
            while (SDL_PollEvent(&Event))
            {
                if (Utils.TestEventType(Event, .SDL_EVENT_QUIT))
                    Program.StopRunning();

                if (Utils.TestEventType(Event, .SDL_EVENT_WINDOW_RESIZED))
                    Program.WindowStats.RefreshStats();
            }

            SDL_PumpEvents();

            if (Utils.TestScanCode(.SDL_SCANCODE_LCTRL))
            {
                if (Utils.TestScanCode(.SDL_SCANCODE_C))
                    Program.StopRunning();
                if (Utils.TestScanCode(.SDL_SCANCODE_W))
                    Program.WindowStats.Display();
            }

            SDL_Delay(16);
        }
    }

    public static void StartRunning()
    {
        Program.IsRunning = true;
    }

    public static void StopRunning()
    {
        Program.IsRunning = false;
    }
}
