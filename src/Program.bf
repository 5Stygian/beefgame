namespace beefgame;

using System.Diagnostics;
using SDL3;

public static class Program
{
	public static bool IsRunning = true;
	public static bool* KeyStates = SDL_GetKeyboardState(null);

	public static void Main()
	{
		if (!SDL_Init(.SDL_INIT_VIDEO))
		{
			Debug.WriteLine("SDL_Init failed: {0}", SDL_GetError());
			return;
		}
		defer SDL_Quit();

		let window = SDL_CreateWindow("beefgame", 1280, 720, .SDL_WINDOW_RESIZABLE);
		if (window == null)
		{
			Debug.WriteLine("SDL_CreateWindow failed: {0}", SDL_GetError());
			return;
		}
		defer SDL_DestroyWindow(window);

		while (Program.IsRunning)
		{
			SDL_Event ev = .();
			while (SDL_PollEvent(&ev))
			{
				if (ev.type == (.)SDL_EventType.SDL_EVENT_QUIT)
					return;
			}

			SDL_PumpEvents();

			if (Program.KeyStates[SDL_Scancode.SDL_SCANCODE_ESCAPE])
				Program.IsRunning = false;
			
			SDL_Delay(16);
		}
	}
}
