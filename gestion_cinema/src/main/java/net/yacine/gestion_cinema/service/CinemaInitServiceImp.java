package net.yacine.gestion_cinema.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import net.yacine.gestion_cinema.entities.Category;
import net.yacine.gestion_cinema.entities.Cinema;
import net.yacine.gestion_cinema.entities.City;
import net.yacine.gestion_cinema.entities.Film;
import net.yacine.gestion_cinema.entities.FilmScreening;
import net.yacine.gestion_cinema.entities.Room;
import net.yacine.gestion_cinema.entities.Seat;
import net.yacine.gestion_cinema.entities.SessionFilmScreening;
import net.yacine.gestion_cinema.entities.Ticket;
import net.yacine.gestion_cinema.repository.CategoryRepository;
import net.yacine.gestion_cinema.repository.CinemaRepository;
import net.yacine.gestion_cinema.repository.CityRepository;
import net.yacine.gestion_cinema.repository.FilmRepository;
import net.yacine.gestion_cinema.repository.FilmScreeningRepository;
import net.yacine.gestion_cinema.repository.RoomRepository;
import net.yacine.gestion_cinema.repository.SeatRepository;
import net.yacine.gestion_cinema.repository.SessionFilmScreeningRepository;
import net.yacine.gestion_cinema.repository.TicketRepository;

@Service
public class CinemaInitServiceImp implements ICinemaInitService {

    //variable globale of InitScreenFilm()

        boolean equalDate;
        Film filmStored;

        int dureeSFS2H;
        int dureeSFS2M;
        int timeSFS2H;
        int timeSFS2M;
        int debutTimeSFS2;
        int finTimeSFS2;
        boolean isSameRoom;

        int timeSFS1H;
        int timeSFS1M;
        int dureeSFS1H;
        int dureeSFS1M;
        int debutTimeSFS1;
        int finTimeSFS1;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private FilmRepository filmRepository;

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private FilmScreeningRepository filmScreeningRepository;

    @Autowired
    private SessionFilmScreeningRepository sessionFilmScreeningRepository;

    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private CinemaRepository cinemaRepository;

    @Autowired
    private CityRepository cityRepository;

    @Autowired
    private SeatRepository seatRepository;

    @Override
    public void initCategory() {
        Stream.of("Action", "Drame", "Comédie", "Fantastique").forEach(nameCategory -> {
            categoryRepository.save(Category.builder().name(nameCategory).build());
        });
    }

    @Override @Transactional
    public void initRoom() {
        cinemaRepository.findAll().forEach(cinema -> {
            for (int i = 0; i < cinema.getNumberOfRooms(); i++) {
                Room room = Room.builder()
                        .name("Room " + (i + 1))
                        .numberOfSeats((int) (Math.random() * 20) + 20)
                        .cinema(cinema)
                        .build();
                roomRepository.save(room);
            }
        });
    }

    @Override @Transactional
    public void initCinema() {
        cityRepository.findAll().forEach(city -> {
            Stream.of("Dar Takhafa", "Cinema Ibn Khaldoun", "Cinema El Mouggar").forEach(nameCinema -> {
                Cinema cinema = Cinema.builder()
                        .name(nameCinema)
                        .numberOfRooms((int) (Math.random() * 10) + 10)
                        .city(city)
                        .build();
                cinemaRepository.save(cinema);
            });
        });
    }

    @Override @Transactional
    public void initFilm() {
        List<Category> categories = categoryRepository.findAll();
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        List<String> timeList;
        timeList = List.of("01:00", "04:00", "06:00", "02:30", "02:00", "01:30");
        LocalDate date = LocalDate.of(2020, 9, 19);
        Stream.of("Sheeps", "Spiderman", "Batman", "Words", "Superman").forEach(nameFilm -> {
            Film film = Film.builder()
                    .title(nameFilm)
                    .description("It's very good film.")
                    .director("John Khbich")
                    .releaseDate(date)
                    .duration(LocalTime.parse(timeList.get((int) (Math.random() * timeList.size())), timeFormatter))
                    .image(nameFilm)
                    .category(categories.get((int) (Math.random() * categories.size())))
                    .build();
            filmRepository.save(film);
        });
    }

