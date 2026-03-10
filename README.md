# pw_age.sh

## Store / retrieve a user birthday in GECOS field of the passwd file

### Usage

``` sh
. pw_age.sh
getage <username>
setage <username> <date>
```

### Implementation notes

- Date is stored in the 5-th "GECOS" field of /etc/passwd and placed into the 5-th comma separated "Other info" section
- format of the date is: `birth=<date>;` which potentially alows to store more `key=value` data in the field
- **No** age restrictions checks are performed
- **No** date conversions are applied

### Ideas

- Use UNIX-time to eliminate conversion issues
