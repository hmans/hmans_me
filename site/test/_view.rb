module TestHelpers
  def poop
    "#{super} + ❤️"
  end
end

extend TestHelpers
