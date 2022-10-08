RSpec.describe 'Up' do
  describe 'GET /up' do
    it 'returns a 200' do
      get up_url
      expect(response).to have_http_status(:success)
    end
  end
end