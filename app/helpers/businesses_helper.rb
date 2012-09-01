module BusinessesHelper
  def all_currencies
    hash = Money::Currency.table
    dropdown = {}

    hash.each do |k, v|
      dropdown[v[:iso_code]] = v[:iso_code]
    end

    dropdown
  end
end
