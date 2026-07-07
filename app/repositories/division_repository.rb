class DivisionRepository
  def self.active_divisions
    Division.where(deprecated: false)
  end

  def self.deprecated_divisions
    Division.where(deprecated: true)
  end

  def self.for_index(show_deprecated:)
    show_deprecated ? deprecated_divisions : active_divisions
  end
end
