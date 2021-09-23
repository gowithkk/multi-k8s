docker build -t gowithkk/multi-client:latest -t gowithkk/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t gowithkk/multi-worker:latest -t gowithkk/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker build -t gowithkk/multi-server:latest -t gowithkk/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker push gowithkk/multi-client:latest
docker push gowithkk/multi-worker:latest
docker push gowithkk/multi-server:latest
docker push gowithkk/multi-client:$GIT_SHA
docker push gowithkk/multi-worker:$GIT_SHA
docker push gowithkk/multi-server:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gowithkk/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=gowithkk/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=gowithkk/multi-worker:$GIT_SHA