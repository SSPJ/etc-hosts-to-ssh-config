#!/usr/bin/perl -w

### Variables ###

$local_user = "user"; # e.g. person@computer$ --> "person"
$remote_user = "user"; # e.g. ssh me@host --> "me"

# path to hosts file for processing
$etc_hosts_path = "/etc/hosts";
# path to ssh's local user config file
$ssh_conf_path = "/home/$local_user/.ssh/config";
# path to your private key for log on to the servers
$identity_file = "/home/$local_user/.ssh/id_rsa";
# aditional options, e.g.
# $options = "  ForwardX11Trusted yes\n  Compression yes\n"
$options = "";


### Script ###

open SSH_CONFIG, ">>$ssh_conf_path" or die("ssh config file can't be opened ($!)");
open ETC_HOSTS, "<$etc_hosts_path" or die("hosts file file can't be opened ($!)");

while (<ETC_HOSTS>) {
	# no blank lines
	next unless /[^\s]/;
	# no comments
	next if /\s*[#;]/;

	# parse line for ip then for hosts
	/\s*([A-Fa-f0-9\.:]{1,19})\s+/;
	$ip = $1;
	@hosts = split /\s+/, $';

	# give each host an entry
	foreach $host (@hosts) {
		print SSH_CONFIG "host $host\n" .
				   "  hostname $ip\n" .
				   "  IdentityFile $identity_file\n" .
				   "  User $remote_user\n" . "$options";
	}
}

close SSH_CONFIG;
close ETC_HOSTS;
