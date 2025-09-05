#include <cs50.h>
#include <ctype.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    string text = get_string("Text : ");

    float word = 1;
    float sentence = 0;
    float point = 0;
    int len = strlen(text);

    for (int i = 0; i < len; i++)
    {
        if (isalpha(text[i]) != 0)
        {
            point++;
        }

        if (text[i] == 32)
        {
            word++;
        }

        if (text[i] == 46 || text[i] == 33 || text[i] == 63)
        {
            sentence++;
        }
    }

    float L = 100 * (point / word);
    float S = 100 * (sentence / word);
    int index = round(0.0588 * L - 0.296 * S - 15.8);

    if (index >= 16)
    {
        printf("Grade 16+\n");
    }
    else if (index <= 1)
    {
        printf("Before Grade 1\n");
    }
    else
    {
        printf("Grade %i\n", index);
    }
}
