class CargoWagon < Wagon
  attr_reader :free_volume, :busy_volume

  def initialize(volume = rand(1..20))
    @free_volume = volume
    @busy_volume = 0
  end

  def fill!(volume)
    raise ArgumentError, 'Volume cannot be zero' if volume.zero?
    raise ArgumentError, 'Wagon is full' if @free_volume.zero?
    raise ArgumentError, "#{volume} is to big for wagon" if @free_volume < volume
    @busy_volume += volume
    @free_volume -= volume
  end
end
