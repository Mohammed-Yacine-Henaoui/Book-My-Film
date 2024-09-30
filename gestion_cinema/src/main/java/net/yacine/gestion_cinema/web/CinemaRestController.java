package net.yacine.gestion_cinema.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import jakarta.transaction.Transactional;
import net.yacine.gestion_cinema.entities.Ticket;
import net.yacine.gestion_cinema.entities.Film;
import net.yacine.gestion_cinema.repository.FilmRepository;
import net.yacine.gestion_cinema.repository.TicketRepository;

@RestController
public class CinemaRestController {

    @Autowired
    private FilmRepository filmRepository;

    @Autowired
    private TicketRepository ticketRepository;

    @GetMapping(path = "/imageFilm/{title}", produces = {MediaType.IMAGE_JPEG_VALUE})
    public byte[] getImageFilm(@PathVariable String title) throws Exception {
        // Récupère le nom de l'image à partir du repository
        Film film = filmRepository.findByTitle(title)
                .orElseThrow(() -> new Exception("Film not found with id " + title));
                
        String imageName = film.getImage();
        try {
            // Construit le chemin vers le fichier image
            File file = new File(System.getProperty("user.home") + "/cinema/images/" + imageName + ".jpg");
            Path path = Paths.get(file.toURI());

            // Lit le fichier et renvoie son contenu en tant que tableau de bytes
            return Files.readAllBytes(path);
        } catch (IOException e) {
            throw new Exception(e.getMessage().toString());
        }
    }

   }
