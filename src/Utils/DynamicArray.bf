// From this GeeksForGeeks article: https://www.geeksforgeeks.org/dsa/how-do-dynamic-arrays-work/

namespace beefgame.Utils;

using beefgame.Utils.SDL3;

public class DynamicArray<T>
{
    private T[] Array;
    private int Size;
    private int Capacity;

    public this()
    {
        Capacity = 1;
        Size = 0;
        Array = new T[Capacity];
    }

    private void GrowArray()
    {
        Capacity *= 2;

        T[] temp = new T[Capacity];

        for (int i = 0; i < Size; i++)
        {
            temp[i] = Array[i];
        }

        delete Array;

        Array = temp;
    }
}