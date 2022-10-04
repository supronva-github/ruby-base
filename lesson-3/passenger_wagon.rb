class PassengerWagon < Wagon
  attr_accessor :seats, :taken_seats

  def initialize(seats = [*1..rand(10..20)])
    @seats = seats
    @taken_seats = []

    super
  end

  def take_seat!(seat)
    raise ArgumentError, 'No free seats' if @seats.empty?
    raise ArgumentError, "Seat №#{seat} is does not exist" unless @taken_seats.include?(seat) || @seats.include?(seat)
    raise ArgumentError, "Seat №#{seat} is busy" if @taken_seats.include?(seat)

    @seats.delete(seat) && @taken_seats.push(seat)
  end
end
