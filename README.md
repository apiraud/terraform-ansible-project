# Procédure

```bash
# Se connecter au container infracoston-terraform
# Remplacer <user> par votre utilisateur
# Remplacer <path> par le chemin de votre clé SSH
ssh -i <path> <user>@infracoston-terraform.final.cfai24.ajformation.fr

# Se connecter avec l'utilisateur infracoston
sudo su - infracoston
```

> La connexion à l'utilisateur infracoston initie un agent SSH
>
> Il faut donc renseigner le MDP situé dans le fichier [administration.yaml](./documentation/administration.yaml)

```bash
# Construction des containers
cd /automatisation/terraform
. /.venv/bin/activate
source passwords.env
./terraform apply

# Vérification des containers
deactivate
cd /automatisation/ansible
. ./.venv/bin/activate
ansible -m ping -i inventory/ infracoston-adminweb
ansible -m ping -i inventory/ infracoston-vitrineweb
ansible -m ping -i inventory/ infracoston-bdd1

# Connexion aux containers
# Remplacer <user> par votre utilisateur
# Remplacer <path> par le chemin de votre clé SSH
ssh -i <path> <user>@infracoston-adminweb.final.cfai24.ajformation.fr
ssh -i <path> <user>@infracoston-vitrineweb.final.cfai24.ajformation.fr
ssh -i <path> <user>@infracoston-bdd1.final.cfai24.ajformation.fr

# Vérification de la base de données sur infracoston-bdd1
mariadb -u infracoston -p
show databases;
```