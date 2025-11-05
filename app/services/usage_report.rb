class UsageReport
  def initialize(buyer)
    @buyer = buyer
  end

  def generate
    @buyer.usages.includes(:feature).map do |usage|
      {
        feature: usage.feature.name,
        units_used: usage.units_used,
        limit: usage.feature.max_unit_limit,
      }
    end
  end
end
