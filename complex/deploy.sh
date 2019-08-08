docker build -t anukalady/multi-client:latest -t anukalady/multi_client:$SHA -f ./client/Dockerfile ./client
docker build -t anukalady/multi-server:latest -t anukalady/multi_server:$SHA -f ./server/Dockerfile ./server
docker build -t anukalady/multi-worker:latest -t anukalady/multi_worker:$SHA -f ./worker/Dockerfile ./worker
docker push anukalady/multi-client:latest
docker push anukalady/multi-server:latest
docker push anukalady/multi-worker:latest

docker push anukalady/multi-client:$SHA
docker push anukalady/multi-server:$SHA
docker push anukalady/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anukalady/multi-server:$SHA
kubectl set image deployments/client-deployment client=anukalady/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anukalady/multi-worker:$SHA