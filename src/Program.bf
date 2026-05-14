namespace beefgame;

using System.Diagnostics;
using SDL3;

public static class Program
{
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

		while (true)
		{
			SDL_Event ev = .();
			while (SDL_PollEvent(&ev))
			{
				if (ev.type == (.)SDL_EventType.SDL_EVENT_QUIT)
					return;
				else if (ev.type == (.)SDL_EventType.SDL_EVENT_KEY_DOWN)
				{
					Debug.WriteLine("{0}", Program.KeyStates[(int)SDL_Scancode.SDL_SCANCODE_W]);
				}
			}
			SDL_Delay(16);
		}
	}
}