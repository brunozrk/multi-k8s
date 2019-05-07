docker build -t brunozrk/multi-client:latest -t brunozrk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brunozrk/multi-server:latest -t brunozrk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brunozrk/multi-worker:latest -t brunozrk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push brunozrk/multi-client:latest
docker push brunozrk/multi-server:latest
docker push brunozrk/multi-worker:latest

docker push brunozrk/multi-client:$SHA
docker push brunozrk/multi-server:$SHA
docker push brunozrk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=brunozrk/multi-server:$SHA
kubectl set image deployments/client-deployment client=brunozrk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brunozrk/multi-worker:$SHA
