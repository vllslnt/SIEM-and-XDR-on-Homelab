## How to Execute a Script
1. Copy the script into the server's directory, preferably within your <kbd>home</kbd> folder.
2. While in the same directory, check for file permissions using:

<strong>BASH</strong>
```bash
$ ls -l
```

3. Notice how it's missing an (x) for execute. You'll have to add the (x) permission to the script file using:

```bash
$ chmod u+x <filename>
```

4. You should now be able to run the script using:

```bash
$ bash <filename>

# or

$ ./<filename>
```
<italic>
    *Given you are within the same directory of the script file. For these scripts, you do not need <kbd>sudo</kbd> to run it.
</italic>

## Concepts Behind chmod
<strong>Imagine that you have:</strong><br>
<kbd>-rw-r--r--</kbd>

This displays the permissions of:<br>
<kbd>rw-</kbd>: The owner<br>
<kbd>r--</kbd>: The associated group<br>
<kbd>r--</kbd>: Other users outside the associated group

Entering a command such as <kbd>$ chmod u+x</kbd> adds:<br>
<kbd>-rwxr--r--</kbd> to the permission bits, where the current user's class now has <kbd>-rwx</kbd> permissions, which stands for:<br>
* Read
* Write
* <strong>Execute</strong>
