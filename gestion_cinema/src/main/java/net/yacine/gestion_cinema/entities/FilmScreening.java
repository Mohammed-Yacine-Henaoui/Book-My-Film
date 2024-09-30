package net.yacine.gestion_cinema.entities;

import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Builder;

@Entity @NoArgsConstructor @AllArgsConstructor @Data @Builder
public class FilmScreening {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDate startDate;
    private int price;
    @ManyToOne
    private Film film;
    @ManyToOne
    private Room room;
    @ManyToOne
    private SessionFilmScreening sessionFilmScreening;
    @OneToMany(mappedBy = "filmScreening")
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private List<Ticket> tickets;
    
}
