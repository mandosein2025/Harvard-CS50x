#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, string argv[])
{

    if (argc != 2)
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }

    int n = strlen(argv[1]);
    for (int i = 0; i < n; i++)
    {
        if (!isdigit(argv[1][i]))
        {
            printf("Usage: ./caesar key\n");
            return 1;
        }
    }

    string plain = get_string("plaintext:  ");
    // atoi : conver string to int
    int key = atoi(argv[1]);

    char ci;
    int nn = strlen(plain);
    char cipher[nn + 1];

    for (int j = 0; j < nn; j++)
    {
        int c = plain[j];
        if (isalpha(c))
        {
            ci = c + key % 26;

            if (isupper(c))
            {
                ci = ((c - 'A' + key) % 26) + 'A';
            }
            else if (islower(c))
            {
                ci = ((c - 'a' + key) % 26) + 'a';
            }
        }
        else
        {
            ci = c;
        }
        cipher[nn] = '\0';
        cipher[j] = ci;
    }

    printf("ciphertext: %s\n", cipher);
    return 0;
}
