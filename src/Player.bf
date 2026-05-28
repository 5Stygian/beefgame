namespace beefgame;

using beefgame.Utils;
using beefgame.Utils.SDL3;

public class Player : Rect
{
    private static int32 MoveSpeed = 10;
    private static int32 DashSpeed = 200;

    public Directions Direction;

    private int32 lastX;
    private int32 lastY;

    public this(int32 x, int32 y, int32 w, int32 h, uint8 r, uint8 g, uint8 b, uint8 a) : base(x, y, w, h, r, g, b, a)
    {
    }

    public void SetPreviousPosition(int32 x, int32 y)
    {
        this.lastX = x;
        this.lastY = y;
    }

    // surely there is an easier way to do this.
    public void CheckDirection()
    {
        bool IsMovingNorth = this.lastY > this.Rect.y;
        bool IsMovingSouth = this.lastY < this.Rect.y;
        bool IsMovingEast = this.lastX < this.Rect.x;
        bool IsMovingWest = this.lastX > this.Rect.x;
        bool IsStill = this.lastX === this.Rect.x && this.lastY === this.Rect.y;

        if (IsMovingNorth)
	        this.Direction = Directions.N;
        if (IsMovingSouth)
            this.Direction = Directions.S;
        if (IsMovingEast)
            this.Direction = Directions.E;
        if (IsMovingWest)
            this.Direction = Directions.W;

        if (IsMovingNorth && IsMovingEast)
            this.Direction = Directions.NE;
        if (IsMovingNorth && IsMovingWest)
            this.Direction = Directions.NW;
        if (IsMovingSouth && IsMovingEast)
            this.Direction = Directions.SE;
        if (IsMovingSouth && IsMovingWest)
            this.Direction = Directions.SW;

        if (IsStill)
            this.Direction = Directions.ZILCH;
    }

    public void MoveRight()
    {
        this.Rect.x += Player.MoveSpeed;
    }
    public void MoveDown()
    {
        this.Rect.y += Player.MoveSpeed;
    }
    public void MoveLeft()
    {
        this.Rect.x -= Player.MoveSpeed;
    }
    public void MoveUp()
    {
        this.Rect.y -= Player.MoveSpeed;
    }

    public void Dodge()
    {
        switch (this.Direction)
        {
        case Directions.N:
            this.Rect.y -= Player.DashSpeed;

        case Directions.S:
            this.Rect.y += Player.DashSpeed;

        case Directions.E:
            this.Rect.x += Player.DashSpeed;

        case Directions.W:
            this.Rect.x -= Player.DashSpeed;

        case Directions.NE:
            this.Rect.y -= Player.DashSpeed;
            this.Rect.x += Player.DashSpeed;

        case Directions.NW:
            this.Rect.y -= Player.DashSpeed;
            this.Rect.x -= Player.DashSpeed;

        case Directions.SE:
            this.Rect.y += Player.DashSpeed;
            this.Rect.x += Player.DashSpeed;

        case Directions.SW:
            this.Rect.y += Player.DashSpeed;
            this.Rect.x -= Player.DashSpeed;

        default:
            return;
        }
    }
}
