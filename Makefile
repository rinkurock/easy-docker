# https://www.freecodecamp.org/news/how-to-remove-all-docker-images-a-docker-cleanup-guide/
run:
	open -a Docker
down:	
	pkill -SIGHUP -f /Applications/Docker.app 'docker serve' 
up:
	docker-compose up -d
status:
	docker ps
df:
	docker system df
dfv:
	docker system df -v
cleanup:
	docker system prune -a
	docker image prune -a
	docker container prune
# safe-clean:
# 	docker rmi $(docker images -f "dangling=true" -q) --force
# 	docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}') --force