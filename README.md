###Purpose

This will convert /etc/hosts style files into .ssh/config style files. If you frequently ssh to a large number of machines using the same username and ssh key, this can be useful for avoiding a) sending *all* of your ssh keys to the remote host until a match is found; b) needing to type username@ each time you ssh.

It skips comments and blank lines. It does not check if the syntax is valid. It does not check for duplicates. A more robust solution would be better implimented with configuration management (c.f. ansible).

It appends to the ssh config file, it does not overwrite it.

###How to use this script

1. Download the .pl file and put it somewhere.
2. Open it and edit the lines at the top.
  - Replace "user" with your usernames

      ```Perl
      $local_user = "user"; # e.g. person@computer$ --> "person"
      $remote_user = "user"; # e.g. ssh me@host --> "me"
       ```
  - Edit the paths, if the defaults are not correct

      ```Perl
      # path to hosts file for processing
      $etc_hosts_path = "/etc/hosts";
      # path to ssh's local user config file
      $ssh_conf_path = "/home/$local_user/.ssh/config";
      # path to your private key for log on to the servers
      $identity_file = "/home/$local_user/.ssh/id_rsa";
      ```
  - Put in addional ssh options you might need
  
      ```Perl
      # $options = "  ForwardX11Trusted yes\n  Compression yes\n"
      $options = "";
      ```
3. Save it, then make it executible.

        chmod u+x hosts-to-ssh-config.pl
4. Run it.

        ./hosts-to-ssh-config.pl
