1. Creer un image docker à l'aide d'un dockerfile à partir de l'image nginx:latest . En modifiant le port par défaut pour le port 5000 

2. Creer une image docker à l'aide d'un dockerfile à partir de l'image httpd:latest , en modifiant le port par défaut pour le port 8000 

3.  Poussez les  2 images sur le docker hub 

4. Dans Le cluster kubernetes creer un deployment  à  5 replicas à l'aide d'un script terraform , dans chaque pod, creez deux containeurs . l'un avec l'image nginx et l'autre avec l'image httpd que vous avez creer plus haut 

5. Creer un service de type NodePort  en vue d'exposer vos deux applications (httpd et nginx)

6. step to share your image in your dockerhub repository follow the link below

https://docs.docker.com/get-started/04_sharing_app/


### push nginx and httpd in my own repository

```bash
docker tag nginx-port-changed smarlino/nginx-port-changed:latest
```
```bash
docker push smarlino/nginx-port-changed:latest
```


```bash
docker tag httpd-port-changed smarlino/httpd-port-changed:latest
```
```bash
docker push smarlino/httpd-port-changed:latest
```

#### Launch Terrafor

```bash
terraform init
```
```bash
terraform plan
```

```bash
terraform apply
```