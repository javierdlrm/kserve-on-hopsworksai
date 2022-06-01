# Install KServe + deps on AWS EKS

```bash
# cd repo dir
cd kserve-on-hopsworksai

# chmod +x *.sh
# chmod +x */*.sh

./install-kserve-and-deps.sh
```

## Content

*Directories*
- **Installers**: Directory with installer scripts
- **Yaml**: Directory with yaml files, templates and certs. 
- **Test**: Directory with test files.

*Scripts*
- **install-kserve-and-deps.sh**: Install kserve and deps. It assumes *kubectl* is already configured and the current context is pointing to the EKS cluster. It runs export-variables, parse-yaml-files and the installer scripts.
- **export-variables.sh**: export variables later used by *parse-yaml-files.sh* to generate the yaml files.
- **parse-yaml-files.sh**: generate yaml files under *yaml* dir, using the templates located in the same directory and environment variables. It requires running *export-variables.sh* first.
