NAME = inception

$(NAME) :
	docker compose -f ./srcs/docker-compose.yml up --build 

all : $(NAME)

clean:
	docker compose -f ./srcs/docker-compose.yml down --rmi all 


# supprime les volumes
fclean:
	docker compose -f ./srcs/docker-compose.yml down -v --rmi all 
	rm -rf $(NAME)

re : clean all


	
.PHONY: all clean fclean re logs
