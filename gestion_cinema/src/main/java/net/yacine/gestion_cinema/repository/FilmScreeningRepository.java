package net.yacine.gestion_cinema.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import net.yacine.gestion_cinema.entities.FilmScreening;

@RepositoryRestResource
public interface FilmScreeningRepository extends JpaRepository<FilmScreening, Long> {
    List<FilmScreening> findByRoomId(Long roomId);
}
