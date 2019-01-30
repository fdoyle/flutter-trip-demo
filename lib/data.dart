List<Flight> getFlights(){
  return [
    Flight("1","Paris", "France", "New York", "United States", "PAR", "LGA",
        "http://all4desktop.com/data_images/original/4203287-eiffel-tower-at-night-paris-france-normal.jpg", 874),
    Flight("2","London", "England", "New York", "United States", "ENG", "LGA", "https://www.londonperfect.com/blog/wp-content/uploads/2018/01/FO-spring-london.jpg",354),
    Flight("3","New York", "United States", "Paris", "France", "LGA", "PAR", "https://images.icanvas.com/2d/TEO80.jpg",1283)
  ];
}

class Flight {


  String destination;
  String destinationCountry;
  String source;
  String sourceCountry;
  String destinationCode;
  String sourceCode;
  String url;
  int price;
  String id;

  Flight(this.id, this.destination, this.destinationCountry, this.source,
      this.sourceCountry, this.destinationCode, this.sourceCode, this.url,
      this.price);


}