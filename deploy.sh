# Tagging 2 times and SHA is an env variable defined in travis file
docker build -t 03004968719/multi-client:latest -t 03004968719/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t 03004968719/multi-server:latest -t 03004968719/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t 03004968719/multi-worker:latest -t 03004968719/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push 03004968719/multi-client:latest
docker push 03004968719/multi-server:latest
docker push 03004968719/multi-worker:latest
docker push 03004968719/multi-client:$SHA
docker push 03004968719/multi-server:$SHA
docker push 03004968719/multi-worker:$SHA
kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=03004968719/multi-server:$SHA 
kubectl set image deployments/client-deployment client=03004968719/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=03004968719/multi-worker:$SHA 
# server-deployment is the name of server-deployment file , server=03004968719/multi-server means that in container server -- we need to run our own image with tag $SHA
