docker build -t shubhankergoyal/multi-client:latest -t shubhankergoyal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shubhankergoyal/multi-server:latest -t shubhankergoyal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shubhankergoyal/multi-worker:latest -t shubhankergoyal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shubhankergoyal/multi-client:latest
docker push shubhankergoyal/multi-server:latest
docker push shubhankergoyal/multi-worker:latest

docker push shubhankergoyal/multi-client:$SHA
docker push shubhankergoyal/multi-server:$SHA
docker push shubhankergoyal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image delpoyments/server-deployment server=shubhankergoyal/multi-server:$SHA
kubectl set image deployments/client-deployment client=shubhankergoyal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shubhankergoyal/multi-worker:$SHA

