package net.yacine.gestion_cinema;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import net.yacine.gestion_cinema.service.ICinemaInitService;

@SpringBootApplication
public class GestionCinemaApplication implements CommandLineRunner{

	@Autowired
	private ICinemaInitService service;

	public static void main(String[] args) {
		SpringApplication.run(GestionCinemaApplication.class, args);
	}

    @Override
    public void run(String... args) throws Exception {
        service.initCity();
		service.initCinema();
		service.initRoom();
		service.initSeat();
		service.initCategory();
		service.initFilm();
		service.initSessionFilmScreening();
		service.initFilmScreening();
		service.initTicket();
		
    }

}
