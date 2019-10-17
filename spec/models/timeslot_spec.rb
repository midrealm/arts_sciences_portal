require 'rails_helper'

RSpec.describe Timeslot, type: :model do
  describe 'in_order' do
    it 'returns all the entries in chronological order' do
      ordering = Timeslot.all.in_order.pluck(:order)
      for i in 1..ordering.size - 1
        expect(ordering[i]).to be > ordering[i-1]
      end
    end
  end
end
