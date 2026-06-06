namespace beefgame;

using beefgame.Utils.SDL3;
using System;
using System.Diagnostics;
using SDL3;

public class Killbox : Rect
{
    private static SDL_Color* KillboxColor = new SDL_Color() ~ delete _;
    private static int32 MinLifetime = 2;
    private static int32 MaxLifetime = 6;

    private int32 Lifetime;

    public this(int32 x, int32 y, int32 w, int32 h, uint8 r=0, uint8 g=0, uint8 b=0, uint8 a=0) : base(x, y, w, h, r, g, b, a)
    {
        Lifetime = scope Random().Next(MinLifetime, MaxLifetime + 1);

        KillboxColor.r = 255;
        KillboxColor.g = 0;
        KillboxColor.b = 0;
        KillboxColor.a = 255;

        this.SetColor(*KillboxColor);
    }
}