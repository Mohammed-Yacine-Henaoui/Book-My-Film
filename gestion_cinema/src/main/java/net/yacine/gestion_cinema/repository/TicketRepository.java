package net.yacine.gestion_cinema.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import net.yacine.gestion_cinema.entities.Ticket;

@RepositoryRestResource
public interface TicketRepository extends JpaRepository<Ticket, Long> {

}