    @Override @Transactional
    public void initCity() {
        Stream.of("Tlemcen", "Oran", "Alger", "Setif").forEach(nameCity -> {
            City city = City.builder()
                    .name(nameCity)
                    .build();
            cityRepository.save(city);
        });
    }

    @Override @Transactional
    public void initSeat() {
        roomRepository.findAll().forEach(room -> {
            for (int i = 0; i < room.getNumberOfSeats(); i++) {
                Seat seat = Seat.builder()
                        .number(i + 1)
                        .room(room)
                        .build();
                seatRepository.save(seat);
            }
        });
    }

    @Override @Transactional
    public void initTicket() {
        filmScreeningRepository.findAll().forEach(filmScreening -> {
            filmScreening.getRoom().getSeats().forEach(seat -> {
                ticketRepository.save(Ticket.builder()
                        .seat(seat)
                        .filmScreening(filmScreening)
                        .price(filmScreening.getPrice())
                        .nameCustomer("")
                        .build());
            });
        });
    }


    @Override
    public void initFilmScreening() {

        List<Room> rooms = roomRepository.findAll();
        List<SessionFilmScreening> sessionFilmScreenings = sessionFilmScreeningRepository.findAll();
   
        filmRepository.findAll().forEach(film -> {

            dureeSFS2H = film.getDuration().getHour();
            dureeSFS2M = film.getDuration().getMinute();

            for (int i = 0; i < 40; i++) {
                Room room = rooms.get((int) (Math.random() * rooms.size()));
                SessionFilmScreening sessionFilmScreening = sessionFilmScreenings.get((int) (Math.random() * sessionFilmScreenings.size()));

                timeSFS2H = sessionFilmScreening.getTime().getHour();
                timeSFS2M = sessionFilmScreening.getTime().getMinute();
                
                debutTimeSFS2 = (timeSFS2H*60) + timeSFS2M;
                finTimeSFS2 =  (timeSFS2H*60) + timeSFS2M + (dureeSFS2H*60) + dureeSFS2M;

                LocalDate startDate = LocalDate.of(2024, 9, 19);
                LocalDate endDate = LocalDate.of(2025, 12, 31);
                long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
                long randomDays = ThreadLocalRandom.current().nextLong(daysBetween + 1);
                LocalDate randomDate = startDate.plusDays(randomDays);
                List<FilmScreening> ListfilmScreenings = filmScreeningRepository.findByRoomId(room.getId());
                   
                isSameRoom = false;
                for(FilmScreening filmScreening : ListfilmScreenings){
                    
                    filmStored = filmScreening.getFilm();

                    equalDate = filmScreening.getStartDate().isEqual(randomDate);
        
                    if (equalDate) {
                        timeSFS1H = filmScreening.getSessionFilmScreening().getTime().getHour();
                        timeSFS1M = filmScreening.getSessionFilmScreening().getTime().getMinute();
                        dureeSFS1H = filmStored.getDuration().getHour();
                        dureeSFS1M = filmStored.getDuration().getMinute();
                        debutTimeSFS1 = (timeSFS1H*60) + timeSFS1M;
                        finTimeSFS1 =  (timeSFS1H*60) + timeSFS1M + (dureeSFS1H*60) + dureeSFS1M;

                        if(!((finTimeSFS1 <= debutTimeSFS2)||(finTimeSFS2 <= debutTimeSFS1))){
                            isSameRoom = true;
                        }
                    }                
                }

                FilmScreening filmScreeningNew;

                if(isSameRoom){
                filmScreeningNew = FilmScreening.builder()
                        .film(film)
                        .room(room)
                        .startDate(randomDate)
                        .sessionFilmScreening(sessionFilmScreening)
                        .price(444444)
                        .build();
                        filmScreeningRepository.save(filmScreeningNew);
                }
                else{
                filmScreeningNew = FilmScreening.builder()
                            .film(film)
                            .room(room)
                            .startDate(randomDate)
                            .sessionFilmScreening(sessionFilmScreening)
                            .price((int) (Math.random() * 1000) + 1000)
                            .build();
                            filmScreeningRepository.save(filmScreeningNew);
                }          
            }
        });
    }

