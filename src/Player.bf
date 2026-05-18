namespace beefgame;

using beefgame.Utils;

public class Player : Rect
{
    public static int32 MoveSpeed = 10;

    public this(int32 x, int32 y, int32 w, int32 h, uint8 r, uint8 g, uint8 b, uint8 a) : base(x, y, w, h, r, g, b, a)
    {
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
}