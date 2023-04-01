docker build -t montassarfatfouti/multi-client:latest -t montassarfatfouti/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t montassarfatfouti/multi-server:latest -t montassarfatfouti/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t montassarfatfouti/multi-worker:latest -t montassarfatfouti/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push montassarfatfouti/multi-client:latest
docker push montassarfatfouti/multi-server:latest
docker push montassarfatfouti/multi-worker:latest

docker push montassarfatfouti/multi-client:$SHA
docker push montassarfatfouti/multi-server:$SHA
docker push montassarfatfouti/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/client-deployment client=montassarfatfouti/multi-client:$SHA
kubectl set image deployment/server-deployment server=montassarfatfouti/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=montassarfatfouti/multi-worker:$SHA
