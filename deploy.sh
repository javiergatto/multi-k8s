docker build -t xhavier4/multi-client-k8s:latest -t xhavier4/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t xhavier4/multi-server-k8s-pgfix:latest -t xhavier4/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t xhavier4/multi-worker-k8s:latest -t xhavier4/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push xhavier4/multi-client-k8s:latest
docker push xhavier4/multi-server-k8s-pgfix:latest
docker push xhavier4/multi-worker-k8s:latest

docker push xhavier4/multi-client-k8s:$SHA
docker push xhavier4/multi-server-k8s-pgfix:$SHA
docker push xhavier4/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xhavier4/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=xhavier4/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=xhavier4/multi-worker-k8s:$SHA
