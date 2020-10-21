RSpec.describe Holded::Request do
  subject { described_class.new }

  context 'prueba' do
    it 'prueba' do
      expect {
        subject.execute.requests
      }
    end
  end
end