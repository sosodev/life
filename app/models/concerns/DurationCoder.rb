class DurationCoder
  def self.dump(duration)
    case duration
    when ActiveSupport::Duration
      duration.to_i
    when Numeric
      duration.to_i
    else
      nil
    end
  end

  def self.load(value)
    return nil if value.nil?
    ActiveSupport::Duration.build(value.to_i)
  end
end
