#!/bin/sh
sed s/DOMINIO/${DOMINIO}/g \/playbooks-container\/ssl.yaml -i
sed s/ALERT_EMAIL/${ALERT_EMAIL}/g \/playbooks-container\/ssl.yaml -i

#tail -f /dev/null
ansible-playbook /playbooks-container/ssl.yaml