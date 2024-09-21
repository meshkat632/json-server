
# JSON Server Kubernetes Deployment

This repository provides the Kustomize configuration files and a Makefile to simplify deploying and managing a `json-server` instance on a Kubernetes cluster.

## Prerequisites

Ensure that the following tools are installed on your system before proceeding:

- [kubectl](https://kubernetes.io/docs/tasks/tools/) - Kubernetes command-line tool.
- [Kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/) - Tool to customize Kubernetes YAML configurations. (Note: `kubectl` has Kustomize built-in from version 1.14+).
- [Make](https://www.gnu.org/software/make/) - Utility to run the deployment commands.

## Project Structure

The repository consists of the following key files:

```bash
├── kustomization.yaml   # Kustomize configuration file
├── deployment.yaml      # Kubernetes Deployment definition for json-server
├── service.yaml         # Kubernetes Service definition for json-server
├── Makefile             # Makefile to simplify deployment and undeployment
└── README.md            # Project documentation and usage instructions
```

## Usage

### Deploying the JSON Server

To deploy the `json-server` application to your Kubernetes cluster, run the following command:

```bash
make deploy
```

This command will deploy the application into the `default` namespace by default. To deploy it to a custom namespace, specify the desired namespace as follows:

```bash
make deploy NAMESPACE=my-namespace
```

If the specified namespace does not already exist, you can create it before deploying:

```bash
make create-namespace NAMESPACE=my-namespace
```

### Undeploying the JSON Server

To remove the `json-server` deployment and all associated resources from your Kubernetes cluster, use the `undeploy` command:

```bash
make undeploy
```

You can also specify the namespace from which to remove the deployment:

```bash
make undeploy NAMESPACE=my-namespace
```

### Managing the Namespace

You can manage Kubernetes namespaces with the following commands:

- **Create a Namespace**: If your target namespace does not exist, create it using the following command:

  ```bash
  make create-namespace NAMESPACE=my-namespace
  ```

- **Delete a Namespace**: This command will delete the specified namespace and all the resources within it:

  ```bash
  make delete-namespace NAMESPACE=my-namespace
  ```

  **Warning**: Deleting a namespace will remove all resources within that namespace, including deployments, services, and any other objects.

## Customization

You can modify the Kubernetes resources (such as the deployment and service) by editing the corresponding YAML files:

- `deployment.yaml`: Defines how the `json-server` application is deployed, including replica count and container settings.
- `service.yaml`: Configures how the `json-server` is exposed within the Kubernetes cluster.

These changes will be automatically applied the next time you run `make deploy`.

## Docker Image

The `json-server` application is deployed using the following Docker image:

```plaintext
meshkatul/json-server:0.0.1-SNAPSHOT
```

You can update the image version in the `deployment.yaml` file if needed.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
