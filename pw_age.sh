#!/bin/sh

#
# Store / retrieve a user birthday in GECOS field of the passwd file
#


getage() {
    username="$1"

    pw usershow $username -7 |
        awk -F ':' '
        $5 {
            split($5, gecos, ",")
            for (g = 1; g in gecos; g++)
                if (match(gecos[g], /birth=[^;]*/)) {
                    print(substr(gecos[g], RSTART+6, RLENGTH-6))
                    break
                }
        }
    '
}

setage() {
    username="$1"
    userbirth="$2"

    gecos=$(pw usershow $username -7 |
        awk -F ':' -v bd=$userbirth '
            {
                ch = 0
                split($5, gecos, ",")
                for (g = 1; g in gecos; g++)
                    if (gecos[g] ~ /birth=/) {
                        sub(/birth=[^;]*/, "birth=" bd, gecos[g])
                        ch = 1
                        break
                    }

                if (!ch) gecos[5] = gecos[5] "birth=" bd ";"

                printf("%s,%s,%s,%s,%s", gecos[1], gecos[2], gecos[3], gecos[4], gecos[5]);
            }
        ')
    pw usermod $username -c "$gecos"
}
