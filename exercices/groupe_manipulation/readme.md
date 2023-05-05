#### Check if my ansible understand my group file
```
ansible-inventory -i 00_inventory --list
```

### Execute my playbook
```
ansible-playbook -i 00_inventory.ini playbook.yml
```
