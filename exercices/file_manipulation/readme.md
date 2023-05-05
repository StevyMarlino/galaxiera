## To Do

- Get the hostname with the playbook
- Create a file in the remote host equal to the hostname we just get with the playbook
- Insert into that file different host informations like 
    - free space
    - operating system
    - kernel version


## How to launch the projet

1. Into the file 00_inventory.ini replace the current host machine with your own host machine

2. Into the diretory group_vars/custom.yml you must precise you own ssh user and the path to your own ssh private file


## Different commant 

#### Check my inventory structure 
```
ansible-inventory -i 00_inventory.ini --list
```
or
```
ansible-inventory -i 00_inventory.ini --graph
```

#### Test your inventory with a ping - pong
```
ansible -i 00_inventory.ini all -m ping
```
or
```
ansible -i 00_inventory.ini custom -m ping
```
or
```
ansible -i 00_inventory.ini 192.168.96.3 -m ping
```

### Test with a playbook file
```
ansible-playbook -i 00_inventory.ini playbook.yml
```

### note : You can use your own inventory file 
### note : You can use your own group name