    /* @Override
    public void initFilmScreening() {

        System.out.println("*********************************************************");
        
        List<Room> rooms = roomRepository.findAll();
        List<SessionFilmScreening> sessionFilmScreenings = sessionFilmScreeningRepository.findAll();
   
        filmRepository.findAll().forEach(film -> {

            dureeSFS2H = film.getDuration().getHour();
            dureeSFS2M = film.getDuration().getMinute();

            System.out.println("++++++++++++++++++++++");
            System.out.println("film "+film.getTitle());
            System.out.println("duree h "+dureeSFS2H);
            System.out.println("duree m "+dureeSFS2M);
            System.out.println("++++++++++++++++++++++");

            for (int i = 0; i < 40; i++) {
                Room room = rooms.get((int) (Math.random() * rooms.size()));
                SessionFilmScreening sessionFilmScreening = sessionFilmScreenings.get((int) (Math.random() * sessionFilmScreenings.size()));

                timeSFS2H = sessionFilmScreening.getTime().getHour();
                timeSFS2M = sessionFilmScreening.getTime().getMinute();
                
                debutTimeSFS2 = (timeSFS2H*60) + timeSFS2M;
                finTimeSFS2 =  (timeSFS2H*60) + timeSFS2M + (dureeSFS2H*60) + dureeSFS2M;

                LocalDate startDate = LocalDate.of(2024, 9, 17);
                LocalDate endDate = LocalDate.of(2025, 12, 31);
                long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
                long randomDays = ThreadLocalRandom.current().nextLong(daysBetween + 1);
                LocalDate randomDate = startDate.plusDays(randomDays);

                LocalDate randomDate = LocalDate.now();
            
                isSameRoom = room.getFilmScreenings().stream().anyMatch(filmScreening -> {
                    Film filmStored = filmScreening.getFilm();
        
                    // if (filmScreening.getStartDate().isEqual(randomDate)) {
                        timeSFS1H = filmScreening.getSessionFilmScreening().getTime().getHour();
                        timeSFS1M = filmScreening.getSessionFilmScreening().getTime().getMinute();
                        dureeSFS1H = filmStored.getDuration().getHour();
                        dureeSFS1M = filmStored.getDuration().getMinute();
                        debutTimeSFS1 = (timeSFS1H*60) + timeSFS1M;
                        finTimeSFS1 =  (timeSFS1H*60) + timeSFS1M + (dureeSFS1H*60) + dureeSFS1M;

                        //return true;
                        return !((finTimeSFS1 <= debutTimeSFS2)||(finTimeSFS2 <= debutTimeSFS1));
                    //}     
                    //return false;            
                });

                System.out.println(isSameRoom);

                FilmScreening filmScreeningNew;

                if(isSameRoom){
                filmScreeningNew = FilmScreening.builder()
                        .film(film)
                        .room(room)
                        .startDate(randomDate)
                        .sessionFilmScreening(sessionFilmScreening)
                        .price(444444)
                        .build();
                        filmScreeningRepository.save(filmScreeningNew);
                }
                else{
                filmScreeningNew = FilmScreening.builder()
                            .film(film)
                            .room(room)
                            .startDate(randomDate)
                            .sessionFilmScreening(sessionFilmScreening)
                            .price((int) (Math.random() * 1000) + 1000)
                            .build();
                            filmScreeningRepository.save(filmScreeningNew);
                }          
            }
        });
    } */

    @Override @Transactional
    public void initSessionFilmScreening() {
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        Stream.of("10:00", "12:00", "14:00", "15:00", "17:00", "18:00", "20:00").forEach(timeStr -> {
            LocalTime localTime = LocalTime.parse(timeStr, timeFormatter);
            SessionFilmScreening sessionFilmScreening = SessionFilmScreening.builder()
                    .time(localTime)
                    .build();
            sessionFilmScreeningRepository.save(sessionFilmScreening);
        });
    }

}
