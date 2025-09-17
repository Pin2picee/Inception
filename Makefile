NAME = inception

$(NAME) :
	@if [ ! -d "$$HOME/data/mariadb" ]; then \
		mkdir -p "$$HOME/data/mariadb"; \
		echo "Volume mariadb created !"; \
	fi
	@if [ ! -d "$$HOME/data/wordpress" ]; then \
		mkdir -p "$$HOME/data/wordpress"; \
		echo "Volume wordpress created !"; \
	fi
	docker compose -f ./srcs/docker-compose.yml up --build 

all : $(NAME)

clean:
	docker compose -f ./srcs/docker-compose.yml down --rmi all 


# supprime les volumes
fclean:
	docker compose -f ./srcs/docker-compose.yml down --rmi all 
	rm -rf $(NAME)
	sudo rm -rf $$HOME/data

reset:fclean all

# re : ne reset pas les volumes 
re : clean all


	
.PHONY: all clean fclean reset re
