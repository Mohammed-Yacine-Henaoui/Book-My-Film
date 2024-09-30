package net.yacine.gestion_cinema.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import net.yacine.gestion_cinema.entities.Cinema;

@RepositoryRestResource
public interface CinemaRepository extends JpaRepository<Cinema, Long> {

}
