## About project
Generate a wildcard certificate *.mydomain.com.br using docker, cloudflare API, ansible and shellscript.

## Phases
* Generates wildcard certificate *.meudominio.com.br
* Triggers confirmation email
* Copy certificate files to servers
* Triggers confirmation email

## 1. Set credentials within plabooks/group_vars/all.yml

### Credential to connect to VM
```
ansible_ssh_pass: 123456
ansible_connection:ssh
```

### Credential to access cloudflare and send email
```
cloudflare_api_token: "123456789012345678901234567890123456"
cloudflare_email: marcelo.de.lm@gmail.com.br
```

### Credential to send email
```
username_email: marcelo.de.lm@gmail.com.br
password_email: 123456
```

## 2. Set environment for certificate generation letsencrypt plabooks/roles/letsencrypt-cloudflare/main.yml

### Staging
```
acme_directory: https://acme-staging-v02.api.letsencrypt.org/directory
```

### Production
```
acme_directory: https://acme-v02.api.letsencrypt.org/directory
```

## 3. Path to generated certificate /docker-compose.yml

### On volume ./certs:/certs will receive the generated letsencrypt certificate.
```
volumes:
  - ./playbooks:/playbooks
  - ./certs:/certs
```

## 3.1 Define docker-composer variables for /docker-compose.yml certificate generation

### Inform the domain and the email that will be sent to confirm
```
environment:
  - DOMAIN=mydomain.com.br
  - ALERT_EMAIL=marcelo.de.lm@gmail.com.br
```

## 4. Task copy files copies files to servers after generating letsencrypt certificate

### Path to copy plabooks/ssl.yaml files
```
ssl_file_nginx: "/etc/nginx/ssl/DOMAIN"
ssl_file_owner: nginx
ssl_file_group: nginx
```