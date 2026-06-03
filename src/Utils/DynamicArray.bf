// From this GeeksForGeeks article: https://www.geeksforgeeks.org/dsa/how-do-dynamic-arrays-work/

namespace beefgame.Utils;

using beefgame.Utils.SDL3;
using System;

public class DynamicArray<T>
{
    private T[] Array;
    private int Size;
    private int Capacity;

    public this(int cap = 1)
    {
        Capacity = cap;
        Size = 0;
        Array = new T[Capacity];
    }

    public ~this()
    {
        delete Array;
    }

    public int Search(T item)
    {
        int returnValue = -1;

        for (int i < Size)
            if (Array[i] == item)
                returnValue = i;

        return returnValue;
    }

    public void InsertAt(int index, T item)
    {
        if (Size === Capacity)
            GrowArray();

        for (int i = Size - 1; i >= index; i--)
            Array[i] = Array[i + 1];

        Array[index] = item;
        Size++;
    }

    public void DeleteAt(int index)
    {
        for (int i = index; i < Size; i++)
            Array[i] = Array[i + 1];

        if (Size === (Capacity / 2))
            ShrinkArray();
    }

    public void PushBack(T item)
    {
        if (Size === Capacity)
            GrowArray();

        Array[Size] = item;

        Size++;
    }

    public void PopBack()
    {
        Size--;

        if (Size == (Capacity / 2))
            ShrinkArray();
    }

    public void GrowArray()
    {
        Capacity *= 2;

        T[] temp = new T[Capacity];

        for (int i < Size)
            temp[i] = Array[i];

        delete Array;

        Array = temp;
    }

    public void ShrinkArray()
    {
        Capacity = Size;
        T[] temp = new T[Capacity];

        for (int i < Size)
            temp[i] = Array[i];

        delete Array;

        Array = temp;
    }

    public int GetSize()
    {
        return Size;
    }

    public int GetCapacity()
    {
        return Capacity;
    }
}