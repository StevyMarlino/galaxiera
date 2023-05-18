#### TO DO

1. Create a Create a shell script that:
  - create 6 containers with ssh access in three different networks (two in each network  populates the inventory files for the three groups (one group for the machines on each network).
  - create files in groups_vars per group
  - create files in host_vars by hosts

2. Write a playbook which in each container will create a file (hosts_list) in the user's home
  - the file  must have the list of containers which are not in the same network as him, and therefore which are not in the same group as him (4 hosts therefore)
  - the file must be created from a template:
       [Name of the group]
       - ip machine 1
       - ip machine 2

3. Continuation of the TP for the most curious:
  - The last machine of the third group becomes the server. To do this, she must know all the other machines.
     So you create a task that runs only on this machine and will make a template to create a file named others_hosts in the user's home and which contains the IP addresses of other machines except his own
  - The other machines must have a file in the user's home named server_host which only contains the server's IP address in the format:
    [server]
     server_ip