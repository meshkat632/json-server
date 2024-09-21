# Namespace variable, defaulting to 'default' if not set
NAMESPACE ?= json-server

# Set the namespace
create-namespace:
	kubectl create namespace $(NAMESPACE)

# Delete the namespace
delete-namespace:
	kubectl delete namespace $(NAMESPACE)


deploy:
	kubectl apply -f namespace.yaml
	kubectl apply -f deployment.yaml -n $(NAMESPACE)
	kubectl apply -f service.yaml -n $(NAMESPACE)

undeploy:
	kubectl delete -f deployment.yaml -n $(NAMESPACE)
	kubectl delete -f service.yaml -n $(NAMESPACE)
	kubectl delete -f namespace.yaml
