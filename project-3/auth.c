#include <stdio.h>
#include <string.h>
#include <crypt.h>
#include <stdbool.h>
#include <libgen.h>
#include <stdlib.h>
#include <unistd.h>

void checkpass(char* input) {
    char password[256];
    char *hash1, *hash2;
    bool correct = false;

    strcpy(password,input);
    hash1 = crypt(password,"$6$1122334455667788$");
    hash2 = "$6$1122334455667788$vDzpRFs0Pl/L0M4/WXWsmv5/eTYlh5xoA"
            "lMoPy512JiBLrAZTNzbL.uWv3ZI6XxFUYnFzRIX2kGXF9M133D4h1";

    if (strcmp(hash1,hash2) == 0) {
        correct = true;
    } else {
        printf("ERROR: password incorrect\n");
    }

    if (correct) {
        printf("Starting root shell\n");
        setuid(0);
        setgid(0);
        system("/bin/sh");
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("syntax: %s <password>\n",basename(argv[0]));
        return 1;
    }
    checkpass(argv[1]);
    return 0;
}
