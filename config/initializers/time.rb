class Time
  def <(value)
    super
  rescue
    self.to_i < value.to_i
  end
end
