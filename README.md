# Homelab

This repository has a collection of my homelab configs (mostly docker-compose). I may add more detailed information to this later

# Philosophies

Just some decisions I've made and best practices when setting up services.

#### Database volumes should not be exposed / backed up directly

Always prefer an automated service for creating database dumps to a specific directory, which is backed up. When using docker, postgres data volumes should never be mounted to the file system directly.

#### Always backup SSH keys somewhere!!!!