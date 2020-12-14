docker build -t eduarcos/multi-client:latest -t eduarcos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eduarcos/multi-server:latest -t eduarcos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eduarcos/multi-worker:latest -t eduarcos/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push eduarcos/multi-client:latest
docker push eduarcos/multi-server:latest
docker push eduarcos/multi-worker:latest

docker push eduarcos/multi-client:$SHA
docker push eduarcos/multi-server:$SHA
docker push eduarcos/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eduarcos/multiserver:$SHA
kubectl set image deployments/client-deployment client=eduarcos/multiclient:$SHA
kubectl set image deployments/worker-deployment worker=eduarcos/multiworker:$SHA

