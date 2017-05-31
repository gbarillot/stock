class Integer
  def to_h
    if self > 10000
      return "#{(self.to_f / 1000.0).round(2)} K"
    else
      return self.to_s
    end
  end
end
