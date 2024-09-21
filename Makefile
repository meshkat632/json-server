IMAGE_REPO=$(REGISTRY_URL)/$(REGISTRY_NAMESPACE)
DOCKER_REGISTRY=$(IMAGE_REPO)
IMAGE_NAME=json-server
IMAGE_TAG=0.0.1-SNAPSHOT
PLATFORMS=linux/amd64,linux/arm64
DOCKER_BUILD_FLAGS=-t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)-amd64 \
                   -t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)-arm64 \
                   -t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)

# Docker login target
docker-login:
	@echo "Logging in to Docker registry $(REGISTRY_URL)..."
	@docker login $(REGISTRY_URL) -u $(REGISTRY_USERNAME) -p $(REGISTRY_PASSWORD)
	@echo "Docker login successful."

# Initialize Docker buildx for multi-architecture builds
buildx-init:
	@echo "Initializing Docker buildx..."
	@docker buildx create --name multi-arch-builder --use || docker buildx use multi-arch-builder
	@docker buildx inspect --bootstrap
	@echo "Docker buildx initialized."

# Docker build target (builds the image locally, no push, no multi-architecture)
build:
	@echo "Building the Docker image locally with tag $(IMAGE_TAG)..."
	@docker build -t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG) -f Dockerfile .
	@echo "Local Docker image built: $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)"

# Docker build and push target for multi-architecture builds
buildx-build-push: docker-login buildx-init
	@echo "Building the Docker image for platforms $(PLATFORMS) with tag $(IMAGE_TAG)..."
	@docker buildx create --use --name multi-arch-builder || true
	@docker buildx build --platform linux/amd64,linux/arm64 \
		-t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)-amd64 \
		-t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)-arm64 \
		-t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG) \
		-f Dockerfile --push .
	@echo "Multi-architecture Docker image built and pushed: $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)"
