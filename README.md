# Projet de déploiement automatisé sur AWS avec Packer, Ansible, Terraform et GitLab CI

Ce projet permet de déployer de manière automatisée une application sur AWS en utilisant les outils Packer, Ansible, Terraform et GitLab CI.

## Structure du Repository

Le projet est organisé en plusieurs répertoires :

- **BuildAmi** : Contient le code Packer et la configuration Ansible pour la construction de l'AMI.
- **DeployRunner** : Contient le code Terraform pour le déploiement de la VM exécutant GitLab Runner.
- **DeployWebInfrastructure** : Contient le code Terraform pour le déploiement de l'infrastructure de l'application web.
- **DeployWebApplication** : Contient le code Terraform pour le déploiement de l'application web.

## Flux de déploiement avec GitLab CI

Le déploiement se déroule selon l'ordre suivant en utilisant GitLab CI :

1. Build AMI Validate : Validation du code Packer et de la configuration Ansible.
2. Build AMI Deploy : Construction de l'AMI.
3. DeployWebInfrastructure Validate : Validation du code Terraform pour le déploiement de l'infrastructure.
4. DeployWebInfrastructure Plan : Planification du déploiement de l'infrastructure.
5. DeployWebInfrastructure Apply : Déploiement de l'infrastructure.
6. DeployWebApplication Validate : Validation du code Terraform pour le déploiement de l'application.
7. DeployWebApplication Plan : Planification du déploiement de l'application.
8. DeployWebApplication Apply : Déploiement de l'application.
9. DeployWebApplication Destroy : Destruction de l'application.
10. DeployWebInfrastructure Destroy : Destruction de l'infrastructure.
11. Build AMI Clean : Nettoyage de l'AMI.

## Configuration

Assurez-vous de configurer correctement les variables dans les fichiers ainsi que dans les parametres Gitlab Runner 