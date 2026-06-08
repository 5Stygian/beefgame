namespace beefgame;

using beefgame.Utils;
using beefgame.Utils.SDL3;
using System;
using System.Diagnostics;

public class Player : Rect
{
    private static int32 MoveSpeed = 10;
    private static int32 DashSpeed = 150;

    private int32 lastX;
    private int32 lastY;

    public bool IsDodging = false;
    public Directions Direction = Directions.ZILCH;

    public this(int32 x, int32 y, int32 w, int32 h, uint8 r, uint8 g, uint8 b, uint8 a) : base(x, y, w, h, r, g, b, a) {}

    public void Move()
    {
        SetPreviousPosition(Rect.x, Rect.y);

        if (Utils.IsKeyHeld(.SDL_SCANCODE_W))
            Rect.y -= Player.MoveSpeed;
        if (Utils.IsKeyHeld(.SDL_SCANCODE_A))
            Rect.x -= Player.MoveSpeed;
        if (Utils.IsKeyHeld(.SDL_SCANCODE_S))
            Rect.y += Player.MoveSpeed;
        if (Utils.IsKeyHeld(.SDL_SCANCODE_D))
            Rect.x += Player.MoveSpeed;

        // Prevent the player from leaving the window.
        if (!(0 < Rect.x))
	        Rect.x += Math.Abs(Rect.x);
        if (!(Rect.x + Rect.w < Program.Window.Width))
	        Rect.x -= Math.Abs((int32)Program.Window.Width - Rect.x - Rect.w);

        if (!(0 < Rect.y))
            Rect.y += Math.Abs(Rect.y);
        if (!(Rect.y + Rect.h < Program.Window.Height))
	        Rect.y -= Math.Abs((int32)Program.Window.Height - Rect.y - Rect.h);

        CheckDirection();
    }

    public void Dodge()
    {
        IsDodging = true;

		switch (Direction)
		{
		case Directions.N:
			Rect.y -= Player.DashSpeed;

		case Directions.S:
			Rect.y += Player.DashSpeed;

		case Directions.E:
			Rect.x += Player.DashSpeed;

		case Directions.W:
			Rect.x -= Player.DashSpeed;

		case Directions.NE:
			Rect.y -= Player.DashSpeed;
			Rect.x += Player.DashSpeed;

		case Directions.NW:
			Rect.y -= Player.DashSpeed;
			Rect.x -= Player.DashSpeed;

		case Directions.SE:
			Rect.y += Player.DashSpeed;
			Rect.x += Player.DashSpeed;

		case Directions.SW:
			Rect.y += Player.DashSpeed;
			Rect.x -= Player.DashSpeed;

		default:
			return;
		}
    }

    public bool CheckCollisions()
    {
        for (let rect in DrawManager<Rect>.GetDrawables())
            if (CheckCollision(rect) && rect != this)
                return true;

        return false;
    }

    [Inline]
    private void SetPreviousPosition(int32 x, int32 y)
    {
        lastX = x;
        lastY = y;
    }

    [Inline]
    private void CheckDirection()
    {
        bool IsMovingNorth = lastY > Rect.y;
        bool IsMovingSouth = lastY < Rect.y;
        bool IsMovingEast = lastX < Rect.x;
        bool IsMovingWest = lastX > Rect.x;
        bool IsStill = lastX === Rect.x && lastY === Rect.y;

        if (IsMovingNorth)
	        Direction = Directions.N;
        if (IsMovingSouth)
            Direction = Directions.S;
        if (IsMovingEast)
            Direction = Directions.E;
        if (IsMovingWest)
            Direction = Directions.W;

        if (IsMovingNorth && IsMovingEast)
            Direction = Directions.NE;
        if (IsMovingNorth && IsMovingWest)
            Direction = Directions.NW;
        if (IsMovingSouth && IsMovingEast)
            Direction = Directions.SE;
        if (IsMovingSouth && IsMovingWest)
            Direction = Directions.SW;

        if (IsStill)
            Direction = Directions.ZILCH;
    }
}
