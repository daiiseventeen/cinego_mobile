import 'package:get/get.dart';

class TicketController extends GetxController {
  final selectedFilter = 'All'.obs;
  final tickets = <Ticket>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTickets();
  }

  void loadTickets() {
    // Dummy data for UI demonstration
    tickets.value = [
      Ticket(
        id: 'TKT001',
        movieTitle: 'The Matrix Reloaded',
        cinema: 'CGV Grand Indonesia',
        showDate: '14 Feb 2026',
        showTime: '19:00 - 21:30',
        seats: ['A1', 'A2'],
        price: 100000,
        status: 'Active',
        purchaseDate: '13 Feb 2026',
      ),
      Ticket(
        id: 'TKT002',
        movieTitle: 'Avatar: The Way of Water',
        cinema: 'Cinemaxx Jakarta',
        showDate: '15 Feb 2026',
        showTime: '14:00 - 16:45',
        seats: ['D5', 'D6', 'D7'],
        price: 150000,
        status: 'Active',
        purchaseDate: '12 Feb 2026',
      ),
      Ticket(
        id: 'TKT003',
        movieTitle: 'Inception',
        cinema: 'CGV Taman Anggrek',
        showDate: '20 Feb 2026',
        showTime: '16:00 - 18:20',
        seats: ['C3'],
        price: 100000,
        status: 'Upcoming',
        purchaseDate: '10 Feb 2026',
      ),
    ];
  }

  void filterTickets(String filter) {
    selectedFilter.value = filter;
  }
}

class Ticket {
  final String id;
  final String movieTitle;
  final String cinema;
  final String showDate;
  final String showTime;
  final List<String> seats;
  final int price;
  final String status;
  final String purchaseDate;

  Ticket({
    required this.id,
    required this.movieTitle,
    required this.cinema,
    required this.showDate,
    required this.showTime,
    required this.seats,
    required this.price,
    required this.status,
    required this.purchaseDate,
  });
}
